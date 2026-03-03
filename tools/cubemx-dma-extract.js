#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

function fail(msg) {
  console.error(`Error: ${msg}`);
  process.exit(1);
}

function parseArgs(argv) {
  const args = {
    db: 'db',
    mcu: '',
    board: '',
    peripheral: '',
    priority: 'medium',
    mode: 'normal',
    format: 'text'
  };

  for (let i = 2; i < argv.length; i += 1) {
    const a = argv[i];
    if (a === '--db') args.db = argv[++i];
    else if (a === '--mcu') args.mcu = argv[++i];
    else if (a === '--board') args.board = argv[++i];
    else if (a === '--peripheral') args.peripheral = (argv[++i] || '').toUpperCase();
    else if (a === '--priority') args.priority = argv[++i];
    else if (a === '--mode') args.mode = argv[++i];
    else if (a === '--format') args.format = argv[++i];
    else if (a === '--help' || a === '-h') {
      console.log([
        'Usage:',
        '  node tools/cubemx-dma-extract.js --mcu STM32F429ZITx --peripheral USART2',
        '  node tools/cubemx-dma-extract.js --board NUCLEO-H743ZI --peripheral USART3',
        '',
        'Options:',
        '  --db <path>        CubeMX db root (default: db)',
        '  --board <name>     Board name token (example: NUCLEO-F429ZI)',
        '  --mcu <name>       MCU name (example: STM32F429ZITx)',
        '  --priority <level> low|medium|high|very-high (default: medium)',
        '  --mode <mode>      normal|circular (default: normal)',
        '  --format <fmt>     text|json (default: text)'
      ].join('\n'));
      process.exit(0);
    }
  }

  if (!args.mcu && !args.board) fail('--mcu or --board is required');
  if (!args.peripheral) fail('--peripheral is required (example: USART2, SPI1, UART4)');
  return args;
}

function readFileOrFail(filePath) {
  try {
    return fs.readFileSync(filePath, 'utf8');
  } catch (err) {
    fail(`cannot read ${filePath}: ${err.message}`);
  }
}

function normalizePeriphName(name) {
  return String(name || '').trim().toUpperCase();
}

function normalizeBoardName(name) {
  return String(name || '').trim().toUpperCase();
}

function findBoardIocByToken(dbRoot, boardToken) {
  const boardsDir = path.join(dbRoot, 'plugins', 'boardmanager', 'boards');
  if (!fs.existsSync(boardsDir)) {
    fail(`board directory not found: ${boardsDir}`);
  }

  const token = normalizeBoardName(boardToken);
  const files = fs.readdirSync(boardsDir).filter((f) => f.endsWith('.ioc'));
  const matches = files.filter((f) => f.toUpperCase().includes(token));
  if (!matches.length) {
    fail(`no board .ioc found matching "${boardToken}" in ${boardsDir}`);
  }

  const preferred = matches.sort((a, b) => {
    const aAll = a.includes('_AllConfig.ioc') ? 0 : 1;
    const bAll = b.includes('_AllConfig.ioc') ? 0 : 1;
    if (aAll !== bAll) return aAll - bAll;
    return a.localeCompare(b);
  })[0];

  return path.join(boardsDir, preferred);
}

function extractIocValue(iocText, key) {
  const re = new RegExp(`^${key}=([^\\r\\n]+)$`, 'm');
  const m = iocText.match(re);
  return m ? m[1].trim() : '';
}

function resolveTargetMcu(args) {
  if (args.mcu) {
    return {
      mcu: args.mcu,
      board: null,
      boardIoc: null
    };
  }

  const boardIoc = findBoardIocByToken(args.db, args.board);
  const iocText = readFileOrFail(boardIoc);
  const mcuFromIoc = extractIocValue(iocText, 'Mcu.Name');
  if (!mcuFromIoc) {
    fail(`Mcu.Name not found in board file: ${boardIoc}`);
  }

  return {
    mcu: mcuFromIoc,
    board: args.board,
    boardIoc
  };
}

function extractAttribute(tag, attr) {
  const m = tag.match(new RegExp(`(?:^|\\s)${attr}="([^"]+)"`));
  return m ? m[1] : '';
}

function extractDmaVersion(mcuXml) {
  const ipRegex = /<IP\b[^>]*Name="(DMA|GPDMA)"[^>]*>/g;
  const candidates = [];
  let match;
  while ((match = ipRegex.exec(mcuXml))) {
    const tag = match[0];
    const name = extractAttribute(tag, 'Name');
    const version = extractAttribute(tag, 'Version');
    if (name && version) candidates.push({ name, version });
  }
  const dma = candidates.find((c) => c.name === 'DMA');
  if (dma) return dma;
  const gpdma = candidates.find((c) => c.name === 'GPDMA');
  if (gpdma) return gpdma;
  return null;
}

function extractAllRefParameterBlocks(xml, paramNamePattern) {
  const out = [];
  const re = /<RefParameter\b([^>]*)>([\s\S]*?)<\/RefParameter>/g;
  let m;
  while ((m = re.exec(xml))) {
    const attrs = m[1] || '';
    const name = extractAttribute(attrs, 'Name').trim();
    const block = m[2] || '';
    if (!name) continue;
    if (paramNamePattern.test(name)) out.push({ name, block });
  }
  return out;
}

function parseGpdmaCandidates(modeXml, peripheral) {
  const periph = peripheral.toUpperCase();
  const reqBlocks = extractAllRefParameterBlocks(modeXml, /^REQUEST_GPDMACH\d+$/);
  if (!reqBlocks.length) return [];

  const out = [];
  for (const { name, block } of reqBlocks) {
    const chMatch = name.match(/^REQUEST_GPDMACH(\d+)$/);
    if (!chMatch) continue;
    const channelIndex = Number(chMatch[1]);
    const values = extractPossibleValues(block);
    for (let idx = 0; idx < values.length; idx += 1) {
      const token = values[idx];
      if (!token.includes(`_${periph}_`)) continue;
      const dir = token.endsWith('_TX') ? 'tx' : (token.endsWith('_RX') ? 'rx' : 'other');
      if (dir === 'other') continue;
      const ctrlMatch = token.match(/^(GPDMA\d+)_REQUEST_/);
      if (!ctrlMatch) continue;

      out.push({
        request: `${periph}_${dir.toUpperCase()}`,
        direction: dir,
        controller: ctrlMatch[1].toLowerCase(),
        stream: channelIndex,
        endpointType: 'channel',
        channel: null,
        requestToken: token,
        requestId: idx
      });
    }
  }

  return out;
}

function extractParamBlock(xml, paramName) {
  const re = new RegExp(`<RefParameter\\b[^>]*(?:\\s|^)Name="${paramName}"[^>]*>([\\s\\S]*?)<\\/RefParameter>`);
  const m = xml.match(re);
  return m ? m[1] : '';
}

function extractPossibleValues(block) {
  const out = [];

  const attrRe = /<PossibleValue\b[^>]*Value="([^"]+)"[^>]*\/?\s*>/g;
  let m;
  while ((m = attrRe.exec(block))) out.push(m[1]);

  const textRe = /<PossibleValue>([^<]+)<\/PossibleValue>/g;
  while ((m = textRe.exec(block))) out.push(m[1].trim());

  return [...new Set(out)];
}

function extractRefModes(modeXml) {
  const out = [];
  const re = /<RefMode\b[^>]*BaseMode="DMA_Request"[^>]*>([\s\S]*?)<\/RefMode>/g;
  let m;
  while ((m = re.exec(modeXml))) {
    const full = m[0];
    const inner = m[1];
    const head = full.match(/<RefMode\b[^>]*>/)?.[0] || '';
    const comment = extractAttribute(head, 'Comment') || extractAttribute(head, 'Name');

    const channelVals = extractPossibleValues((inner.match(/<Parameter\s+Name="Channel"[^>]*>([\s\S]*?)<\/Parameter>/) || [])[1] || '');
    const requestVals = extractPossibleValues((inner.match(/<Parameter\s+Name="Request"[^>]*>([\s\S]*?)<\/Parameter>/) || [])[1] || '');
    const directionVals = extractPossibleValues((inner.match(/<Parameter\s+Name="Direction"[^>]*>([\s\S]*?)<\/Parameter>/) || [])[1] || '');

    out.push({
      name: comment,
      channelVals,
      requestVals,
      directionVals
    });
  }
  return out;
}

function tokenizeModeTags(xml) {
  const tags = [];
  const re = /<\/?Mode\b[^>]*>/g;
  let m;
  while ((m = re.exec(xml))) {
    const raw = m[0];
    const close = raw.startsWith('</');
    const self = /\/>$/.test(raw);
    const name = extractAttribute(raw, 'Name');
    tags.push({ close, self, name, raw, idx: m.index });
  }
  return tags;
}

function expandEndpointPattern(name, endpointValues) {
  if (!name) return [];
  if (/^DMA\d+_(Stream|Channel)\d+$/.test(name)) return [name];

  const parts = name.split(':').map((s) => s.trim()).filter(Boolean);
  const matches = new Set();

  for (const part of parts) {
    if (!part.includes('[')) continue;
    const pattern = '^' + part
      .replace(/[.+?^${}()|\\]/g, '\\$&')
      .replace(/\\\[([0-9]+)-([0-9]+)\\\]/g, '[$1-$2]') + '$';
    const re = new RegExp(pattern);
    for (const s of endpointValues) {
      if (re.test(s)) matches.add(s);
    }
  }

  return [...matches];
}

function buildRequestToEndpoints(modeXml, endpointValues) {
  const requestToEndpoints = new Map();
  const tags = tokenizeModeTags(modeXml);

  const nodeStack = [];
  const endpointStack = [];

  for (const t of tags) {
    if (t.close) {
      const popped = nodeStack.pop();
      if (popped && popped.isEndpointNode) endpointStack.pop();
      continue;
    }

    const expanded = expandEndpointPattern(t.name, endpointValues);
    const isEndpointNode = expanded.length > 0;

    const currentEndpoints = endpointStack.length ? endpointStack[endpointStack.length - 1] : [];

    if (!isEndpointNode && currentEndpoints.length && t.name) {
      const clean = t.name.trim();
      if (/^[A-Z0-9_:\/\-]+$/.test(clean)) {
        if (!requestToEndpoints.has(clean)) requestToEndpoints.set(clean, new Set());
        for (const s of currentEndpoints) requestToEndpoints.get(clean).add(s);

        const base = clean.split(':')[0];
        if (base !== clean) {
          if (!requestToEndpoints.has(base)) requestToEndpoints.set(base, new Set());
          for (const s of currentEndpoints) requestToEndpoints.get(base).add(s);
        }
      }
    }

    nodeStack.push({ isEndpointNode });
    if (isEndpointNode) endpointStack.push(expanded);

    if (t.self) {
      const popped = nodeStack.pop();
      if (popped && popped.isEndpointNode) endpointStack.pop();
    }
  }

  const out = {};
  for (const [k, v] of requestToEndpoints.entries()) out[k] = [...v].sort();
  return out;
}

function directionFromModeName(name, directionVals) {
  if (/_RX$/.test(name)) return 'rx';
  if (/_TX$/.test(name)) return 'tx';
  const one = directionVals[0] || '';
  if (one.includes('PERIPH_TO_MEMORY')) return 'rx';
  if (one.includes('MEMORY_TO_PERIPH')) return 'tx';
  return 'other';
}

function parseChannelNum(channelVals) {
  const first = channelVals[0] || '';
  const m = first.match(/DMA_CHANNEL_(\d+)/);
  return m ? Number(m[1]) : null;
}

function parseRequestToken(requestVals) {
  if (!requestVals.length) return null;
  return requestVals[0];
}

function buildRequestIdMap(modeXml) {
  const requestParam = extractParamBlock(modeXml, 'Request');
  if (!requestParam) return {};

  const values = [];
  const attrRe = /<PossibleValue\b[^>]*Value=\"([^\"]+)\"[^>]*\/?\s*>/g;
  let m;
  while ((m = attrRe.exec(requestParam))) values.push(m[1]);

  const out = {};
  values.forEach((token, index) => {
    out[token] = index;
  });
  return out;
}

function endpointParts(endpointName) {
  let m = endpointName.match(/^DMA(\d+)_Stream(\d+)$/);
  if (m) {
    return {
      controller: `dma${m[1]}`,
      stream: Number(m[2]),
      endpointType: 'stream'
    };
  }
  m = endpointName.match(/^DMA(\d+)_Channel(\d+)$/);
  if (m) {
    return {
      controller: `dma${m[1]}`,
      stream: Number(m[2]),
      endpointType: 'channel'
    };
  }
  return null;
}

function renderZephyrDts(peripheral, tx, rx, priority, mode) {
  const pri = {
    low: 'STM32_DMA_PRIORITY_LOW',
    medium: 'STM32_DMA_PRIORITY_MEDIUM',
    high: 'STM32_DMA_PRIORITY_HIGH',
    'very-high': 'STM32_DMA_PRIORITY_VERY_HIGH'
  }[priority] || 'STM32_DMA_PRIORITY_MEDIUM';

  const modeMacro = {
    normal: 'STM32_DMA_MODE_NORMAL',
    circular: 'STM32_DMA_MODE_CIRCULAR'
  }[mode] || 'STM32_DMA_MODE_NORMAL';

  const periphNode = peripheral.toLowerCase();

  const txComment = tx.requestToken ? ` /* ${tx.requestToken} */` : '';
  const rxComment = rx.requestToken ? ` /* ${rx.requestToken} */` : '';
  const txCell2 = Number.isInteger(tx.channel)
    ? String(tx.channel)
    : (Number.isInteger(tx.requestId) ? String(tx.requestId) : 'REQ_OR_CH_ID_TX');
  const rxCell2 = Number.isInteger(rx.channel)
    ? String(rx.channel)
    : (Number.isInteger(rx.requestId) ? String(rx.requestId) : 'REQ_OR_CH_ID_RX');

  return [
    '/* Candidate snippet generated from STM32CubeMX DB */',
    '/* Cell #2 is DMA channel (legacy) or DMAMUX request id (modern STM32) */',
    `&${periphNode} {`,
    '  status = "okay";',
    `  dmas = <&${tx.controller} ${tx.stream} ${txCell2} (STM32_DMA_MEMORY_TO_PERIPH | ${pri} | ${modeMacro})>${txComment},`,
    `         <&${rx.controller} ${rx.stream} ${rxCell2} (STM32_DMA_PERIPH_TO_MEMORY | ${pri} | ${modeMacro})>${rxComment};`,
    '  dma-names = "tx", "rx";',
    '};'
  ].join('\n');
}

function main() {
  const args = parseArgs(process.argv);
  const target = resolveTargetMcu(args);
  const mcuPath = path.join(args.db, 'mcu', `${target.mcu}.xml`);
  const mcuXml = readFileOrFail(mcuPath);
  const peripheral = normalizePeriphName(args.peripheral);

  const dmaIp = extractDmaVersion(mcuXml);
  if (!dmaIp) {
    const result = {
      mcu: target.mcu,
      board: target.board,
      boardIoc: target.boardIoc,
      peripheral,
      dmaIp: null,
      dmaVersion: null,
      modeFile: null,
      candidates: []
    };
    if (args.format === 'json') {
      console.log(JSON.stringify(result, null, 2));
      return;
    }
    console.log(`MCU: ${target.mcu}`);
    console.log(`Peripheral: ${peripheral}`);
    console.log('No DMA/GPDMA IP found for this MCU.');
    return;
  }

  const modePath = path.join(args.db, 'mcu', 'IP', `${dmaIp.name}-${dmaIp.version}_Modes.xml`);
  if (!fs.existsSync(modePath)) {
    const result = {
      mcu: target.mcu,
      board: target.board,
      boardIoc: target.boardIoc,
      peripheral,
      dmaIp: dmaIp.name,
      dmaVersion: dmaIp.version,
      modeFile: modePath,
      candidates: []
    };
    if (args.format === 'json') {
      console.log(JSON.stringify(result, null, 2));
      return;
    }
    console.log(`MCU: ${target.mcu}`);
    console.log(`Peripheral: ${peripheral}`);
    console.log(`DMA IP: ${dmaIp.name}`);
    console.log(`DMA mode file not found: ${modePath}`);
    return;
  }

  const modeXml = readFileOrFail(modePath);

  const refModes = extractRefModes(modeXml);
  const requestIdMap = buildRequestIdMap(modeXml);

  const expanded = [];
  const instanceParam = extractParamBlock(modeXml, 'Instance');
  const endpointValues = extractPossibleValues(instanceParam).filter((v) => /^DMA\d+_(Stream|Channel)\d+$/.test(v));

  if (endpointValues.length) {
    const requestToEndpoints = buildRequestToEndpoints(modeXml, endpointValues);
    const modeMatches = refModes.filter((m) => m.name.startsWith(`${peripheral}_`));
    if (modeMatches.length) {
      for (const req of modeMatches) {
        const endpoints = requestToEndpoints[req.name] || requestToEndpoints[req.name.split(':')[0]] || [];
        const channel = parseChannelNum(req.channelVals);
        const requestToken = parseRequestToken(req.requestVals);
        const requestId = requestToken && Object.prototype.hasOwnProperty.call(requestIdMap, requestToken)
          ? requestIdMap[requestToken]
          : null;
        const direction = directionFromModeName(req.name, req.directionVals);

        for (const endpointName of endpoints) {
          const parts = endpointParts(endpointName);
          if (!parts) continue;
          expanded.push({
            request: req.name,
            direction,
            controller: parts.controller,
            stream: parts.stream,
            endpointType: parts.endpointType,
            channel,
            requestToken,
            requestId
          });
        }
      }
    }
  } else {
    expanded.push(...parseGpdmaCandidates(modeXml, peripheral));
  }

  const txCandidates = expanded.filter((e) => e.direction === 'tx');
  const rxCandidates = expanded.filter((e) => e.direction === 'rx');

  const result = {
    mcu: target.mcu,
    board: target.board,
    boardIoc: target.boardIoc,
    peripheral,
    dmaIp: dmaIp.name,
    dmaVersion: dmaIp.version,
    modeFile: modePath,
    candidates: expanded
  };

  if (args.format === 'json') {
    console.log(JSON.stringify(result, null, 2));
    return;
  }

  if (target.board) {
    console.log(`Board: ${target.board}`);
    console.log(`Board file: ${target.boardIoc}`);
  }
  console.log(`MCU: ${target.mcu}`);
  console.log(`Peripheral: ${peripheral}`);
  console.log(`DMA IP: ${dmaIp.name}`);
  console.log(`DMA mode file: ${modePath}`);
  console.log('');

  if (!expanded.length) {
    console.log('No stream candidates found in ModeLogic.');
    process.exit(0);
  }

  const byDir = { tx: txCandidates, rx: rxCandidates };
  for (const dir of ['tx', 'rx']) {
    console.log(`${dir.toUpperCase()} candidates:`);
    const list = byDir[dir];
    if (!list.length) {
      console.log('  - none');
      continue;
    }
    for (const c of list) {
      const req = c.requestToken ? ` request=${c.requestToken}` : '';
      const reqId = Number.isInteger(c.requestId) ? ` req_id=${c.requestId}` : '';
      const ch = Number.isInteger(c.channel) ? String(c.channel) : '?';
      const endpointLabel = c.endpointType === 'channel' ? 'channel' : 'stream';
      console.log(`  - ${c.controller} ${endpointLabel}${c.stream} ch${ch}${reqId}${req}`);
    }
    console.log('');
  }

  if (txCandidates.length && rxCandidates.length) {
    const tx = txCandidates[0];
    const rx = rxCandidates[0];
    console.log('Candidate DTS snippet (first TX/RX options):');
    console.log(renderZephyrDts(peripheral, tx, rx, args.priority, args.mode));
  } else {
    console.log('No complete TX+RX pair found for DTS snippet generation.');
  }
}

main();

#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const http = require('http');
const { URL } = require('url');
const { spawn } = require('child_process');

const HOST = process.env.HOST || '0.0.0.0';
const PORT = Number(process.env.PORT || 8080);
const ROOT = path.resolve(__dirname, '..');
const EXTRACTOR = path.join(__dirname, 'cubemx-dma-extract.js');
const MCU_DIR = path.join(ROOT, 'db', 'mcu');
const BOARD_DIR = path.join(ROOT, 'db', 'plugins', 'boardmanager', 'boards');

const MIME = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.txt': 'text/plain; charset=utf-8'
};

const SECURITY_HEADERS = {
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'Referrer-Policy': 'no-referrer'
};

function send(res, status, body, contentType = 'text/plain; charset=utf-8') {
  res.writeHead(status, { 'Content-Type': contentType, 'Cache-Control': 'no-store', ...SECURITY_HEADERS });
  res.end(body);
}

function sendJson(res, status, payload) {
  send(res, status, JSON.stringify(payload, null, 2), 'application/json; charset=utf-8');
}

function toLocalFile(urlPath) {
  const pathname = decodeURIComponent(urlPath === '/' ? '/index.html' : urlPath);
  const full = path.resolve(ROOT, `.${pathname}`);
  if (!full.startsWith(ROOT)) return null;
  return full;
}

function serveStatic(req, res) {
  const file = toLocalFile(new URL(req.url, `http://${req.headers.host}`).pathname);
  if (!file) {
    send(res, 403, 'Forbidden');
    return;
  }
  if (!fs.existsSync(file) || !fs.statSync(file).isFile()) {
    send(res, 404, 'Not found');
    return;
  }
  const ext = path.extname(file).toLowerCase();
  const mime = MIME[ext] || 'application/octet-stream';
  const cacheControl = ext === '.html' ? 'no-cache' : 'public, max-age=3600';
  res.writeHead(200, { 'Content-Type': mime, 'Cache-Control': cacheControl, ...SECURITY_HEADERS });
  fs.createReadStream(file).pipe(res);
}

function readFileHead(filePath, bytes = 4096) {
  const fd = fs.openSync(filePath, 'r');
  try {
    const buf = Buffer.alloc(bytes);
    const count = fs.readSync(fd, buf, 0, bytes, 0);
    return buf.toString('utf8', 0, count);
  } finally {
    fs.closeSync(fd);
  }
}

let catalogCache = null;
let boardCache = null;
const extractCache = new Map();

function buildCatalog() {
  if (catalogCache) return catalogCache;

  const files = fs.readdirSync(MCU_DIR).filter((f) => f.endsWith('.xml'));
  const familyToMcus = new Map();
  const mcuSet = new Set();

  for (const file of files) {
    const mcuName = file.replace(/\.xml$/, '');
    const fullPath = path.join(MCU_DIR, file);
    let head = '';
    try {
      head = readFileHead(fullPath, 4096);
    } catch (_err) {
      continue;
    }

    if (!head.includes('<Mcu ')) continue;
    const family = (head.match(/\bFamily="([^"]+)"/) || [])[1];
    const refName = (head.match(/\bRefName="([^"]+)"/) || [])[1] || mcuName;
    if (!family || !refName) continue;

    if (!familyToMcus.has(family)) familyToMcus.set(family, new Set());
    familyToMcus.get(family).add(refName);
    mcuSet.add(refName);
  }

  const families = [...familyToMcus.keys()].sort();
  const mcusByFamily = {};
  for (const family of families) {
    mcusByFamily[family] = [...familyToMcus.get(family)].sort();
  }

  catalogCache = {
    families,
    mcusByFamily,
    allMcus: [...mcuSet].sort()
  };
  return catalogCache;
}

function extractPeripheralInstances(mcu) {
  const file = path.join(MCU_DIR, `${mcu}.xml`);
  if (!fs.existsSync(file)) return null;
  const xml = fs.readFileSync(file, 'utf8');

  const out = {
    uart: new Set(),
    spi: new Set()
  };

  const re = /<IP\b([^>]*)>/g;
  let m;
  while ((m = re.exec(xml))) {
    const attrs = m[1] || '';
    const instance = (attrs.match(/\bInstanceName="([^"]+)"/) || [])[1] || '';
    const ipName = (attrs.match(/\bName="([^"]+)"/) || [])[1] || '';
    if (!instance || !ipName) continue;
    if ((ipName === 'USART' || ipName === 'UART' || ipName === 'LPUART') && /^((USART|UART|LPUART)\d+)$/i.test(instance)) {
      out.uart.add(instance.toLowerCase());
    } else if (ipName === 'SPI' && /^SPI\d+$/i.test(instance)) {
      out.spi.add(instance.toLowerCase());
    }
  }

  return {
    uart: [...out.uart].sort(),
    spi: [...out.spi].sort()
  };
}

function parseBoardNameFromFilename(fileName) {
  const base = fileName.replace(/\.ioc$/i, '');
  const parts = base.split('_');
  // Typical patterns:
  // A44_Nucleo_NUCLEO-F429ZI_STM32F429ZI_Board_AllConfig
  // G74_Discovery_STM32H745I-DISCO_STM32H745XIH_Board_AllConfig
  if (parts.length >= 3) return parts[2];
  return base;
}

function extractMcuNameFromIoc(iocText) {
  const m = iocText.match(/^Mcu\.Name=([^\r\n]+)$/m);
  return m ? m[1].trim() : '';
}

function buildBoardCatalog() {
  if (boardCache) return boardCache;
  if (!fs.existsSync(BOARD_DIR)) {
    boardCache = [];
    return boardCache;
  }

  const files = fs.readdirSync(BOARD_DIR).filter((f) => f.endsWith('.ioc'));
  const byBoard = new Map();

  for (const file of files) {
    const board = parseBoardNameFromFilename(file);
    const full = path.join(BOARD_DIR, file);
    let iocText = '';
    try {
      iocText = fs.readFileSync(full, 'utf8');
    } catch (_err) {
      continue;
    }
    const mcu = extractMcuNameFromIoc(iocText);
    if (!mcu) continue;

    const existing = byBoard.get(board);
    const preferCurrent = file.includes('_AllConfig.ioc');
    if (!existing || (preferCurrent && !existing.file.includes('_AllConfig.ioc'))) {
      byBoard.set(board, {
        name: board,
        mcu,
        file: path.relative(ROOT, full)
      });
    }
  }

  boardCache = [...byBoard.values()].sort((a, b) => a.name.localeCompare(b.name));
  return boardCache;
}

function parseExtractorArgs(u) {
  const mcu = u.searchParams.get('mcu');
  const board = u.searchParams.get('board');
  const peripheral = u.searchParams.get('peripheral');
  const priority = u.searchParams.get('priority') || 'medium';
  const mode = u.searchParams.get('mode') || 'normal';

  if (!peripheral) return { error: 'Missing required query param: peripheral' };
  if (!mcu && !board) return { error: 'Provide mcu or board query param' };

  const args = [EXTRACTOR, '--db', 'db', '--peripheral', peripheral, '--priority', priority, '--mode', mode, '--format', 'json'];
  if (mcu) args.push('--mcu', mcu);
  if (board) args.push('--board', board);
  return { args };
}

function runExtractor(args) {
  return new Promise((resolve) => {
    const child = spawn(process.execPath, args, {
      cwd: ROOT,
      env: process.env
    });
    let stdout = '';
    let stderr = '';
    let timedOut = false;

    const timer = setTimeout(() => {
      timedOut = true;
      child.kill();
    }, 10000);

    child.stdout.on('data', (chunk) => {
      stdout += chunk.toString();
    });
    child.stderr.on('data', (chunk) => {
      stderr += chunk.toString();
    });

    child.on('close', (code) => {
      clearTimeout(timer);
      resolve({ code: timedOut ? 1 : code, stdout, stderr: timedOut ? 'Extractor timed out after 10s' : stderr });
    });
  });
}

async function handleApi(req, res) {
  const u = new URL(req.url, `http://${req.headers.host}`);

  if (u.pathname === '/api/health') {
    sendJson(res, 200, { ok: true });
    return;
  }

  if (u.pathname === '/api/families') {
    const catalog = buildCatalog();
    sendJson(res, 200, { families: catalog.families });
    return;
  }

  if (u.pathname === '/api/mcus') {
    const catalog = buildCatalog();
    const family = u.searchParams.get('family');
    if (family) {
      sendJson(res, 200, { family, mcus: catalog.mcusByFamily[family] || [] });
      return;
    }
    sendJson(res, 200, { mcus: catalog.allMcus });
    return;
  }

  if (u.pathname === '/api/peripherals') {
    const mcu = u.searchParams.get('mcu');
    if (!mcu) {
      sendJson(res, 400, { error: 'Missing required query param: mcu' });
      return;
    }
    const peripherals = extractPeripheralInstances(mcu);
    if (!peripherals) {
      sendJson(res, 404, { error: `MCU not found: ${mcu}` });
      return;
    }
    sendJson(res, 200, { mcu, peripherals });
    return;
  }

  if (u.pathname === '/api/boards') {
    const boards = buildBoardCatalog();
    const family = u.searchParams.get('family');
    if (!family) {
      sendJson(res, 200, { boards });
      return;
    }
    const catalog = buildCatalog();
    const familyMcus = new Set(catalog.mcusByFamily[family] || []);
    sendJson(res, 200, {
      family,
      boards: boards.filter((b) => familyMcus.has(b.mcu))
    });
    return;
  }

  if (u.pathname !== '/api/extract') {
    sendJson(res, 404, { error: 'Unknown API route' });
    return;
  }

  if (req.method !== 'GET') {
    sendJson(res, 405, { error: 'Method not allowed. Use GET.' });
    return;
  }

  const parsed = parseExtractorArgs(u);
  if (parsed.error) {
    sendJson(res, 400, { error: parsed.error });
    return;
  }

  const cacheKey = `${u.searchParams.get('mcu') || u.searchParams.get('board')}:${u.searchParams.get('peripheral')}`;
  if (extractCache.has(cacheKey)) {
    sendJson(res, 200, extractCache.get(cacheKey));
    return;
  }

  const { code, stdout, stderr } = await runExtractor(parsed.args);
  if (code !== 0) {
    sendJson(res, 400, {
      error: 'Extractor failed',
      details: stderr.trim() || stdout.trim() || `exit code ${code}`
    });
    return;
  }

  try {
    const payload = JSON.parse(stdout);
    extractCache.set(cacheKey, payload);
    sendJson(res, 200, payload);
  } catch (err) {
    sendJson(res, 500, {
      error: 'Extractor returned invalid JSON',
      details: err.message
    });
  }
}

const server = http.createServer(async (req, res) => {
  const u = new URL(req.url, `http://${req.headers.host}`);
  if (u.pathname.startsWith('/api/')) {
    await handleApi(req, res);
    return;
  }
  serveStatic(req, res);
});

server.on('error', (err) => {
  console.error(`Server error: ${err.message}`);
  process.exit(1);
});

console.log('Building MCU and board catalogs...');
buildCatalog();
buildBoardCatalog();

server.listen(PORT, HOST, () => {
  console.log(`DMA helper server running on http://${HOST}:${PORT}`);
  console.log('API examples:');
  console.log(`  http://${HOST}:${PORT}/api/families`);
  console.log(`  http://${HOST}:${PORT}/api/mcus?family=STM32H7`);
  console.log(`  http://${HOST}:${PORT}/api/boards?family=STM32H7`);
  console.log(`  http://${HOST}:${PORT}/api/peripherals?mcu=STM32H743ZITx`);
  console.log(`  http://${HOST}:${PORT}/api/extract?board=NUCLEO-F429ZI&peripheral=USART2`);
  console.log(`  http://${HOST}:${PORT}/api/extract?mcu=STM32H743ZITx&peripheral=USART1`);
});

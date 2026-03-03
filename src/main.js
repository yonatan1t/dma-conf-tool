const BASE_PATH = (() => {
  if (!location.hostname.endsWith('github.io')) return '';
  const firstSegment = location.pathname.split('/').filter(Boolean)[0];
  return firstSegment ? `/${firstSegment}` : '';
})();

function withBase(path) {
  const normalized = path.startsWith('/') ? path : `/${path}`;
  return `${BASE_PATH}${normalized}`;
}

const el = {
  family: document.querySelector('#family'),
  soc: document.querySelector('#soc'),
  ptype: document.querySelector('#ptype'),
  instance: document.querySelector('#instance'),
  txMap: document.querySelector('#tx-map'),
  rxMap: document.querySelector('#rx-map'),
  priority: document.querySelector('#priority'),
  mode: document.querySelector('#mode'),
  generate: document.querySelector('#generate'),
  share: document.querySelector('#share'),
  status: document.querySelector('#status'),
  dbVersion: document.querySelector('#db-version'),
  overlayOut: document.querySelector('#overlay-out'),
  prjconfOut: document.querySelector('#prjconf-out'),
  checksOut: document.querySelector('#checks-out')
};

const state = {
  currentFamily: '',
  familyList: [],
  mcusByFamily: {},
  peripheralsByMcu: {},
  currentMappings: []
};

function setStatus(message, type = '') {
  el.status.textContent = message;
  el.status.className = `status ${type}`.trim();
}

async function apiGet(path) {
  const response = await fetch(withBase(path));
  let payload = null;
  try {
    payload = await response.json();
  } catch (_err) {
    throw new Error(`API did not return JSON for ${path}`);
  }
  if (!response.ok) {
    throw new Error(payload.error ? `${payload.error}: ${payload.details || ''}` : `API request failed: ${path}`);
  }
  return payload;
}

function option(value, label) {
  const opt = document.createElement('option');
  opt.value = value;
  opt.textContent = label;
  return opt;
}

async function loadFamilies() {
  const payload = await apiGet('/api/families');
  state.familyList = payload.families || [];
}

async function loadMcusForFamily(family) {
  if (!state.mcusByFamily[family]) {
    const payload = await apiGet(`/api/mcus?family=${encodeURIComponent(family)}`);
    state.mcusByFamily[family] = payload.mcus || [];
  }
  return state.mcusByFamily[family];
}

async function loadPeripheralsForMcu(mcu) {
  if (!state.peripheralsByMcu[mcu]) {
    const payload = await apiGet(`/api/peripherals?mcu=${encodeURIComponent(mcu)}`);
    state.peripheralsByMcu[mcu] = payload.peripherals || { uart: [], spi: [] };
  }
  return state.peripheralsByMcu[mcu];
}

function fillFamilies() {
  el.family.innerHTML = '';
  state.familyList.forEach((family) => {
    el.family.append(option(family, family));
  });
}

function fillSocs(mcus) {
  el.soc.innerHTML = '';
  mcus.forEach((mcu) => el.soc.append(option(mcu, mcu)));
}

function fillInstances(peripherals) {
  const type = el.ptype.value;
  el.instance.innerHTML = '';
  (peripherals[type] || []).forEach((name) => {
    el.instance.append(option(name, name));
  });
}

function mapLabel(m) {
  const cell2 = Number.isInteger(m.channel)
    ? `ch${m.channel}`
    : (Number.isInteger(m.requestId) ? `req_id=${m.requestId}` : 'req/ch=?');
  const req = m.requestToken ? ` ${m.requestToken}` : '';
  return `${m.controller} stream${m.stream} ${cell2}${req}`;
}

async function fetchMappingsFromExtractor() {
  const mcu = el.soc.value;
  const instance = el.instance.value;
  if (!mcu || !instance) return [];

  const payload = await apiGet(`/api/extract?mcu=${encodeURIComponent(mcu)}&peripheral=${encodeURIComponent(instance.toUpperCase())}`);
  const normalizedPeripheral = instance.toLowerCase();
  return payload.candidates.map((c) => ({
    peripheral: normalizedPeripheral,
    direction: c.direction,
    controller: c.controller,
    stream: c.stream,
    channel: Number.isInteger(c.channel) ? c.channel : null,
    requestId: Number.isInteger(c.requestId) ? c.requestId : null,
    requestToken: c.requestToken || null
  }));
}

async function fillMappings() {
  const instance = el.instance.value;
  if (!instance) {
    state.currentMappings = [];
    el.txMap.innerHTML = '';
    el.rxMap.innerHTML = '';
    el.txMap.append(option('', 'No TX mapping found'));
    el.rxMap.append(option('', 'No RX mapping found'));
    return;
  }

  let mappings = [];
  try {
    mappings = await fetchMappingsFromExtractor();
  } catch (err) {
    state.currentMappings = [];
    el.txMap.innerHTML = '';
    el.rxMap.innerHTML = '';
    el.txMap.append(option('', 'No TX mapping found'));
    el.rxMap.append(option('', 'No RX mapping found'));
    setStatus(`No DMA mapping available: ${err.message}`, 'warn');
    return;
  }
  state.currentMappings = mappings;

  const tx = mappings.filter((m) => m.peripheral === instance && m.direction === 'tx');
  const rx = mappings.filter((m) => m.peripheral === instance && m.direction === 'rx');

  el.txMap.innerHTML = '';
  el.rxMap.innerHTML = '';

  tx.forEach((m, idx) => el.txMap.append(option(String(idx), mapLabel(m))));
  rx.forEach((m, idx) => el.rxMap.append(option(String(idx), mapLabel(m))));

  if (!tx.length) el.txMap.append(option('', 'No TX mapping found'));
  if (!rx.length) el.rxMap.append(option('', 'No RX mapping found'));
}

function renderDmaFlags(direction) {
  const priorityMap = {
    low: 'STM32_DMA_PRIORITY_LOW',
    medium: 'STM32_DMA_PRIORITY_MEDIUM',
    high: 'STM32_DMA_PRIORITY_HIGH',
    'very-high': 'STM32_DMA_PRIORITY_VERY_HIGH'
  };
  const modeMap = {
    normal: 'STM32_DMA_MODE_NORMAL',
    circular: 'STM32_DMA_MODE_CIRCULAR'
  };

  const dirMacro = direction === 'tx' ? 'STM32_DMA_MEMORY_TO_PERIPH' : 'STM32_DMA_PERIPH_TO_MEMORY';
  return `${dirMacro} | ${priorityMap[el.priority.value]} | ${modeMap[el.mode.value]}`;
}

function renderOverlay(instance, txMap, rxMap) {
  const txReqComment = txMap.requestToken ? ` /* ${txMap.requestToken} */` : '';
  const rxReqComment = rxMap.requestToken ? ` /* ${rxMap.requestToken} */` : '';
  const txCell2 = Number.isInteger(txMap.channel)
    ? txMap.channel
    : (Number.isInteger(txMap.requestId) ? txMap.requestId : 'REQ_OR_CH_ID_TX');
  const rxCell2 = Number.isInteger(rxMap.channel)
    ? rxMap.channel
    : (Number.isInteger(rxMap.requestId) ? rxMap.requestId : 'REQ_OR_CH_ID_RX');

  return `/* Generated by Zephyr DMA Config Helper */\n` +
    `&${instance} {\n` +
    `  status = "okay";\n` +
    `  dmas = <&${txMap.controller} ${txMap.stream} ${txCell2} (${renderDmaFlags('tx')})>${txReqComment},\n` +
    `         <&${rxMap.controller} ${rxMap.stream} ${rxCell2} (${renderDmaFlags('rx')})>${rxReqComment};\n` +
    `  dma-names = "tx", "rx";\n` +
    `};\n`;
}

function renderPrjConf() {
  const type = el.ptype.value;
  const lines = [
    '# Generated by Zephyr DMA Config Helper',
    'CONFIG_DMA=y',
    'CONFIG_DMA_STM32=y'
  ];

  if (type === 'uart') {
    lines.push('CONFIG_SERIAL=y');
    lines.push('CONFIG_UART_ASYNC_API=y');
  }
  if (type === 'spi') {
    lines.push('CONFIG_SPI=y');
  }

  return lines.join('\n') + '\n';
}

function validate(instance, txMap, rxMap) {
  const checks = [];
  const warnings = [];
  const errors = [];

  checks.push(`Target family: ${el.family.value}`);
  checks.push(`MCU: ${el.soc.value}`);
  checks.push(`Peripheral: ${instance}`);

  if (!txMap || !rxMap) {
    errors.push('Missing TX and/or RX mapping from extractor output.');
  }

  if (txMap && rxMap && txMap.controller === rxMap.controller && txMap.stream === rxMap.stream) {
    errors.push('TX and RX currently use the same DMA stream. Pick different streams.');
  }

  if (txMap && (txMap.requestToken || Number.isInteger(txMap.requestId))) {
    warnings.push('TX request id is present; verify DMAMUX request line in RM and Zephyr docs.');
  }
  if (rxMap && (rxMap.requestToken || Number.isInteger(rxMap.requestId))) {
    warnings.push('RX request id is present; verify DMAMUX request line in RM and Zephyr docs.');
  }

  checks.push('Verify peripheral node name matches your board DTS (e.g. &usart2).');
  checks.push('Verify DMA controller node is enabled in board DTS.');
  checks.push('Run a build to confirm property/macros accepted by your Zephyr version.');

  return { checks, warnings, errors };
}

function allMappingsFor(instance, direction) {
  return state.currentMappings.filter((m) => m.peripheral === instance && m.direction === direction);
}

function getSelectedMappings() {
  const instance = el.instance.value;
  const tx = allMappingsFor(instance, 'tx')[Number(el.txMap.value)];
  const rx = allMappingsFor(instance, 'rx')[Number(el.rxMap.value)];
  return { tx, rx };
}

function generate() {
  const instance = el.instance.value;
  const { tx, rx } = getSelectedMappings();
  const result = validate(instance, tx, rx);

  if (result.errors.length) {
    el.overlayOut.textContent = '# Cannot generate due to errors\n' + result.errors.map((e) => `- ${e}`).join('\n');
    el.prjconfOut.textContent = '# Fix errors first\n';
    el.checksOut.textContent = [
      'Errors:',
      ...result.errors.map((e) => `- ${e}`),
      '',
      'Warnings:',
      ...(result.warnings.length ? result.warnings.map((w) => `- ${w}`) : ['- none']),
      '',
      'Checks:',
      ...result.checks.map((c) => `- ${c}`)
    ].join('\n');
    setStatus(`Blocked: ${result.errors[0]}`, 'err');
    return;
  }

  el.overlayOut.textContent = renderOverlay(instance, tx, rx);
  el.prjconfOut.textContent = renderPrjConf();
  el.checksOut.textContent = [
    'Warnings:',
    ...(result.warnings.length ? result.warnings.map((w) => `- ${w}`) : ['- none']),
    '',
    'Checks:',
    ...result.checks.map((c) => `- ${c}`)
  ].join('\n');

  setStatus('Snippets generated.', 'ok');
}

function onTabClick(event) {
  const tabBtn = event.target.closest('.tab');
  if (!tabBtn) return;

  const nextTab = tabBtn.dataset.tab;
  document.querySelectorAll('.tab').forEach((t) => t.classList.toggle('active', t === tabBtn));
  document.querySelectorAll('.tab-content').forEach((panel) => panel.classList.toggle('active', panel.id === nextTab));
}

async function copyText(text) {
  await navigator.clipboard.writeText(text);
}

function download(name, content) {
  const blob = new Blob([content], { type: 'text/plain' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = name;
  document.body.append(a);
  a.click();
  a.remove();
  URL.revokeObjectURL(url);
}

function attachOutputActions() {
  document.body.addEventListener('click', async (event) => {
    const copyBtn = event.target.closest('[data-copy]');
    if (copyBtn) {
      const targetId = copyBtn.dataset.copy;
      const source = document.getElementById(targetId);
      try {
        await copyText(source.textContent || '');
        setStatus('Copied to clipboard.', 'ok');
      } catch (_err) {
        setStatus('Clipboard access failed.', 'warn');
      }
      return;
    }

    const dlBtn = event.target.closest('[data-download]');
    if (dlBtn) {
      const kind = dlBtn.dataset.download;
      if (kind === 'overlay') download('dma.overlay', el.overlayOut.textContent || '');
      if (kind === 'prjconf') download('prj.conf', el.prjconfOut.textContent || '');
      if (kind === 'checks') download('dma-checks.txt', el.checksOut.textContent || '');
      setStatus('File downloaded.', 'ok');
    }
  });
}

function toQuery() {
  const params = new URLSearchParams({
    family: el.family.value,
    soc: el.soc.value,
    ptype: el.ptype.value,
    instance: el.instance.value,
    tx: el.txMap.value,
    rx: el.rxMap.value,
    priority: el.priority.value,
    mode: el.mode.value
  });
  return `${location.origin}${location.pathname}?${params.toString()}`;
}

function restoreFromQuery() {
  return new URLSearchParams(location.search);
}

async function refreshForFamily(query = null) {
  state.currentFamily = el.family.value;
  const mcus = await loadMcusForFamily(state.currentFamily);
  fillSocs(mcus);

  if (query && query.get('soc') && mcus.includes(query.get('soc'))) {
    el.soc.value = query.get('soc');
  }

  const peripherals = await loadPeripheralsForMcu(el.soc.value);
  if (query && query.get('ptype')) el.ptype.value = query.get('ptype');
  fillInstances(peripherals);

  const instances = peripherals[el.ptype.value] || [];
  if (query && query.get('instance') && instances.includes(query.get('instance'))) {
    el.instance.value = query.get('instance');
  }

  await fillMappings();

  if (query) {
    if (query.get('tx')) el.txMap.value = query.get('tx');
    if (query.get('rx')) el.rxMap.value = query.get('rx');
    if (query.get('priority')) el.priority.value = query.get('priority');
    if (query.get('mode')) el.mode.value = query.get('mode');
  }

  el.dbVersion.textContent = `Families: ${state.familyList.length} (live CubeMX DB)`;
}

async function init() {
  await loadFamilies();
  if (!state.familyList.length) {
    throw new Error('No STM32 families found in db/mcu');
  }

  fillFamilies();

  const query = restoreFromQuery();
  const requestedFamily = query.get('family');
  if (requestedFamily && state.familyList.includes(requestedFamily)) {
    el.family.value = requestedFamily;
  } else {
    el.family.value = state.familyList[0];
  }

  await refreshForFamily(query);

  el.family.addEventListener('change', () => refreshForFamily().then(generate).catch((err) => setStatus(err.message, 'err')));

  el.soc.addEventListener('change', async () => {
    try {
      const peripherals = await loadPeripheralsForMcu(el.soc.value);
      fillInstances(peripherals);
      await fillMappings();
      generate();
    } catch (err) {
      setStatus(err.message, 'err');
    }
  });

  el.ptype.addEventListener('change', () => {
    loadPeripheralsForMcu(el.soc.value)
      .then((peripherals) => {
        fillInstances(peripherals);
        return fillMappings();
      })
      .then(generate)
      .catch((err) => setStatus(err.message, 'err'));
  });

  el.instance.addEventListener('change', () => fillMappings().then(generate).catch((err) => setStatus(err.message, 'err')));

  el.generate.addEventListener('click', generate);
  el.share.addEventListener('click', async () => {
    try {
      await copyText(toQuery());
      setStatus('Share link copied.', 'ok');
    } catch (_err) {
      setStatus('Share link copy failed.', 'warn');
    }
  });

  document.querySelector('.tabs').addEventListener('click', onTabClick);
  attachOutputActions();
  generate();
}

init().catch((err) => {
  setStatus(err.message, 'err');
  el.overlayOut.textContent = '# Failed to initialize app\n' + String(err.message || err);
});

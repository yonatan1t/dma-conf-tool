#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const DB_MCU_DIR = path.join(ROOT, 'db', 'mcu');
const EXTRACTOR = path.join(__dirname, 'cubemx-dma-extract.js');

function parseArgs(argv) {
  const out = {
    concurrency: 12,
    maxMcus: 0
  };
  for (let i = 2; i < argv.length; i += 1) {
    const a = argv[i];
    if (a === '--concurrency') out.concurrency = Number(argv[++i] || out.concurrency);
    else if (a === '--max-mcus') out.maxMcus = Number(argv[++i] || 0);
  }
  return out;
}

function extractPeripheralsFromMcuXml(xml) {
  const out = new Set();
  const re = /<IP\b[^>]*InstanceName="([^"]+)"[^>]*Name="([^"]+)"[^>]*\/>/g;
  let m;
  while ((m = re.exec(xml))) {
    const instance = m[1] || '';
    const ipName = m[2] || '';
    if ((ipName === 'USART' || ipName === 'UART' || ipName === 'LPUART') && /^((USART|UART|LPUART)\d+)$/i.test(instance)) {
      out.add(instance.toUpperCase());
    }
    if (ipName === 'SPI' && /^SPI\d+$/i.test(instance)) {
      out.add(instance.toUpperCase());
    }
  }
  return [...out];
}

function runExtractor(mcu, peripheral) {
  return new Promise((resolve) => {
    const child = spawn(process.execPath, [EXTRACTOR, '--mcu', mcu, '--peripheral', peripheral, '--format', 'json'], {
      cwd: ROOT,
      env: process.env
    });
    let stdout = '';
    let stderr = '';
    child.stdout.on('data', (d) => { stdout += d.toString(); });
    child.stderr.on('data', (d) => { stderr += d.toString(); });
    child.on('close', (code) => {
      if (code !== 0) {
        resolve({ ok: false, mcu, peripheral, code, error: (stderr || stdout).trim() });
        return;
      }
      try {
        const payload = JSON.parse(stdout);
        resolve({
          ok: true,
          mcu,
          peripheral,
          candidates: Array.isArray(payload.candidates) ? payload.candidates.length : 0
        });
      } catch (err) {
        resolve({ ok: false, mcu, peripheral, code: 0, error: `invalid json: ${err.message}` });
      }
    });
  });
}

async function runPool(items, concurrency, worker) {
  const results = [];
  let idx = 0;

  async function loop() {
    while (idx < items.length) {
      const current = items[idx];
      idx += 1;
      results.push(await worker(current));
    }
  }

  const threads = [];
  for (let i = 0; i < Math.max(1, concurrency); i += 1) threads.push(loop());
  await Promise.all(threads);
  return results;
}

async function main() {
  const args = parseArgs(process.argv);
  const files = fs.readdirSync(DB_MCU_DIR).filter((f) => f.endsWith('.xml')).sort();
  const mcuNames = (args.maxMcus > 0 ? files.slice(0, args.maxMcus) : files).map((f) => f.replace(/\.xml$/, ''));

  const combos = [];
  for (const mcu of mcuNames) {
    const xmlPath = path.join(DB_MCU_DIR, `${mcu}.xml`);
    let xml = '';
    try {
      xml = fs.readFileSync(xmlPath, 'utf8');
    } catch (_err) {
      continue;
    }
    if (!xml.includes('<Mcu ')) continue;
    const periphs = extractPeripheralsFromMcuXml(xml);
    for (const p of periphs) combos.push({ mcu, peripheral: p });
  }

  console.log(`Sweeping ${combos.length} MCU/peripheral combos across ${mcuNames.length} MCUs...`);
  const started = Date.now();
  const results = await runPool(combos, args.concurrency, (c) => runExtractor(c.mcu, c.peripheral));
  const elapsed = ((Date.now() - started) / 1000).toFixed(1);

  const failed = results.filter((r) => !r.ok);
  const withCandidates = results.filter((r) => r.ok && r.candidates > 0);
  const empty = results.filter((r) => r.ok && r.candidates === 0);

  console.log(`Done in ${elapsed}s`);
  console.log(`Total: ${results.length}`);
  console.log(`OK with candidates: ${withCandidates.length}`);
  console.log(`OK empty: ${empty.length}`);
  console.log(`Failed: ${failed.length}`);

  if (failed.length) {
    console.log('\nFirst failures:');
    for (const f of failed.slice(0, 20)) {
      console.log(`- ${f.mcu} ${f.peripheral}: ${f.error}`);
    }
    process.exit(1);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});

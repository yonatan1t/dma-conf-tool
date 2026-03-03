const test = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const net = require('node:net');
const { spawn } = require('node:child_process');

const ROOT = path.resolve(__dirname, '..');
const SERVER = path.join(ROOT, 'tools', 'web-server.js');

function getFreePort() {
  return new Promise((resolve, reject) => {
    const srv = net.createServer();
    srv.listen(0, '127.0.0.1', () => {
      const addr = srv.address();
      const port = addr && typeof addr === 'object' ? addr.port : null;
      srv.close((err) => {
        if (err) reject(err);
        else resolve(port);
      });
    });
    srv.on('error', reject);
  });
}

async function waitForHealth(baseUrl, timeoutMs = 15000) {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    try {
      const r = await fetch(`${baseUrl}/api/health`);
      if (r.ok) return;
    } catch (_err) {
      // server not ready yet
    }
    await new Promise((r) => setTimeout(r, 150));
  }
  throw new Error('server did not become healthy in time');
}

test('web server: catalog and extractor endpoints work', { timeout: 60000 }, async (t) => {
  const port = await getFreePort();
  const baseUrl = `http://127.0.0.1:${port}`;

  const proc = spawn(process.execPath, [SERVER], {
    cwd: ROOT,
    env: { ...process.env, HOST: '127.0.0.1', PORT: String(port) },
    stdio: ['ignore', 'pipe', 'pipe']
  });

  let stderr = '';
  proc.stderr.on('data', (d) => {
    stderr += d.toString();
  });

  t.after(() => {
    if (!proc.killed) proc.kill('SIGTERM');
  });

  await waitForHealth(baseUrl);

  const fam = await fetch(`${baseUrl}/api/families`).then((r) => r.json());
  assert.ok(Array.isArray(fam.families));
  assert.ok(fam.families.includes('STM32F4'));
  assert.ok(fam.families.includes('STM32H7'));

  const per = await fetch(`${baseUrl}/api/peripherals?mcu=STM32C011D6Yx`).then((r) => r.json());
  assert.ok(per.peripherals.uart.includes('usart1'));

  const okExtractRes = await fetch(`${baseUrl}/api/extract?mcu=STM32C011D6Yx&peripheral=USART1`);
  assert.equal(okExtractRes.status, 200, stderr);
  const okExtract = await okExtractRes.json();
  assert.ok(okExtract.candidates.length > 0);
  assert.ok(okExtract.candidates.every((c) => c.endpointType === 'channel'));

  const badExtractRes = await fetch(`${baseUrl}/api/extract?mcu=STM32F429ZITx`);
  assert.equal(badExtractRes.status, 400);
  const badExtract = await badExtractRes.json();
  assert.match(badExtract.error, /Missing required query param: peripheral/);
});

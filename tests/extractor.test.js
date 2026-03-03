const test = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const path = require('node:path');

const ROOT = path.resolve(__dirname, '..');
const EXTRACTOR = path.join(ROOT, 'tools', 'cubemx-dma-extract.js');

function runExtractor(args) {
  const proc = spawnSync(process.execPath, [EXTRACTOR, '--format', 'json', ...args], {
    cwd: ROOT,
    encoding: 'utf8'
  });
  return proc;
}

function parseJsonStdout(proc) {
  assert.equal(proc.status, 0, `extractor failed: ${proc.stderr || proc.stdout}`);
  return JSON.parse(proc.stdout);
}

test('extractor: STM32C011D6Yx USART1 supports channel-style DMA endpoints', () => {
  const proc = runExtractor(['--mcu', 'STM32C011D6Yx', '--peripheral', 'USART1']);
  const data = parseJsonStdout(proc);

  assert.equal(data.mcu, 'STM32C011D6Yx');
  assert.ok(Array.isArray(data.candidates) && data.candidates.length > 0);
  assert.ok(data.candidates.some((c) => c.direction === 'tx'));
  assert.ok(data.candidates.some((c) => c.direction === 'rx'));
  assert.ok(data.candidates.every((c) => c.endpointType === 'channel'));
});

test('extractor: STM32H743ZITx USART1 supports stream-style DMA endpoints', () => {
  const proc = runExtractor(['--mcu', 'STM32H743ZITx', '--peripheral', 'USART1']);
  const data = parseJsonStdout(proc);

  assert.equal(data.mcu, 'STM32H743ZITx');
  assert.ok(Array.isArray(data.candidates) && data.candidates.length > 0);
  assert.ok(data.candidates.some((c) => c.direction === 'tx'));
  assert.ok(data.candidates.some((c) => c.direction === 'rx'));
  assert.ok(data.candidates.every((c) => c.endpointType === 'stream'));
});

test('extractor: STM32H503CBTx USART1 supports GPDMA channel candidates', () => {
  const proc = runExtractor(['--mcu', 'STM32H503CBTx', '--peripheral', 'USART1']);
  const data = parseJsonStdout(proc);

  assert.equal(data.mcu, 'STM32H503CBTx');
  assert.equal(data.dmaIp, 'GPDMA');
  assert.ok(Array.isArray(data.candidates) && data.candidates.length > 0);
  assert.ok(data.candidates.some((c) => c.direction === 'tx'));
  assert.ok(data.candidates.some((c) => c.direction === 'rx'));
  assert.ok(data.candidates.every((c) => c.controller.startsWith('gpdma')));
});

test('extractor: --board resolves to expected MCU', () => {
  const proc = runExtractor(['--board', 'NUCLEO-F429ZI', '--peripheral', 'USART2']);
  const data = parseJsonStdout(proc);

  assert.equal(data.board, 'NUCLEO-F429ZI');
  assert.equal(data.mcu, 'STM32F429ZITx');
  assert.ok(data.boardIoc && data.boardIoc.includes('NUCLEO-F429ZI'));
});

test('extractor: invalid peripheral returns non-zero status', () => {
  const proc = runExtractor(['--mcu', 'STM32F429ZITx', '--peripheral', 'NOT_A_PERIPH']);
  const data = parseJsonStdout(proc);
  assert.ok(Array.isArray(data.candidates));
  assert.equal(data.candidates.length, 0);
});

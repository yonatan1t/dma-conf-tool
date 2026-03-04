# Zephyr DMA Config Helper

A web tool to help embedded developers generate STM32 + Zephyr DMA snippets for UART/SPI.

**Live app: [dma-conf-tool.onrender.com](https://dma-conf-tool.onrender.com)**

## Features (MVP)

- Select STM32 family/MCU/peripheral instance
- Pick TX/RX DMA mappings from live CubeMX DB extraction (`tools/cubemx-dma-extract.js`)
- Generate `*.overlay` snippet
- Generate `prj.conf` additions
- Show warnings and verification checklist
- Copy/download outputs
- Copy a shareable URL for current config

## Run locally (with extractor API)

From the repository root:

```bash
node tools/web-server.js
```

Open `http://127.0.0.1:8080`.

This serves:

- Static UI (`/`)
- Catalog API (`/api/families`, `/api/mcus`, `/api/peripherals`)
- Extractor API (`/api/extract`) backed by `tools/cubemx-dma-extract.js`

## Deploy on Render (free)

This repo includes `render.yaml` and a `start` script, so you can deploy directly from GitHub:

1. Push this repo to GitHub.
2. In Render, create a new Blueprint and select the repo.
3. Render will provision one free web service and run:
   - Build: `npm install`
   - Start: `npm start`

Examples:

```bash
curl "http://127.0.0.1:8080/api/health"
curl "http://127.0.0.1:8080/api/families"
curl "http://127.0.0.1:8080/api/mcus?family=STM32H7"
curl "http://127.0.0.1:8080/api/peripherals?mcu=STM32H743ZITx"
curl "http://127.0.0.1:8080/api/extract?board=NUCLEO-F429ZI&peripheral=USART2"
curl "http://127.0.0.1:8080/api/extract?mcu=STM32H743ZITx&peripheral=USART1"
```

## Tests

Run the automated tests:

```bash
npm test
```

This validates:
- extractor on stream-based DMA MCUs
- extractor on channel-based DMA MCUs
- board-to-MCU resolution
- web API catalog/extract endpoints

Run a broad robustness sweep across the CubeMX DB:

```bash
npm run sweep
```

This executes extractor calls across MCU + UART/SPI instance combinations and reports:
- `OK with candidates`
- `OK empty` (valid combination with no DMA candidates)
- `Failed` (should be `0`)

## Deploy note

The UI now calls `/api/extract`, so pure static hosting (GitHub Pages only) is not enough by itself.
Use a runtime that can execute `node tools/web-server.js` (or implement an equivalent backend endpoint).

## Data files

- `data/stm32f4.json`
- `data/stm32h7.json`

Update or extend mappings here as you add more SoCs/peripherals.

## Important

Generated snippets are a starting point.
Always verify against:

- Your board DTS
- STM32 reference manual / DMA mapping tables
- Your Zephyr version docs/macros

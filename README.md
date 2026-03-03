# Zephyr DMA Config Helper

A static web tool to help embedded developers generate STM32 + Zephyr DMA snippets for UART/SPI.

## Features (MVP)

- Select STM32 family/SoC/peripheral instance
- Pick TX/RX DMA mappings from a curated local DB
- Generate `*.overlay` snippet
- Generate `prj.conf` additions
- Show warnings and verification checklist
- Copy/download outputs
- Copy a shareable URL for current config

## Run locally

From the repository root:

```bash
python3 -m http.server 8080
```

Open `http://localhost:8080`.

## Deploy to GitHub Pages

This repo includes `.github/workflows/deploy-pages.yml`.

1. Push to `main`
2. In GitHub repo settings:
   - Enable Pages
   - Source: GitHub Actions
3. The workflow publishes the static site automatically.

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

# my-first-web-static-app

A collection of standalone, single-file interactive HTML pages (dashboards, decks, flowcharts, 3D demos) hosted as an [Azure Static Web App](https://azure.microsoft.com/en-us/products/app-service/static). The root [index.html](index.html) is an auto-generated card-grid hub that links every page in the repo.

**Live site:** [polite-water-0d2260e10.6.azurestaticapps.net](https://polite-water-0d2260e10.6.azurestaticapps.net/)

## How it works

- Every `*.html` file in the repo root is a self-contained page (Tailwind + Font Awesome via CDN, no build step).
- [`build-menu.ps1`](build-menu.ps1) scans the root for `*.html` files (excluding `index.html`), pulls each page's `<title>` and last-modified date, and regenerates `index.html` as a sorted card grid.
- A push to `main` triggers two workflows:
  1. [`build-menu.yml`](.github/workflows/build-menu.yml) — runs `build-menu.ps1`, commits the refreshed `index.html` back to `main` as `chore: rebuild menu (auto)`.
  2. [`azure-static-web-apps-...yml`](.github/workflows/azure-static-web-apps-polite-water-0d2260e10.yml) — deploys the static site to Azure.

> `index.html` is auto-generated. Do not edit it by hand — changes will be overwritten on the next build.

## Adding a new page

1. Drop a self-contained `*.html` file into the repo root. Make sure it has a sensible `<title>` — that's what shows up as the card title.
2. Commit and push to `main`. The menu workflow rebuilds `index.html` automatically; no manual menu edit needed.

## Local menu rebuild (optional)

```powershell
./build-menu.ps1
```

Writes a fresh `index.html` in place.

## Auto-push helper

[`auto-push.ps1`](auto-push.ps1) is a small PowerShell scheduled-task script that watches a hard-coded list of files (currently the NPI AI Process Map pages), and commits + pushes them with a dated `chore: update ...` message when they change. Edit the `$files` array to extend coverage. Output is appended to `auto-push.log`.

## Current pages (18)

| File | Title |
| --- | --- |
| [AMD_SP7_Venice_Platform_Overview.html](AMD_SP7_Venice_Platform_Overview.html) | AMD EPYC "Venice" SP7 Platform Overview |
| [CE_OnBoarding_v0.html](CE_OnBoarding_v0.html) | CE 部門 新人 On-Boarding 課程目錄 |
| [ComponentLifeCycle_v1.0.html](ComponentLifeCycle_v1.0.html) | 零件生命週期影響因素查詢系統 |
| [DomainFocusAI001.html](DomainFocusAI001.html) | Domain AI Use Case 互動導覽 |
| [EOL_Risk_Management_Dashboard.html](EOL_Risk_Management_Dashboard.html) | 零件 EOL 風險管理與改善計畫儀表板 |
| [HongKong_Symphony.html](HongKong_Symphony.html) | Hong Kong: Dragon Harbour |
| [NO_EOL_Dashboard.html](NO_EOL_Dashboard.html) | Est. EOL Date 異常料號分析儀表板 |
| [NPI_AI_Process_Map.html](NPI_AI_Process_Map.html) | NPI AI Tools Process Map |
| [NPI_AI_Process_Map_3D.html](NPI_AI_Process_Map_3D.html) | NPI AI Tools — 3D Process Pyramid |
| [Rule001_EOL_Risk_Credibility_Flowchart.html](Rule001_EOL_Risk_Credibility_Flowchart.html) | Rule-001 停產風險可信度 — 檢核流程圖 |
| [Rule002_Lifecycle_Status_Flowchart.html](Rule002_Lifecycle_Status_Flowchart.html) | Rule-002 零件生命週期狀態 — 檢核流程圖 |
| [Rule004_Alt_Part_Avail_Flowchart.html](Rule004_Alt_Part_Avail_Flowchart.html) | Rule-004 替代料可用性 — 檢核流程圖 |
| [Rule_Registry_Architecture_Deck.html](Rule_Registry_Architecture_Deck.html) | Rule Registry Architecture · 96階 BOM 零件風險評估規則架構 |
| [fabless-foundry-map.html](fabless-foundry-map.html) | Fabless IC Vendor → Foundry Map (Top-10 Foundries used by Fabless Vendors) |
| [fan_lifecycle.html](fan_lifecycle.html) | PC系統風扇生命週期與供應鏈分析報告 |
| [st-global-production-plan.html](st-global-production-plan.html) | STMicroelectronics — Global Production Plan (Manufacturing Reshaping Program) |
| [ti_dashboard.html](ti_dashboard.html) | TI × Advantech Dashboard Prototype (v2) |
| [vda_5050_demo.html](vda_5050_demo.html) | VDA 5050 3D 互動教學 |

## Repo layout

```
.
├── *.html                 # individual pages (one per topic)
├── index.html             # auto-generated hub (do not edit)
├── build-menu.ps1         # menu generator
├── auto-push.ps1          # scheduled-task auto-commit helper
└── .github/workflows/
    ├── build-menu.yml                                # rebuilds index.html on push
    └── azure-static-web-apps-polite-water-...yml     # deploys to Azure SWA
```

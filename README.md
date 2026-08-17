 # 560005.town // edit

The data backend for [560005.town](https://560005.town) — the canonical listings data plus the pipeline that publishes it to [Cloudflare D1](https://developers.cloudflare.com/d1/).

CSV files in `data/` are the single source of truth; edit them via git. On every push to `main`, a [babashka](https://babashka.org) script (`bin/build-db`) compiles the CSVs into a local SQLite database, and the [deploy workflow](https://github.com/560005/edit/blob/main/.github/workflows/deploy.yml) loads that into the D1 database `560005-town` (a full replace each run). It then triggers a rebuild of [560005/home](https://github.com/560005/home), which reads D1 at build time and deploys the static site to Cloudflare Pages.

Datasette on Fly used to serve this data at `edit.560005.town`; that was retired in Aug 2026 when Fly shut down its BOM region, and the pipeline moved to D1 (no admin UI — edit via CSV/git).

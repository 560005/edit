 # 560005.town // edit

The data backend for [560005.town](https://560005.town) — a [Datasette](https://datasette.io) instance serving [560005.town](https://560005.town/).

CSV files in `data/` are the canonical source of truth. However, the syncing is bidirectional and any changes made on datasette are periodically pulled into the CSV files [every day](https://github.com/560005/edit/blob/main/.github/workflows/export.yml). A [babashka](https://babashka.org) script (`bin/build-db`) compiles them into a SQLite database, which Datasette serves at [edit.560005.town](https://edit.560005.town). The frontend lives in [560005/home](https://github.com/560005/home).

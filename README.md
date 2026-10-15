# TCLF Funding Networks

Interactive network maps of textile and fashion research funding in which Dutch
organisations take part (NWO/SIA, Erasmus+ and CORDIS: FP7, H2020, Horizon
Europe), plus the tools that build their data.

This repository is where the maps and their data are made. The finished pages
and data files are published on the M-DPP website, [m-dpp.nl](https://m-dpp.nl),
by copying them into [MDPP-ops/MDPP_Website](https://github.com/MDPP-ops/MDPP_Website)
(see [Publishing](#publishing-to-m-dppnl)).

## What's here

| File | What it is |
|---|---|
| `nl_funding_network.html` | All sources combined: NWO, Erasmus+ and CORDIS projects with a Dutch partner |
| `eu_textile_network.html` | Erasmus+ and CORDIS projects, with an "NL Partners only" switch |
| `eu_textile_network_Bak.html` | Backup of an earlier version of the EU page |
| `nwo_textile_network.html` | NWO projects, filtered to fashion and textile |
| `nwo_textile_raw_network.html` | All NWO projects from the raw keyword search |
| `fetch_cordis_bulk.py` | Downloads the CORDIS open-data exports and writes `cordis_textile_projects.json` |
| `fetch_erasmus_bulk.py` | Downloads the Erasmus+ project lists and writes `erasmus_textile_projects.json` |
| `parse_cordis_cache.py` | Rebuilds `cordis_textile_projects.json` from already-downloaded CORDIS files |
| `parse_erasmus_cache.py` | Rebuilds `erasmus_textile_projects.json` from already-downloaded Erasmus+ files |
| `*.json` | The data the pages load |
| `copy-to-site.sh` | Copies the pages and data into a checkout of the website |

## Updating the data

The fetch scripts declare their own dependencies, so [uv](https://docs.astral.sh/uv/)
runs them directly:

```bash
uv run fetch_cordis_bulk.py      # Horizon Europe + H2020; add --include-fp7 for FP7
uv run fetch_erasmus_bulk.py
```

Downloads are kept in `cordis_cache/` and `erasmus_cache/` (not committed) and
reused for 7 days. To re-filter what is already downloaded, for example after
changing the keyword list, run the parse scripts instead:

```bash
python3 parse_cordis_cache.py    # needs openpyxl
python3 parse_erasmus_cache.py
```

The NWO files (`nwo_textile_raw.json`, `nwo_fashion_textile_filtered.json`)
were made with a script that is not in this repository yet.

## Viewing the pages locally

The pages load their data with `fetch()`, which browsers block for files opened
straight from disk. Serve the folder instead:

```bash
python3 -m http.server
# then open http://localhost:8000/nl_funding_network.html
```

## Publishing to m-dpp.nl

```bash
./copy-to-site.sh ../MDPP_Website
```

This copies the four pages and four data files to the root of the website
checkout, at the same addresses as before. Commit and push there, and GitHub
Pages republishes the site. The scripts stay here and are not published.

## Page weight

On a first visit, `nl_funding_network.html` downloads about 15 MB (compressed)
and the EU pages about 11 MB. The NL page then discards most of the EU data:
it keeps 6% of the Erasmus+ projects and 24% of the CORDIS projects. Writing
Dutch-only data files for that page would cut its first visit to about 6 MB.

## History

Split out of `MDPP-ops/MDPP_Website` on 15 October 2026, keeping the history
of these files (April–May 2026).

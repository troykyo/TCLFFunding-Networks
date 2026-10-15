#!/usr/bin/env bash
# Copy the published pages and data into a checkout of the M-DPP website.
# Usage: ./copy-to-site.sh /path/to/MDPP_Website
set -euo pipefail

site="${1:?Usage: $0 /path/to/MDPP_Website}"
if [[ ! -f "$site/_config.yml" || ! -f "$site/CNAME" ]]; then
  echo "$site does not look like the website checkout (no _config.yml or CNAME)." >&2
  exit 1
fi

cd "$(dirname "$0")"
files=(
  nl_funding_network.html
  eu_textile_network.html
  nwo_textile_network.html
  nwo_textile_raw_network.html
  cordis_textile_projects.json
  erasmus_textile_projects.json
  nwo_textile_raw.json
  nwo_fashion_textile_filtered.json
)
cp -v "${files[@]}" "$site/"
echo "Done. Commit and push in $site to publish."

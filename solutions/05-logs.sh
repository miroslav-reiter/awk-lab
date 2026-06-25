#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "1. IP adresy"
awk '{ print $1 }' data/access.log

echo
echo "2. HTTP metoda a URL"
awk '{ print $6, $7 }' data/access.log

echo
echo "3. Stavovy kod"
awk '{ print $9 }' data/access.log

echo
echo "4. Pocet IP adries"
awk '{ count[$1]++ } END { for (ip in count) print ip, count[ip] }' data/access.log

echo
echo "5. Pocet stavovych kodov"
awk '{ count[$9]++ } END { for (code in count) print code, count[code] }' data/access.log

echo
echo "6. Chybove odpovede 4xx alebo 5xx"
awk '$9 ~ /^[45][0-9][0-9]$/ { print }' data/access.log

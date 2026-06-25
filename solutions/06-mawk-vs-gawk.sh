#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "1. Cesta k awk"
which awk || true

echo
echo "2. mawk/Kali styl verzia"
awk -W version 2>/dev/null || true

echo
echo "3. gawk/Ubuntu styl verzia"
awk --version 2>/dev/null || true

echo
echo "4. Prenositelny prikaz"
awk -F, 'NR > 1 { print $1, $4 }' data/employees.csv

echo
echo "5. Samostatny gawk"
gawk --version 2>/dev/null || echo "gawk nie je dostupny ako samostatny prikaz"

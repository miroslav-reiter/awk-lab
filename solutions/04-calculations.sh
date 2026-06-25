#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "1. Sucet scores.txt"
awk '{ sum += $1 } END { print sum }' data/scores.txt

echo
echo "2. Priemer scores.txt"
awk '{ sum += $1; count++ } END { print sum / count }' data/scores.txt

echo
echo "3. Celkovy obrat"
awk -F, 'NR > 1 { sum += $4 } END { print sum }' data/sales.csv

echo
echo "4. Obrat SK"
awk -F, 'NR > 1 && $3 == "SK" { sum += $4 } END { print sum }' data/sales.csv

echo
echo "5. Najvyssi plat"
awk -F, 'NR == 2 { max = $4; name = $1 } NR > 2 && $4 > max { max = $4; name = $1 } END { print name, max }' data/employees.csv

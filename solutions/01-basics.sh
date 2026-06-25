#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "1. Cely subor employees.csv"
awk '{ print }' data/employees.csv

echo
echo "2. Prvych 5 riadkov passwd.sample"
awk 'NR <= 5 { print }' data/passwd.sample

echo
echo "3. Cislo riadku a hodnota"
awk '{ print NR, $0 }' data/scores.txt

echo
echo "4. Riadky 2 az 4"
awk 'NR >= 2 && NR <= 4 { print }' data/employees.csv

echo
echo "5. Posledny spracovany riadok"
awk '{ last = $0 } END { print last }' data/employees.csv

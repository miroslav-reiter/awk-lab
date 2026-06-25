#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "1. Zamestnanci z IT"
awk -F, '$2 == "IT" { print }' data/employees.csv

echo
echo "2. Plat aspon 3000"
awk -F, 'NR > 1 && $4 >= 3000 { print $1, $4 }' data/employees.csv

echo
echo "3. Pouzivatelia s bash shellom"
awk -F: '$7 == "/bin/bash" { print $1, $7 }' data/passwd.sample

echo
echo "4. Stav 404 alebo 500"
awk '$9 == 404 || $9 == 500 { print }' data/access.log

echo
echo "5. CPU viac ako 2"
awk 'NR > 1 && $3 > 2 { print $1, $3, $5 }' data/processes.txt

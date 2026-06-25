#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "1. Meno a plat"
awk -F, 'NR > 1 { print $1, $4 }' data/employees.csv

echo
echo "2. Pouzivatel, UID a shell"
awk -F: '{ print $1, $3, $7 }' data/passwd.sample

echo
echo "3. Pouzivatel a prikaz"
awk 'NR > 1 { print $1, $5 }' data/processes.txt

echo
echo "4. Pocet poli"
awk -F, '{ print NR, NF, $0 }' data/employees.csv

echo
echo "5. Posledne pole"
awk -F: '{ print $NF }' data/passwd.sample

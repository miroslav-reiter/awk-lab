# 03 - Filtrovanie riadkov

Cieľ: použijeme podmienky, porovnania a regulárne výrazy.

## Úlohy

1. Vypíšte zamestnancov z oddelenia IT.
2. Vypíšte zamestnancov s platom aspoň 3000.
3. Vypíšte používateľov, ktorí používajú `/bin/bash`.
4. Vypíšte riadky z logu so stavovým kódom 404 alebo 500.
5. Vypíšte procesy, kde CPU hodnota je väčšia ako 2.

## Pomôcky

```bash
awk -F, '$2 == "IT" { print }' data/employees.csv
awk -F, '$4 >= 3000 { print $1, $4 }' data/employees.csv
awk -F: '/\/bin\/bash/ { print $1, $7 }' data/passwd.sample
```

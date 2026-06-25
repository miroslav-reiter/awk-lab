# 04 - Výpočty a reporty

Cieľ: precvičíme premenné, súčty, počítadlá, minimum, maximum a priemer.

## Úlohy

1. Spočítajte všetky čísla v `data/scores.txt`.
2. Vypočítajte priemer zo súboru `data/scores.txt`.
3. Spočítajte celkový obrat zo súboru `data/sales.csv`.
4. Spočítajte obrat iba pre región SK.
5. Nájdite najvyšší plat v `data/employees.csv`.

## Pomôcky

```bash
awk '{ sum += $1 } END { print sum }' data/scores.txt
awk '{ sum += $1; count++ } END { print sum / count }' data/scores.txt
awk -F, 'NR > 1 { sum += $4 } END { print sum }' data/sales.csv
```

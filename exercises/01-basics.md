# 01 - Základy awk

Cieľ: precvičíme základnú syntax `awk 'vzor { akcia }' subor`.

## Úlohy

1. Vypíšte celý obsah súboru `data/employees.csv`.
2. Vypíšte prvých 5 riadkov zo súboru `data/passwd.sample`.
3. Vypíšte číslo riadku a celý riadok zo súboru `data/scores.txt`.
4. Vypíšte iba riadky 2 až 4 zo súboru `data/employees.csv`.
5. Vypíšte posledný spracovaný riadok pomocou bloku `END`.

## Pomôcky

```bash
awk '{ print }' data/employees.csv
awk 'NR <= 5 { print }' data/passwd.sample
awk '{ print NR, $0 }' data/scores.txt
```

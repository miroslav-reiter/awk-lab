# 02 - Polia a oddeľovače

Cieľ: naučíme sa používať `$0`, `$1`, `$2`, `NF`, `FS` a prepínač `-F`.

## Úlohy

1. Zo súboru `data/employees.csv` vypíšte meno a plat.
2. Zo súboru `data/passwd.sample` vypíšte používateľské meno, UID a shell.
3. Zo súboru `data/processes.txt` vypíšte používateľa a príkaz.
4. Vypíšte počet polí v každom riadku súboru `data/employees.csv`.
5. Vypíšte posledné pole z každého riadku súboru `data/passwd.sample`.

## Pomôcky

```bash
awk -F, '{ print $1, $4 }' data/employees.csv
awk -F: '{ print $1, $3, $7 }' data/passwd.sample
awk '{ print $1, $NF }' data/processes.txt
```

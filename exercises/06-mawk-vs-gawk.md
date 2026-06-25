# 06 - mawk vs gawk

Cieľ: overíme implementáciu awk a vysvetlíme rozdiel medzi prenositeľnou syntaxou a GNU rozšíreniami.

## Úlohy

1. Overte, čo spúšťa príkaz `awk`.
2. V Kali Linuxe vyskúšajte `awk -W version`.
3. V Ubuntu Linuxe vyskúšajte `awk --version`.
4. Spustite rovnaký POSIX kompatibilný príkaz v `mawk` aj `gawk`.
5. Otestujte, či máte dostupný samostatný príkaz `gawk`.

## Pomôcky

```bash
which awk
awk -W version
awk --version
gawk --version
mawk -W version
```

Prenositeľný príkaz:

```bash
awk -F, 'NR > 1 { print $1, $4 }' data/employees.csv
```

Poznámka: v tréningových riešeniach sa držíme syntaxe, ktorá funguje v `mawk` aj `gawk`.

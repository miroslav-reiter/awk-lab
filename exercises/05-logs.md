# 05 - Spracovanie logov

Cieľ: použijeme awk na jednoduchú analýzu access logu.

## Úlohy

1. Vypíšte iba IP adresy zo súboru `data/access.log`.
2. Vypíšte HTTP metódu a URL.
3. Vypíšte stavový kód z každého riadku.
4. Spočítajte počet výskytov jednotlivých IP adries.
5. Spočítajte počet výskytov jednotlivých HTTP stavových kódov.
6. Vypíšte iba chybové odpovede so stavom 4xx alebo 5xx.

## Pomôcky

Pri tomto formáte logu je stavový kód v poli `$9`.

```bash
awk '{ print $1 }' data/access.log
awk '{ print $6, $7 }' data/access.log
awk '{ count[$1]++ } END { for (ip in count) print ip, count[ip] }' data/access.log
```

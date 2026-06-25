# awk-lab

Testovací repozitár na praktické trénovanie príkazov `awk`, `mawk` a `gawk` v Ubuntu Linuxe a Kali Linuxe.

Repozitár je určený na precvičenie práce s textom, riadkami, stĺpcami, oddeľovačmi, regulárnymi výrazmi, výpočtami a jednoduchým reportingom priamo v termináli.

## Čo je awk

`awk` je nástroj a zároveň jednoduchý programovací jazyk na spracovanie textu. Číta vstup po riadkoch, každý riadok rozdelí na polia a nad vybranými riadkami vykoná akciu.

Základný tvar príkazu:

```bash
awk 'vzor { akcia }' subor
```

Ak vzor vynecháme, akcia sa vykoná pre každý riadok. Ak akciu vynecháme, predvolenou akciou je výpis riadku.

## mawk vs gawk

V Kali Linuxe môže byť príkaz `awk` napojený na `mawk`:

```bash
awk -W version
```

V Ubuntu býva často dostupný GNU awk, teda `gawk`:

```bash
awk --version
```

Praktické pravidlo:

- `mawk` je rýchla a kompaktná implementácia awk,
- `gawk` je GNU implementácia s viacerými rozšíreniami,
- pri prenositeľných skriptoch používame hlavne POSIX kompatibilnú syntax,
- GNU rozšírenia používame iba vtedy, keď vieme, že cieľový systém má `gawk`.

## Príprava prostredia

### Kali Linux

```bash
awk
awk -W version
```

Ak chceme doplniť GNU awk:

```bash
sudo apt update
sudo apt install gawk -y
```

### Ubuntu Linux

```bash
awk
awk --version
```

Ak `awk` nie je dostupný:

```bash
sudo apt update
sudo apt install gawk -y
```

## Štruktúra repozitára

```text
awk-lab/
├── README.md
├── data/
│   ├── access.log
│   ├── employees.csv
│   ├── passwd.sample
│   ├── processes.txt
│   ├── sales.csv
│   └── scores.txt
├── exercises/
│   ├── 01-basics.md
│   ├── 02-fields-and-separators.md
│   ├── 03-filtering.md
│   ├── 04-calculations.md
│   ├── 05-logs.md
│   └── 06-mawk-vs-gawk.md
├── solutions/
│   ├── 01-basics.sh
│   ├── 02-fields-and-separators.sh
│   ├── 03-filtering.sh
│   ├── 04-calculations.sh
│   ├── 05-logs.sh
│   └── 06-mawk-vs-gawk.sh
└── scripts/
    └── run-all.sh
```

## Rýchly štart

```bash
git clone https://github.com/miroslav-reiter/awk-lab.git
cd awk-lab
```

Spustenie všetkých ukážkových riešení:

```bash
bash scripts/run-all.sh
```

## Základné príkazy

Výpis celých riadkov:

```bash
awk '{ print }' data/employees.csv
```

Výpis prvého stĺpca zo súboru oddeleného čiarkou:

```bash
awk -F, '{ print $1 }' data/employees.csv
```

Výpis používateľov zo súboru v štýle `/etc/passwd`:

```bash
awk -F: '{ print $1 }' data/passwd.sample
```

Výpis čísla riadku a celého riadku:

```bash
awk '{ print NR, $0 }' data/scores.txt
```

Filtrovanie podľa hodnoty:

```bash
awk -F, '$4 >= 3000 { print $1, $4 }' data/employees.csv
```

Filtrovanie regulárnym výrazom:

```bash
awk -F: '/bash/ { print $1, $7 }' data/passwd.sample
```

Súčet hodnôt:

```bash
awk '{ sum += $1 } END { print sum }' data/scores.txt
```

Priemer hodnôt:

```bash
awk '{ sum += $1; count++ } END { print sum / count }' data/scores.txt
```

Hlavička a záverečný report:

```bash
awk -F, 'BEGIN { print "Meno Plat" } NR > 1 { print $1, $4 } END { print "Hotovo" }' data/employees.csv
```

Formátovaný výstup:

```bash
awk -F, 'NR > 1 { printf "%-12s %8.2f\n", $1, $4 }' data/employees.csv
```

## Odporúčané poradie tréningu

1. Prejdeme `exercises/01-basics.md`.
2. Pokračujeme prácou so stĺpcami a oddeľovačmi.
3. Precvičíme filtrovanie riadkov.
4. Doplníme výpočty, súčty a priemery.
5. Spracujeme logy.
6. Porovnáme prenositeľné príkazy pre `mawk` a `gawk`.

## Časté chyby

Nesprávne umiestnenie `-F`:

```bash
awk 'BEGIN { print "Pouzivatelia" } -F: { print $1 }' data/passwd.sample
```

Správne:

```bash
awk -F: 'BEGIN { print "Pouzivatelia" } { print $1 }' data/passwd.sample
```

Zámenné používanie shell premenných a awk premenných:

```bash
name="Miroslav"
awk -v name="$name" 'BEGIN { print name }'
```

## Poznámka k prenositeľnosti

V tomto repozitári sú riešenia písané tak, aby fungovali v `mawk` aj `gawk`, pokiaľ nie je výslovne uvedené inak.

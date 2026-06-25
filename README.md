# 🧪 awk-lab

Testovací repozitár na praktické trénovanie príkazov `awk`, `mawk` a `gawk` v Ubuntu Linuxe a Kali Linuxe.

Repozitár je určený na precvičenie práce s textom, riadkami, stĺpcami, oddeľovačmi, regulárnymi výrazmi, výpočtami a jednoduchým reportingom priamo v termináli.

## 📌 Čo je awk

`awk` je nástroj a zároveň jednoduchý programovací jazyk na spracovanie textu. Číta vstup po riadkoch, každý riadok rozdelí na polia a nad vybranými riadkami vykoná akciu.

Základný tvar príkazu:

```bash
awk 'vzor { akcia }' subor
```

Ak vzor vynecháme, akcia sa vykoná pre každý riadok. Ak akciu vynecháme, predvolenou akciou je výpis riadku.

## 🎯 Na čo sa awk používa v praxi

`awk` používame hlavne pri rýchlom spracovaní textových dát priamo v termináli alebo v shell skriptoch.

Typické použitie:

- výber stĺpcov z textových súborov,
- spracovanie CSV a TSV súborov,
- filtrovanie riadkov podľa podmienok,
- práca s logmi,
- počítanie súčtov, priemerov, miním a maxím,
- jednoduché reporty,
- spracovanie výstupov príkazov ako `ps`, `df`, `du`, `ls`, `ip`, `ss`,
- rýchle transformácie dát bez potreby Pythonu alebo Excelu.

## 🧩 mawk vs gawk

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

## ⚙️ Príprava prostredia

### 🐉 Kali Linux

```bash
awk
awk -W version
```

Ak chceme doplniť GNU awk:

```bash
sudo apt update
sudo apt install gawk -y
```

### 🐧 Ubuntu Linux

```bash
awk
awk --version
```

Ak `awk` nie je dostupný:

```bash
sudo apt update
sudo apt install gawk -y
```

## 🗂️ Štruktúra repozitára

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

## 🚀 Rýchly štart

```bash
git clone https://github.com/miroslav-reiter/awk-lab.git
cd awk-lab
```

Spustenie všetkých ukážkových riešení:

```bash
bash scripts/run-all.sh
```

## 🧾 Základné príkazy

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

## 🧠 AWK cheat sheet

### 📍 Základná syntax

| Použitie | Príkaz |
|---|---|
| Výpis všetkých riadkov | `awk '{ print }' subor.txt` |
| Výpis celého riadku | `awk '{ print $0 }' subor.txt` |
| Výpis prvého poľa | `awk '{ print $1 }' subor.txt` |
| Výpis prvého a druhého poľa | `awk '{ print $1, $2 }' subor.txt` |
| Výpis čísla riadku | `awk '{ print NR, $0 }' subor.txt` |
| Výpis počtu polí | `awk '{ print NF, $0 }' subor.txt` |
| Výpis posledného poľa | `awk '{ print $NF }' subor.txt` |

### ✂️ Oddeľovače polí

| Použitie | Príkaz |
|---|---|
| CSV súbor | `awk -F, '{ print $1 }' data.csv` |
| Súbor oddelený dvojbodkou | `awk -F: '{ print $1 }' /etc/passwd` |
| Nastavenie `FS` v programe | `awk 'BEGIN { FS="," } { print $1 }' data.csv` |
| Nastavenie výstupného oddeľovača | `awk 'BEGIN { OFS=";" } { print $1, $2 }' data.txt` |

### 🔎 Filtrovanie

| Použitie | Príkaz |
|---|---|
| Riadky s hodnotou väčšou ako 100 | `awk '$1 > 100 { print }' cisla.txt` |
| Riadky od 2. riadku | `awk 'NR > 1 { print }' data.csv` |
| Riadky 2 až 5 | `awk 'NR >= 2 && NR <= 5 { print }' data.txt` |
| Text obsahuje výraz | `awk '/error/ { print }' app.log` |
| Pole sa rovná hodnote | `awk -F, '$2 == "IT" { print }' employees.csv` |
| Pole sa nerovná hodnote | `awk -F, '$2 != "IT" { print }' employees.csv` |

### 🧮 Výpočty

| Použitie | Príkaz |
|---|---|
| Súčet prvého stĺpca | `awk '{ sum += $1 } END { print sum }' cisla.txt` |
| Priemer prvého stĺpca | `awk '{ sum += $1; n++ } END { print sum / n }' cisla.txt` |
| Počet riadkov | `awk 'END { print NR }' subor.txt` |
| Maximum | `awk 'NR == 1 { max=$1 } $1 > max { max=$1 } END { print max }' cisla.txt` |
| Minimum | `awk 'NR == 1 { min=$1 } $1 < min { min=$1 } END { print min }' cisla.txt` |

### 🧱 BEGIN a END

| Použitie | Príkaz |
|---|---|
| Hlavička pred spracovaním | `awk 'BEGIN { print "Start" } { print }' data.txt` |
| Záver po spracovaní | `awk '{ print } END { print "Hotovo" }' data.txt` |
| Inicializácia oddeľovača | `awk 'BEGIN { FS="," } NR > 1 { print $1 }' data.csv` |

### 🖨️ Formátovaný výstup

| Použitie | Príkaz |
|---|---|
| Zarovnanie textu | `awk '{ printf "%-15s %s\n", $1, $2 }' data.txt` |
| Číslo na 2 desatinné miesta | `awk '{ printf "%.2f\n", $1 }' cisla.txt` |
| Tabuľkový report | `awk -F, 'NR>1 { printf "%-12s %8.2f\n", $1, $4 }' employees.csv` |

### 🧰 Užitočné premenné

| Premenná | Význam |
|---|---|
| `$0` | celý aktuálny riadok |
| `$1`, `$2`, `$3` | prvé, druhé, tretie pole |
| `$NF` | posledné pole v riadku |
| `NR` | poradové číslo aktuálneho riadku celkovo |
| `FNR` | poradové číslo riadku v aktuálnom súbore |
| `NF` | počet polí v aktuálnom riadku |
| `FS` | vstupný oddeľovač polí |
| `OFS` | výstupný oddeľovač polí |
| `RS` | vstupný oddeľovač záznamov |
| `ORS` | výstupný oddeľovač záznamov |
| `FILENAME` | aktuálne spracovaný súbor |

### 🧪 Overenie implementácie

| Prostredie | Príkaz |
|---|---|
| Kali Linux, mawk | `awk -W version` |
| Ubuntu Linux, gawk | `awk --version` |
| Samostatný gawk | `gawk --version` |
| Cesta k príkazu | `which awk` |

## 🧭 Odporúčané poradie tréningu

1. Prejdeme `exercises/01-basics.md`.
2. Pokračujeme prácou so stĺpcami a oddeľovačmi.
3. Precvičíme filtrovanie riadkov.
4. Doplníme výpočty, súčty a priemery.
5. Spracujeme logy.
6. Porovnáme prenositeľné príkazy pre `mawk` a `gawk`.

## ⚠️ Časté chyby

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

## 🔒 Bezpečnostné poznámky

Pri práci s `awk` spracovávame často logy, konfigurácie, používateľské dáta alebo výstupy systémových príkazov. Preto dodržiavame tieto pravidlá:

- Nespúšťame neznáme `awk` skripty z internetu bez kontroly obsahu.
- Pri spracovaní citlivých logov anonymizujeme IP adresy, používateľské mená, tokeny a e-mailové adresy.
- Do repozitára neukladáme reálne súbory ako `/etc/passwd`, produkčné logy, API tokeny, heslá alebo výpisy obsahujúce osobné údaje.
- Pri vkladaní shell premenných do `awk` používame `-v`, nie nebezpečné skladanie príkazov cez reťazce.
- Vyhýbame sa konštrukciám, ktoré skladajú shell príkazy z používateľského vstupu.
- Nepoužívame `system()` nad nedôveryhodným vstupom.
- Pri spracovaní veľkých súborov testujeme príkaz najprv na menšej vzorke dát.
- Pri prepise súborov najprv zapisujeme do dočasného súboru a až potom nahrádzame pôvodný súbor.

Rizikový príklad:

```bash
awk -v cmd="$USER_INPUT" 'BEGIN { system(cmd) }'
```

Bezpečnejší prístup je nepúšťať príkazy z používateľského vstupu vôbec a spracovať vstup ako dáta:

```bash
awk -v value="$USER_INPUT" 'BEGIN { print value }'
```

## 🧳 Poznámka k prenositeľnosti

V tomto repozitári sú riešenia písané tak, aby fungovali v `mawk` aj `gawk`, pokiaľ nie je výslovne uvedené inak.

Ak pripravujeme skripty pre viacero Linux distribúcií, držíme sa základnej POSIX kompatibilnej syntaxe. Funkcie špecifické pre GNU awk používame iba vtedy, keď máme istotu, že cieľové prostredie používa `gawk`.

## 📚 Užitočné odkazy a zdroje

- GNU Awk User's Guide: https://www.gnu.org/software/gawk/manual/gawk.html
- GNU Awk projekt: https://www.gnu.org/software/gawk/
- POSIX awk špecifikácia: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html
- mawk manuál: https://invisible-island.net/mawk/manpage/mawk.html
- The AWK Programming Language, kniha a zdroje: https://awk.dev/
- GitHub repozitár GNU awk: https://git.savannah.gnu.org/cgit/gawk.git

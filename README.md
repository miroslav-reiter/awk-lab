# 🧪 Online Kurz AWK, MAWK, GAWK (awk-lab)

Testovací repozitár na praktické trénovanie príkazov `awk`, `mawk` a `gawk` v Ubuntu Linuxe a Kali Linuxe.

Repozitár je určený na precvičenie práce s textom, riadkami, stĺpcami, oddeľovačmi, regulárnymi výrazmi, výpočtami a jednoduchým reportingom priamo v termináli.

## 📌 Čo je awk

`awk` je nástroj a zároveň jednoduchý programovací jazyk na spracovanie textu. Číta vstup po riadkoch, každý riadok rozdelí na polia a nad vybranými riadkami vykoná akciu.
AWK = Aho, Weinberger, Kernighan. Nie je to skratka typu "Advanced Word Kit", ale priamo iniciály autorov. 

AWK vznikol v Bell Labs v 70. rokoch. Pôvodná verzia bola napísaná v roku 1977 a neskôr bola dostupná v Unix systémoch. Jazyk bol navrhnutý na pattern scanning and processing, teda na prehľadávanie textu podľa vzorov a spracovanie riadkov, stĺpcov a reportov.

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

## 🪟 AWK pod Microsoft Windows

`awk` sa dá používať aj vo Windows, ale Windows ho štandardne neposkytuje ako bežný natívny príkaz v CMD alebo PowerShelli. V praxi preto používame prostredie, ktoré do Windows doplní Unix/Linux nástroje.

Najčastejšie možnosti:

| Možnosť | Vhodné použitie | Poznámka |
|---|---|---|
| WSL | Linuxové príkazy vo Windows | Najbližšie k Ubuntu alebo Kali Linuxu. Odporúčaná voľba pre tento kurz. |
| Cygwin | Unix-like prostredie priamo vo Windows | Vhodné, keď nechceme alebo nemôžeme použiť WSL. Má vlastné cesty typu `/cygdrive/c`. |
| Git Bash | Jednoduché používanie Unix nástrojov | Praktické pri Git workflow, ale nie je to plnohodnotné Linux prostredie. |
| MSYS2 | Vývojárske GNU prostredie | Vhodné pre vývojárov, balíčky a nástroje podobné Linuxu. |
| Natívny gawk pre Windows | Samostatný program bez Linux prostredia | Použiteľné, ale menej vhodné pre školenia zamerané na Linux. |

### ✅ Odporúčanie pre tento kurz

Pre školenie odporúčam vo Windows používať hlavne **WSL s Ubuntu**. Dôvod je jednoduchý: príkazy, cesty a správanie budú veľmi podobné reálnemu Linuxu.

Príklad z PowerShellu:

```powershell
wsl
```

Potom vo WSL Ubuntu:

```bash
awk --version
awk '{ print $1 }' data/scores.txt
awk -F, '{ print $1, $4 }' data/employees.csv
```

Príkaz môžeme spustiť aj priamo z PowerShellu cez `wsl`:

```powershell
wsl awk --version
wsl awk '{ print $1 }' data/scores.txt
```

### 🧰 Cygwin

Cygwin poskytuje vo Windows Unix-like/POSIX prostredie. Po inštalácii Cygwinu môžeme doinštalovať balík `gawk` a používať `awk` podobne ako v Linux termináli.

Typické overenie v Cygwin termináli:

```bash
awk --version
gawk --version
awk '{ print $1 }' subor.txt
awk -F, '{ print $1, $3 }' data.csv
```

Dôležitý rozdiel sú cesty. Windows disk `C:` je v Cygwine dostupný typicky cez `/cygdrive/c`:

```bash
cd /cygdrive/c/Users/miros/Desktop
awk '{ print $1 }' subor.txt
```

Výhody Cygwinu:

- funguje priamo vo Windows,
- podporuje nástroje ako `awk`, `gawk`, `sed`, `grep`, `bash`, `find`, `sort`, `uniq`,
- je vhodný pre skripty, ktoré očakávajú Unix-like prostredie,
- nevyžaduje plnú Linux distribúciu ako WSL.

Nevýhody Cygwinu:

- nie je to skutočný Linux,
- niektoré systémové príkazy sa môžu správať inak ako v Ubuntu alebo Kali,
- používa vlastnú adresárovú štruktúru,
- pri kurze zameranom na Linux môže začiatočníkov mýliť rozdielmi v cestách.

### 🧪 Git Bash

Git Bash je súčasťou Git for Windows. Často obsahuje základné Unix nástroje vrátane `awk`.

Overenie:

```bash
awk --version
awk '{ print $1 }' subor.txt
```

Git Bash je vhodný na jednoduché ukážky a prácu s textovými súbormi. Nie je však plnohodnotná náhrada Linuxu. Pri práci s cestami môžeme naraziť na rozdiely medzi Windows a Unix zápisom.

### 🧱 MSYS2

MSYS2 je vývojárske prostredie pre Windows s balíčkovacím systémom. Vie poskytnúť GNU nástroje vrátane `gawk`.

Typické použitie:

```bash
gawk --version
awk -F, '{ print $1, $2 }' data.csv
```

MSYS2 je vhodné skôr pre vývojárov a technickejších používateľov. Pre začiatočnícke školenie je jednoduchšie odporučiť WSL.

### 🧾 Natívny gawk pre Windows

Existujú aj natívne porty `gawk` pre Windows. Výhoda je, že nepotrebujeme samostatné Linux-like prostredie. Nevýhoda je, že inštalácia, cesty a správanie sa môžu líšiť od Linuxu.

Pre tento kurz je preto lepšie používať WSL, prípadne Cygwin alebo Git Bash ako doplnkové možnosti.

### ⚠️ Rozdiely oproti Linuxu

Pri používaní `awk` vo Windows dávame pozor najmä na tieto rozdiely:

| Oblasť | Windows | Linux/Unix |
|---|---|---|
| Cesty | `C:\Users\miros\subor.txt` | `/home/miros/subor.txt` |
| Cygwin cesta na disk C | `/cygdrive/c/...` | nepoužíva sa |
| WSL cesta na disk C | `/mnt/c/...` | nepoužíva sa |
| Konce riadkov | často CRLF | často LF |
| Shell | PowerShell, CMD, Git Bash, Cygwin Bash | Bash, Zsh, Dash |
| Quoting | môže sa líšiť podľa shellu | stabilné v Bash ukážkach |

Pri problémoch s koncami riadkov môžeme súbor skonvertovať napríklad nástrojom `dos2unix`, ak je dostupný:

```bash
dos2unix subor.txt
```

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

## 🎬 Praktické príklady vo videu

Táto sekcia obsahuje príkazy vhodné na ukážku vo videu. Niektoré príklady používajú všeobecné súbory ako `subor.txt` a `cisla.txt`, iné používajú systémový súbor `/etc/passwd`. Pri tréningu v tomto repozitári môžeme namiesto `/etc/passwd` bezpečne použiť `data/passwd.sample`.

### 1. Výpis celého súboru

```bash
awk '{ print }' subor.txt
```

Príkaz vypíše každý riadok vstupného súboru. Ak nepoužijeme žiadnu podmienku, akcia `{ print }` sa vykoná pre každý riadok.

Alternatíva v tomto repozitári:

```bash
awk '{ print }' data/employees.csv
```

### 2. Výpis prvého stĺpca

```bash
awk '{ print $1 }' subor.txt
```

`$1` znamená prvé pole aktuálneho riadku. Predvolený oddeľovač polí je medzera alebo tabulátor.

Alternatíva v tomto repozitári:

```bash
awk '{ print $1 }' data/processes.txt
```

### 3. Výpis používateľských mien z `/etc/passwd`

```bash
awk -F: '{ print $1 }' /etc/passwd
```

Prepínač `-F:` nastaví dvojbodku ako oddeľovač polí. Súbor `/etc/passwd` používa dvojbodku medzi poľami, preto `$1` predstavuje používateľské meno.

Bezpečná tréningová alternatíva:

```bash
awk -F: '{ print $1 }' data/passwd.sample
```

### 4. Výpis používateľa, UID a shellu

```bash
awk -F: '{ print $1, $3, $7 }' /etc/passwd
```

Príkaz vypíše prvé, tretie a siedme pole. V súbore `/etc/passwd` to zvyčajne znamená používateľské meno, UID a prihlasovací shell.

Bezpečná tréningová alternatíva:

```bash
awk -F: '{ print $1, $3, $7 }' data/passwd.sample
```

### 5. Výpis prvých 5 riadkov s číslom riadku

```bash
awk 'NR <= 5 { print NR, $0 }' /etc/passwd
```

`NR` je poradové číslo aktuálneho riadku. `$0` znamená celý aktuálny riadok. Podmienka `NR <= 5` obmedzí výstup na prvých päť riadkov.

Bezpečná tréningová alternatíva:

```bash
awk 'NR <= 5 { print NR, $0 }' data/passwd.sample
```

### 6. Výpis bežných používateľov podľa UID

```bash
awk -F: '$3 >= 1000 { print $1, $3 }' /etc/passwd
```

Tretie pole v `/etc/passwd` je UID. Podmienka `$3 >= 1000` často vyberie bežných používateľov, nie systémové účty. Toto pravidlo sa môže medzi distribúciami líšiť.

Bezpečná tréningová alternatíva:

```bash
awk -F: '$3 >= 1000 { print $1, $3 }' data/passwd.sample
```

### 7. Výpis používateľov s bash shellom

```bash
awk -F: '/bash/ { print $1, $7 }' /etc/passwd
```

Regulárny výraz `/bash/` vyberie iba riadky, ktoré obsahujú text `bash`. Následne vypíšeme používateľské meno a shell.

Bezpečná tréningová alternatíva:

```bash
awk -F: '/bash/ { print $1, $7 }' data/passwd.sample
```

### 8. Súčet čísel v súbore

```bash
awk '{ suma += $1 } END { print suma }' cisla.txt
```

Premenná `suma` sa postupne navyšuje o hodnotu prvého poľa. Blok `END` sa vykoná až po spracovaní celého vstupu.

Alternatíva v tomto repozitári:

```bash
awk '{ suma += $1 } END { print suma }' data/scores.txt
```

### 9. Priemer čísel v súbore

```bash
awk '{ suma += $1; pocet++ } END { print suma / pocet }' cisla.txt
```

Pri každom riadku pripočítame hodnotu do premennej `suma` a zvýšime počítadlo `pocet`. Na konci vypočítame priemer ako `suma / pocet`.

Alternatíva v tomto repozitári:

```bash
awk '{ suma += $1; pocet++ } END { print suma / pocet }' data/scores.txt
```

### 10. Chybný príklad s `BEGIN` a `-F`

```bash
awk 'BEGIN { print "Pouzivatelia:" } -F: { print $1 }' /etc/passwd
```

Tento zápis je chybný, pretože prepínač `-F:` patrí pred awk program, nie dovnútra programu medzi pravidlá. V tejto podobe sa `-F:` nespracuje ako nastavenie oddeľovača polí.

Správny zápis:

```bash
awk -F: 'BEGIN { print "Pouzivatelia:" } { print $1 }' /etc/passwd
```

Bezpečná tréningová alternatíva:

```bash
awk -F: 'BEGIN { print "Pouzivatelia:" } { print $1 }' data/passwd.sample
```

## 🖥️ Výstupy awk, mawk a gawk v Kali a Ubuntu

Táto sekcia zachytáva reálne výstupy z terminálu pri spustení príkazov bez argumentov. V praxi je to dobrý spôsob, ako rýchlo zistiť, ktorá implementácia awk je v systéme dostupná a aké prepínače podporuje.

### 🐉 Kali Linux: `awk` ako `mawk`

```text
┌──(miros㉿MSI-Lektor)-[~]
└─$ awk
Usage: mawk [Options] [Program] [file ...]

Program:
    The -f option value is the name of a file containing program text.
    If no -f option is given, a "--" ends option processing; the following
    parameters are the program text.

Options:
    -f program-file  Program  text is read from file instead of from the
                     command-line.  Multiple -f options are accepted.
    -F value         sets the field separator, FS, to value.
    -v var=value     assigns value to program variable var.
    --               unambiguous end of options.

    Implementation-specific options are prefixed with "-W".  They can be
    abbreviated:

    -W version       show version information and exit.
    -W compat        pre-POSIX 2001.
    -W dump          show assembler-like listing of program and exit.
    -W help          show this message and exit.
    -W interactive   set unbuffered output, line-buffered input.
    -W exec file     use file as program as well as last option.
    -W posix         stricter POSIX checking.
    -W random=number set initial random seed.
    -W sprintf=number adjust size of sprintf buffer.
    -W usage         show this message and exit.
```

Z výpisu vidíme, že príkaz `awk` v tomto Kali Linuxe spúšťa `mawk`. Základné prepínače `-f`, `-F`, `-v` a `--` sú prenositeľné a používame ich aj v POSIX kompatibilných awk skriptoch.

### 🐧 Ubuntu Linux: `awk` ako GNU awk

```text
miros@MSI-Lektor:~$ awk
Usage: awk [POSIX or GNU style options] -f progfile [--] file ...
Usage: awk [POSIX or GNU style options] [--] 'program' file ...
POSIX options:          GNU long options: (standard)
        -f progfile             --file=progfile
        -F fs                   --field-separator=fs
        -v var=val              --assign=var=val
Short options:          GNU long options: (extensions)
        -b                      --characters-as-bytes
        -c                      --traditional
        -C                      --copyright
        -d[file]                --dump-variables[=file]
        -D[file]                --debug[=file]
        -e 'program-text'       --source='program-text'
        -E file                 --exec=file
        -g                      --gen-pot
        -h                      --help
        -i includefile          --include=includefile
        -l library              --load=library
        -L[fatal|invalid|no-ext]        --lint[=fatal|invalid|no-ext]
        -M                      --bignum
        -N                      --use-lc-numeric
        -n                      --non-decimal-data
        -o[file]                --pretty-print[=file]
        -O                      --optimize
        -p[file]                --profile[=file]
        -P                      --posix
        -r                      --re-interval
        -s                      --no-optimize
        -S                      --sandbox
        -t                      --lint-old
        -V                      --version

To report bugs, see node `Bugs' in `gawk.info'
which is section `Reporting Problems and Bugs' in the
printed version.  This same information may be found at
https://www.gnu.org/software/gawk/manual/html_node/Bugs.html.
PLEASE do NOT try to report bugs by posting in comp.lang.awk,
or by using a web forum such as Stack Overflow.

gawk is a pattern scanning and processing language.
By default it reads standard input and writes standard output.

Examples:
        awk '{ sum += $1 }; END { print sum }' file
        awk -F: '{ print $1 }' /etc/passwd
```

Z výpisu vidíme, že Ubuntu používa GNU awk funkcie. Príkaz sa volá `awk`, ale podporuje GNU prepínače typické pre `gawk`.

### 🐧 Ubuntu Linux: samostatný príkaz `mawk`

```text
miros@MSI-Lektor:~$ mawk
Usage: mawk [Options] [Program] [file ...]

Program:
    The -f option value is the name of a file containing program text.
    If no -f option is given, a "--" ends option processing; the following
    parameters are the program text.

Options:
    -f program-file  Program  text is read from file instead of from the
                     command-line.  Multiple -f options are accepted.
    -F value         sets the field separator, FS, to value.
    -v var=value     assigns value to program variable var.
    --               unambiguous end of options.

    Implementation-specific options are prefixed with "-W".  They can be
    abbreviated:

    -W version       show version information and exit.
    -W dump          show assembler-like listing of program and exit.
    -W help          show this message and exit.
    -W interactive   set unbuffered output, line-buffered input.
    -W exec file     use file as program as well as last option.
    -W random=number set initial random seed.
    -W sprintf=number adjust size of sprintf buffer.
    -W posix_space   do not consider "\n" a space.
    -W usage         show this message and exit.
```

Tento výpis ukazuje, že na Ubuntu môže byť popri `gawk` dostupný aj samostatný príkaz `mawk`.

### 🐧 Ubuntu Linux: samostatný príkaz `gawk`

```text
miros@MSI-Lektor:~$ gawk
Usage: gawk [POSIX or GNU style options] -f progfile [--] file ...
Usage: gawk [POSIX or GNU style options] [--] 'program' file ...
POSIX options:          GNU long options: (standard)
        -f progfile             --file=progfile
        -F fs                   --field-separator=fs
        -v var=val              --assign=var=val
Short options:          GNU long options: (extensions)
        -b                      --characters-as-bytes
        -c                      --traditional
        -C                      --copyright
        -d[file]                --dump-variables[=file]
        -D[file]                --debug[=file]
        -e 'program-text'       --source='program-text'
        -E file                 --exec=file
        -g                      --gen-pot
        -h                      --help
        -i includefile          --include=includefile
        -l library              --load=library
        -L[fatal|invalid|no-ext]        --lint[=fatal|invalid|no-ext]
        -M                      --bignum
        -N                      --use-lc-numeric
        -n                      --non-decimal-data
        -o[file]                --pretty-print[=file]
        -O                      --optimize
        -p[file]                --profile[=file]
        -P                      --posix
        -r                      --re-interval
        -s                      --no-optimize
        -S                      --sandbox
        -t                      --lint-old
        -V                      --version

To report bugs, see node `Bugs' in `gawk.info'
which is section `Reporting Problems and Bugs' in the
printed version.  This same information may be found at
https://www.gnu.org/software/gawk/manual/html_node/Bugs.html.
PLEASE do NOT try to report bugs by posting in comp.lang.awk,
or by using a web forum such as Stack Overflow.

gawk is a pattern scanning and processing language.
By default it reads standard input and writes standard output.

Examples:
        gawk '{ sum += $1 }; END { print sum }' file
        gawk -F: '{ print $1 }' /etc/passwd
```

Tento výpis je prakticky rovnaký ako pri `awk` v Ubuntu, len príkaz je explicitne `gawk`.

### 📋 Vysvetlenie základných POSIX prepínačov

| Prepínač | Použitie | Vysvetlenie |
|---|---|---|
| `-f program-file` | `awk -f skript.awk data.txt` | Program awk sa nenačíta z príkazového riadka, ale zo súboru. Vhodné pre dlhšie skripty. |
| `-F value` | `awk -F: '{ print $1 }' /etc/passwd` | Nastaví vstupný oddeľovač polí `FS`. Často používame `-F,` pre CSV alebo `-F:` pre `/etc/passwd`. |
| `-v var=value` | `awk -v limit=100 '$1 > limit { print }' data.txt` | Odovzdá hodnotu do awk premennej ešte pred spustením programu, teda aj pred blokom `BEGIN`. |
| `--` | `awk -- '{ print }' subor.txt` | Jednoznačne ukončí spracovanie prepínačov. Hodí sa pri názvoch súborov alebo programoch, ktoré by mohli začínať znakom `-`. |

### 📋 Vysvetlenie `mawk` prepínačov `-W`

| Prepínač | Význam | Poznámka |
|---|---|---|
| `-W version` | Zobrazí verziu `mawk` a skončí. | Používame na overenie, že `awk` je v systéme napojený na `mawk`. |
| `-W compat` | Zapne správanie kompatibilné so starším awk pred POSIX 2001. | Vhodné iba pri starších skriptoch. Bežne ho nepoužívame. |
| `-W dump` | Vypíše internú assembler-like reprezentáciu programu a skončí. | Diagnostická voľba, nie bežný tréningový prepínač. |
| `-W help` | Zobrazí pomocníka. | Podobné ako výpis po spustení bez programu. |
| `-W interactive` | Nastaví nebufferovaný výstup a riadkovo bufferovaný vstup. | Vhodné pri interaktívnom spracovaní alebo pipe scenároch. |
| `-W exec file` | Použije súbor ako awk program a zároveň ukončí spracovanie ďalších možností. | Praktické pri spustiteľných awk skriptoch. |
| `-W posix` | Zapne prísnejšiu POSIX kontrolu. | Vhodné pri testovaní prenositeľnosti skriptov. |
| `-W random=number` | Nastaví počiatočné semienko generátora náhodných čísel. | Ovplyvňuje funkcie pracujúce s náhodnosťou, napríklad `rand()`. |
| `-W sprintf=number` | Upraví veľkosť bufferu pre `sprintf`. | Špecifické pre `mawk`; rieši špeciálne prípady formátovania dlhších reťazcov. |
| `-W posix_space` | Nepovažuje znak nového riadku `\n` za medzeru. | Vo výpise sa objavuje v Ubuntu pri samostatnom `mawk`. |
| `-W usage` | Zobrazí stručný návod na použitie. | Alternatíva k pomocnému výpisu. |

### 📋 Vysvetlenie `gawk` prepínačov

| Krátky tvar | Dlhý tvar | Vysvetlenie |
|---|---|---|
| `-f progfile` | `--file=progfile` | Načíta awk program zo súboru. |
| `-F fs` | `--field-separator=fs` | Nastaví vstupný oddeľovač polí `FS`. |
| `-v var=val` | `--assign=var=val` | Nastaví awk premennú pred spustením programu. |
| `-b` | `--characters-as-bytes` | Spracováva znaky ako bajty, čo môže byť užitočné pri binárnych alebo špecificky kódovaných dátach. |
| `-c` | `--traditional` | Zapne tradičný režim kompatibility a potláča niektoré GNU rozšírenia. |
| `-C` | `--copyright` | Zobrazí informácie o autorských právach a skončí. |
| `-d[file]` | `--dump-variables[=file]` | Vypíše premenné programu, voliteľne do súboru. Užitočné pri diagnostike. |
| `-D[file]` | `--debug[=file]` | Spustí alebo pripraví debugger pre awk program. |
| `-e 'program-text'` | `--source='program-text'` | Zadá awk program priamo ako text. Umožňuje kombinovať viac zdrojov programu. |
| `-E file` | `--exec=file` | Načíta program zo súboru a ukončí spracovanie ďalších prepínačov. Vhodné pre spustiteľné skripty. |
| `-g` | `--gen-pot` | Vygeneruje POT súbor pre lokalizáciu textov. |
| `-h` | `--help` | Zobrazí pomocníka a skončí. |
| `-i includefile` | `--include=includefile` | Vloží ďalší awk zdrojový súbor. GNU rozšírenie vhodné pre väčšie projekty. |
| `-l library` | `--load=library` | Načíta dynamickú knižnicu alebo rozšírenie. GNU rozšírenie. |
| `-L[fatal|invalid|no-ext]` | `--lint[=fatal|invalid|no-ext]` | Zapne kontrolu problematických alebo neprenositeľných konštrukcií. `fatal` zmení varovania na chyby. |
| `-M` | `--bignum` | Zapne podporu veľkých čísel a vyššej presnosti, ak je dostupná. |
| `-N` | `--use-lc-numeric` | Použije lokálne nastavenie čísel, napríklad desatinnú čiarku podľa locale. |
| `-n` | `--non-decimal-data` | Umožní interpretovať nedesiatkové číselné dáta. |
| `-o[file]` | `--pretty-print[=file]` | Vypíše pekne formátovanú verziu awk programu. |
| `-O` | `--optimize` | Zapne optimalizácie programu. |
| `-p[file]` | `--profile[=file]` | Vygeneruje profil behu programu, voliteľne do súboru. |
| `-P` | `--posix` | Zapne POSIX režim a obmedzí GNU rozšírenia. Vhodné pri testovaní prenositeľnosti. |
| `-r` | `--re-interval` | Zapne intervalové regulárne výrazy. V novších awk implementáciách je často už bežné správanie. |
| `-s` | `--no-optimize` | Vypne optimalizácie. Užitočné pri ladení alebo porovnávaní správania. |
| `-S` | `--sandbox` | Zapne sandbox režim. Obmedzuje vybrané operácie so súbormi, pipe a koprocesmi. |
| `-t` | `--lint-old` | Upozorňuje na konštrukcie, ktoré neboli dostupné v pôvodných starších awk implementáciách. |
| `-V` | `--version` | Zobrazí verziu `gawk` a skončí. |

### 🧭 Ktoré prepínače používame najčastejšie

Pri bežnej práci vo videu používame hlavne tieto prepínače:

```bash
awk -F: '{ print $1 }' /etc/passwd
awk -F, '{ print $1, $4 }' data/employees.csv
awk -v limit=3000 -F, '$4 >= limit { print $1, $4 }' data/employees.csv
awk -f script.awk data.txt
awk --version
awk -W version
```

Na začiatok stačí prakticky ovládať `-F`, `-v`, `-f`, `--version` a `-W version`. Ostatné prepínače riešime až pri ladení, kompatibilite, profilovaní alebo špecifických GNU rozšíreniach.

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
- Pri vkladaní shell premenných do `awk` používame `-v`, nie neprehľadné skladanie príkazov cez reťazce.
- Pri spracovaní veľkých súborov testujeme príkaz najprv na menšej vzorke dát.
- Pri prepise súborov najprv zapisujeme do dočasného súboru a až potom nahrádzame pôvodný súbor.

Bezpečnejší prístup pri vkladaní hodnoty z shellu do awk je použiť `-v`:

```bash
awk -v value="$USER_INPUT" 'BEGIN { print value }'
```

## 🧳 Poznámka k prenositeľnosti

V tomto repozitári sú riešenia písané tak, aby fungovali v `mawk` aj `gawk`, pokiaľ nie je výslovne uvedené inak.

Ak pripravujeme skripty pre viacero Linux distribúcií, držíme sa základnej POSIX kompatibilnej syntaxe. Funkcie špecifické pre GNU awk používame iba vtedy, keď máme istotu, že cieľové prostredie používa `gawk`.

## 📚 Užitočné odkazy a zdroje

- GNU Awk User's Guide: https://www.gnu.org/software/gawk/manual/gawk.html
- GNU Awk projekt: https://www.gnu.org/software/gawk/
- The Open Group Base Specifications, Issue 8: https://pubs.opengroup.org/onlinepubs/9799919799/
- POSIX awk špecifikácia: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html
- mawk manuál: https://invisible-island.net/mawk/manpage/mawk.html
- The AWK Programming Language, kniha a zdroje: https://awk.dev/
- GitHub repozitár GNU awk: https://git.savannah.gnu.org/cgit/gawk.git

### 📖 Odporúčané knihy o AWK

| Kniha | Autori | Prečo je užitočná |
|---|---|---|
| The AWK Programming Language, Second Edition | Alfred V. Aho, Brian W. Kernighan, Peter J. Weinberger | Najlepšia hlavná kniha k jazyku AWK od autorov jazyka. Druhé vydanie je aktualizované pre súčasné použitie AWK. |
| The AWK Programming Language | Alfred V. Aho, Brian W. Kernighan, Peter J. Weinberger | Klasické prvé vydanie z roku 1988. Stále výborné na pochopenie filozofie jazyka. |
| Effective AWK Programming | Arnold Robbins | Praktická kniha a používateľská príručka pre GNU awk. Vhodná, keď chceme ísť hlbšie do `gawk`. |
| sed & awk, Second Edition | Dale Dougherty, Arnold Robbins | Praktická kniha pre Unix text processing. Dobrá kombinácia `sed` a `awk` pre shell skripty. |
| sed and awk Pocket Reference | Arnold Robbins | Stručná príručka do ruky. Vhodná ako rýchly ťahák k syntaxe a bežným konštrukciám. |

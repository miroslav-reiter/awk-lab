# 🐧 Praktické príklady AWK nad Linux systémom

Tento súbor obsahuje praktické príklady použitia `awk` nad reálnymi systémovými súbormi a výstupmi príkazov v Linuxe. Je určený pre administrátorov, DevOps tímy, odborníkov na kybernetickú bezpečnosť, etických hackerov, testerov a technických uchádzačov na pracovné pohovory.

## 🔒 Bezpečnostná poznámka

Príkazy v tomto súbore sú určené primárne na čítanie, filtrovanie a analýzu. Pri súboroch ako `/etc/sudoers`, `/etc/ssh/sshd_config`, `/etc/fstab`, logoch a konfiguráciách nemeníme obsah priamo cez `awk` bez zálohy, testovania a znalosti dopadov.

Niektoré príkazy používajú `sudo`, pretože systémové logy a bezpečnostné konfigurácie nemusia byť dostupné bežnému používateľovi.

## 🧠 Ako čítať tieto AWK príkazy

Základný tvar príkazu:

```bash
awk 'vzor { akcia }' subor
```

Najdôležitejšie prvky:

| Prvok | Význam |
|---|---|
| `awk` | spustí nástroj AWK |
| `'...'` | AWK program, v shelli ho dávame do apostrofov |
| `vzor` | podmienka, ktorá rozhoduje, či sa akcia vykoná |
| `{ akcia }` | príkazy vykonané nad riadkom, ktorý splnil vzor |
| `$0` | celý aktuálny riadok |
| `$1`, `$2`, `$3` | prvé, druhé, tretie pole aktuálneho riadku |
| `$NF` | posledné pole aktuálneho riadku |
| `NF` | počet polí v aktuálnom riadku |
| `NR` | poradové číslo aktuálneho riadku od začiatku vstupu |
| `FILENAME` | názov aktuálne spracovaného súboru |
| `-F:` | nastaví oddeľovač polí na dvojbodku |
| `~` | test zhody s regulárnym výrazom |
| `!~` | test nezhody s regulárnym výrazom |
| `&&` | logické A, musia platiť obe podmienky |
| `||` | logické ALEBO, stačí jedna platná podmienka |
| `gsub()` | globálne nahradenie textu v hodnote alebo poli |
| `END` | blok, ktorý sa vykoná až po spracovaní celého vstupu |
| `pole[kľúč]++` | asociatívne pole, používa sa napríklad na počítanie výskytov |
| `|` | pipe, výstup jedného príkazu ide ako vstup do ďalšieho príkazu |
| `2>/dev/null` | potlačí chybové hlásenia, napríklad pri neexistujúcich alebo neprístupných súboroch |

## 🧩 Konfiguračné súbory a systémové databázy

**1. Aktívne skupiny zo súboru `/etc/group`**

```bash
awk -F: '$4 != "" { print $1, $4 }' /etc/group
```

Vypíše skupiny, ktoré majú explicitne uvedených členov. Hodí sa pri kontrole oprávnení.

Vysvetlenie:

- `-F:` nastavuje dvojbodku ako oddeľovač polí, pretože `/etc/group` používa formát `skupina:x:GID:členovia`.
- `$1` je názov skupiny.
- `$4` je zoznam členov skupiny.
- `$4 != ""` znamená, že štvrté pole nesmie byť prázdne.
- `{ print $1, $4 }` vypíše názov skupiny a jej členov.

**2. Kontrola privilegovaných skupín**

```bash
awk -F: '$1 ~ /sudo|wheel|adm|docker|lxd/ { print $1, $4 }' /etc/group
```

Zobrazí skupiny, ktoré môžu mať zvýšené oprávnenia. Dôležité pri bezpečnostnom audite.

Vysvetlenie:

- `-F:` nastavuje oddeľovač polí na dvojbodku.
- `$1` je názov skupiny.
- `~` znamená, že pole sa porovnáva s regulárnym výrazom.
- `/sudo|wheel|adm|docker|lxd/` hľadá názvy privilegovaných alebo rizikových skupín.
- `|` vo vnútri regulárneho výrazu znamená alternatívu, teda `sudo` alebo `wheel` alebo `adm` a podobne.
- `$4` vypíše členov danej skupiny.

**3. Aktívne pravidlá v `/etc/sudoers`**

```bash
sudo awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/sudoers
```

Zobrazí aktívne pravidlá bez komentárov a prázdnych riadkov. Súbor iba čítame. Na úpravu používame `visudo`.

Vysvetlenie:

- `sudo` je potrebné preto, že `/etc/sudoers` býva čitateľný iba pre administrátora.
- `NF > 0` vyberá iba neprázdne riadky.
- `$1 !~ /^#/` znamená, že prvé pole sa nesmie začínať znakom `#`.
- `^` v regulárnom výraze znamená začiatok textu.
- `{ print }` je skrátený zápis pre výpis celého riadku, teda ako `print $0`.

**4. SSH konfigurácia bez komentárov**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/ssh/sshd_config
```

Vypíše aktívne nastavenia SSH servera.

Vysvetlenie:

- `NF > 0` odstráni prázdne riadky.
- `$1 !~ /^#/` odstráni komentáre začínajúce znakom `#`.
- Príkaz nemení konfiguráciu, iba ju číta.
- Výstup je vhodný na rýchlu kontrolu reálne aktívnych konfiguračných riadkov.

**5. Kontrola dôležitých SSH nastavení**

```bash
awk '$1 ~ /Port|PermitRootLogin|PasswordAuthentication|PubkeyAuthentication|AllowUsers|AllowGroups/ { print }' /etc/ssh/sshd_config
```

Pomôže rýchlo nájsť nastavenia, ktoré ovplyvňujú bezpečnosť vzdialeného prístupu.

Vysvetlenie:

- `$1` je prvé slovo na riadku, v SSH konfigurácii zvyčajne názov direktívy.
- `~` testuje zhodu s regulárnym výrazom.
- Regulárny výraz obsahuje dôležité SSH voľby ako `PermitRootLogin` a `PasswordAuthentication`.
- `{ print }` vypíše celý riadok s nájdeným nastavením.

**6. Aktívne záznamy v `/etc/fstab`**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print $1, $2, $3, $4 }' /etc/fstab
```

Zobrazí zariadenie, mount point, typ súborového systému a mount voľby.

Vysvetlenie:

- `/etc/fstab` definuje pripájanie diskov a súborových systémov.
- `NF > 0` preskočí prázdne riadky.
- `$1 !~ /^#/` preskočí komentáre.
- `$1` je zariadenie alebo UUID.
- `$2` je mount point.
- `$3` je typ súborového systému.
- `$4` sú mount voľby.

**7. Hľadanie mount záznamov bez bezpečnostných volieb**

```bash
awk 'NF > 0 && $1 !~ /^#/ && $4 !~ /nodev|nosuid|noexec/ { print }' /etc/fstab
```

Pomáha odhaliť miesta, kde môžu chýbať bezpečnostné voľby `nodev`, `nosuid` alebo `noexec`.

Vysvetlenie:

- `&&` znamená, že musia platiť všetky podmienky.
- `$4` obsahuje mount voľby.
- `$4 !~ /nodev|nosuid|noexec/` vyberie riadky, kde sa nenachádza ani jedna z uvedených bezpečnostných volieb.
- Výsledok treba manuálne posúdiť, pretože nie každý mount point musí tieto voľby používať.

**8. DNS resolvery**

```bash
awk '$1 == "nameserver" { print $2 }' /etc/resolv.conf
```

Vypíše DNS servery používané systémom.

Vysvetlenie:

- `$1 == "nameserver"` vyberá iba riadky, ktorých prvé pole je `nameserver`.
- `$2` je IP adresa DNS servera.
- Hodí sa pri diagnostike DNS problémov.

**9. Lokálne hostname záznamy**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/hosts
```

Zobrazí aktívne lokálne DNS záznamy bez komentárov.

Vysvetlenie:

- `/etc/hosts` obsahuje lokálne mapovanie IP adries na názvy.
- `NF > 0` filtruje prázdne riadky.
- `$1 !~ /^#/` filtruje komentáre.
- `{ print }` zobrazí celý aktívny záznam.

**10. Aktívne APT repozitáre**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/apt/sources.list
```

Zobrazí aktívne zdroje balíkov. Na novších systémoch treba skontrolovať aj `/etc/apt/sources.list.d/`.

Vysvetlenie:

- `/etc/apt/sources.list` obsahuje zdroje balíkov pre Debian/Ubuntu/Kali.
- `NF > 0` preskočí prázdne riadky.
- `$1 !~ /^#/` preskočí komentáre.
- Výstup pomáha overiť, odkiaľ systém sťahuje balíky.

**11. APT zdroje z viacerých súborov**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print FILENAME ": " $0 }' /etc/apt/sources.list /etc/apt/sources.list.d/*.list 2>/dev/null
```

Vypíše aktívne zdroje aj s názvom súboru.

Vysvetlenie:

- AWK spracuje viac vstupných súborov naraz.
- `FILENAME` je vstavaná premenná s názvom aktuálneho súboru.
- `$0` je celý aktuálny riadok.
- `2>/dev/null` potlačí chyby, napríklad ak neexistujú `.list` súbory alebo niektoré nie sú čitateľné.

**12. Výpis služieb a portov zo `/etc/services`**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print $1, $2 }' /etc/services | head
```

Zobrazí názov služby a port. Príklad zároveň používa pipe do `head`.

Vysvetlenie:

- `$1` je názov služby.
- `$2` je port a protokol, napríklad `22/tcp`.
- `| head` obmedzí výstup na prvých 10 riadkov.
- Používa sa pri orientačnej kontrole známych portov.

**13. Vyhľadanie známych služieb**

```bash
awk '$1 ~ /ssh|http|https|mysql|postgres|domain/ { print $1, $2 }' /etc/services
```

Pomáha rýchlo nájsť porty známych služieb.

Vysvetlenie:

- `$1` je názov služby.
- Regulárny výraz hľadá služby ako `ssh`, `http`, `https`, `mysql`, `postgres` a `domain`.
- `$2` zobrazí port a protokol.

## 🧠 /proc a systémové informácie

**14. Čítanie základných údajov o pamäti**

```bash
awk '/MemTotal|MemAvailable|SwapTotal|SwapFree/ { print $1, $2, $3 }' /proc/meminfo
```

Zobrazí základné informácie o RAM a swape.

Vysvetlenie:

- `/proc/meminfo` obsahuje informácie o pamäti jadra Linuxu.
- `/MemTotal|MemAvailable|SwapTotal|SwapFree/` vyberá len riadky s týmito názvami.
- `$1` je názov položky.
- `$2` je číselná hodnota.
- `$3` je jednotka, typicky `kB`.

**15. Informácie o CPU**

```bash
awk -F: '/model name|cpu cores|siblings/ { print $1 ":" $2 }' /proc/cpuinfo | head
```

Vypíše model CPU, jadrá a súvisiace údaje. Pipe do `head` obmedzí dlhý výstup.

Vysvetlenie:

- `-F:` nastaví oddeľovač polí na dvojbodku.
- `/model name|cpu cores|siblings/` vyberá riadky s modelom CPU, počtom jadier a počtom vlákien.
- `$1` je názov položky.
- `$2` je hodnota.
- `head` skráti výstup, pretože `/proc/cpuinfo` opakuje údaje pre viac jadier alebo vlákien.

**16. Kontrola IP forwarding**

```bash
awk '{ if ($1 == 1) print "IP forwarding je zapnuty"; else print "IP forwarding je vypnuty" }' /proc/sys/net/ipv4/ip_forward
```

Dôležité pri routingu, NAT, laboch, kontajneroch a bezpečnostnej kontrole.

Vysvetlenie:

- Súbor obsahuje hodnotu `0` alebo `1`.
- `$1 == 1` testuje, či je IP forwarding zapnutý.
- `if ... else` je podmienka priamo v AWK programe.
- Výstup je čitateľná veta namiesto samotnej hodnoty `0` alebo `1`.

## 💽 Disky, procesy a služby

**17. Kontrola zaplnenia diskov**

```bash
df -h | awk 'NR > 1 { print $1, $5, $6 }'
```

Používa pipe z `df -h` do `awk`. Vypíše zariadenie, zaplnenie a mount point.

Vysvetlenie:

- `df -h` zobrazí zaplnenie súborových systémov v čitateľných jednotkách.
- `-h` znamená human-readable, teda hodnoty ako `G`, `M`.
- `NR > 1` preskočí hlavičku výstupu.
- `$1` je súborový systém.
- `$5` je percento zaplnenia.
- `$6` je mount point.

**18. Disky zaplnené nad 80 %**

```bash
df -h | awk 'NR > 1 { gsub("%","",$5); if ($5 >= 80) print $1, $5 "%", $6 }'
```

Jednoduchý monitoring diskovej kapacity.

Vysvetlenie:

- `df -h` dáta posiela cez pipe do AWK.
- `NR > 1` preskočí hlavičku.
- `gsub("%","",$5)` odstráni znak `%` z piateho poľa.
- `if ($5 >= 80)` vyberie iba disky zaplnené na 80 % a viac.
- Pri výpise sa znak `%` doplní späť cez `$5 "%"`.

**19. Procesy s vyššou spotrebou CPU**

```bash
ps aux | awk 'NR > 1 && $3 > 5 { print $1, $2, $3, $11 }'
```

Zobrazí používateľa, PID, CPU a názov príkazu pri procesoch s CPU nad 5 %.

Vysvetlenie:

- `ps aux` vypíše bežiace procesy.
- `a` znamená procesy všetkých používateľov s terminálom.
- `u` pridá používateľsky čitateľný formát.
- `x` zahrnie aj procesy bez terminálu.
- `NR > 1` preskočí hlavičku.
- `$3 > 5` filtruje procesy s CPU nad 5 %.
- `$1` je používateľ, `$2` PID, `$3` CPU %, `$11` názov príkazu.

**20. Procesy spustené pod rootom**

```bash
ps aux | awk '$1 == "root" { print $2, $11 }' | head
```

Vhodné na rýchlu kontrolu root procesov. Pipe do `head` obmedzí výstup.

Vysvetlenie:

- `$1 == "root"` vyberá procesy používateľa `root`.
- `$2` je PID.
- `$11` je názov spusteného príkazu.
- `head` obmedzí výstup na prvých 10 riadkov.

**21. Najviac pamäte používajúce procesy**

```bash
ps aux --sort=-%mem | awk 'NR <= 10 { print $1, $2, $4, $11 }'
```

Zobrazí prvých 10 procesov podľa spotreby RAM.

Vysvetlenie:

- `--sort=-%mem` zoradí procesy zostupne podľa spotreby pamäte.
- Znak `-` pred `%mem` znamená zostupné zoradenie.
- `NR <= 10` vypíše prvých 10 riadkov.
- `$4` je percento využitej pamäte.
- Tento príkaz zahŕňa aj hlavičku, preto je vhodný na rýchle demo, nie presný export.

**22. Výpis aktívnych systemd služieb**

```bash
systemctl --type=service --state=running | awk 'NR > 1 { print $1, $2, $3 }'
```

Zobrazí bežiace služby.

Vysvetlenie:

- `systemctl` spravuje systemd jednotky.
- `--type=service` obmedzí výstup iba na služby.
- `--state=running` zobrazí iba bežiace služby.
- `NR > 1` preskočí hlavičku.
- `$1`, `$2`, `$3` typicky reprezentujú názov jednotky, stav načítania a aktívny stav.

**23. Hľadanie zlyhaných služieb**

```bash
systemctl --failed | awk 'NR > 1 && $1 != "UNIT" { print $1, $2, $3, $4 }'
```

Pomáha pri diagnostike systému.

Vysvetlenie:

- `systemctl --failed` vypíše zlyhané systemd jednotky.
- `NR > 1` preskočí prvý riadok.
- `$1 != "UNIT"` dodatočne filtruje hlavičku.
- Výstup ukáže názov jednotky a jej stavové polia.

**24. Chyby z journalctl**

```bash
journalctl -p err -n 50 --no-pager | awk '{ print NR, $0 }'
```

Vypíše posledných 50 chýb s číslom riadku.

Vysvetlenie:

- `journalctl` číta systemd journal.
- `-p err` filtruje záznamy s prioritou error.
- `-n 50` zobrazí posledných 50 záznamov.
- `--no-pager` vypne stránkovanie cez `less`.
- `NR` pridá poradové číslo riadku vo výstupe AWK.
- `$0` je celý logovací riadok.

## 🌐 Sieť, porty a routing

**25. Počúvajúce TCP porty**

```bash
ss -tlnp | awk 'NR > 1 { print $1, $4, $6 }'
```

Zobrazí protokol, lokálnu adresu/port a proces. Niektoré informácie vyžadujú `sudo`.

Vysvetlenie:

- `ss` zobrazuje sockety a sieťové spojenia.
- `-t` zobrazí TCP sockety.
- `-l` zobrazí iba počúvajúce sockety.
- `-n` nevykonáva preklad portov a adries na názvy.
- `-p` zobrazí proces, ak má používateľ oprávnenie.
- `$1` je stav/protokol, `$4` lokálna adresa a port, `$6` procesové informácie.

**26. Počúvajúce porty zoradené cez pipe**

```bash
ss -tuln | awk 'NR > 1 { print $1, $5 }' | sort | uniq
```

Kombinuje `ss`, `awk`, `sort` a `uniq`. Praktické pri sieťovej kontrole.

Vysvetlenie:

- `-t` zobrazí TCP.
- `-u` zobrazí UDP.
- `-l` zobrazí počúvajúce porty.
- `-n` ponechá číselné porty.
- `awk` vyberie protokol a lokálnu adresu/port.
- `sort` zoradí riadky.
- `uniq` odstráni duplicitné riadky, funguje správne hlavne po zoradení.

**27. Výpis sieťových rozhraní cez ip**

```bash
ip -br addr | awk '{ print $1, $2, $3 }'
```

Zobrazí rozhranie, stav a IP adresu.

Vysvetlenie:

- `ip addr` zobrazuje adresy sieťových rozhraní.
- `-br` znamená brief, teda stručný formát.
- `$1` je názov rozhrania.
- `$2` je stav, napríklad `UP` alebo `DOWN`.
- `$3` je prvá adresa alebo ďalšia informácia podľa výstupu.

**28. Len aktívne sieťové rozhrania**

```bash
ip -br addr | awk '$2 == "UP" { print $1, $3 }'
```

Rýchla kontrola aktívnych sieťových rozhraní.

Vysvetlenie:

- `$2 == "UP"` filtruje iba aktívne rozhrania.
- `$1` je názov rozhrania.
- `$3` je IP adresa alebo prvá adresa priradená rozhraniu.

**29. Routing tabuľka**

```bash
ip route | awk '{ print NR, $0 }'
```

Vypíše routing tabuľku s číslom riadku.

Vysvetlenie:

- `ip route` zobrazí smerovaciu tabuľku.
- `NR` pridá číslo riadku.
- `$0` vypíše celý riadok bez zmeny.
- Číslovanie riadkov je praktické pri vysvetľovaní výstupu vo videu.

**30. Predvolená brána**

```bash
ip route | awk '$1 == "default" { print $3 }'
```

Zobrazí IP adresu default gateway.

Vysvetlenie:

- `$1 == "default"` vyberá predvolenú trasu.
- `$3` je typicky IP adresa brány za slovom `via`.
- Používa sa pri diagnostike konektivity mimo lokálnej siete.

**31. Výpis firewall pravidiel cez ufw**

```bash
sudo ufw status numbered | awk 'NR > 3 { print }'
```

Zobrazí očíslované pravidlá firewallu.

Vysvetlenie:

- `sudo` je často potrebné na čítanie stavu firewallu.
- `ufw status numbered` zobrazí UFW pravidlá s číslami.
- `NR > 3` preskočí úvodné informačné riadky.
- `{ print }` vypíše zvyšné pravidlá.

**32. Výpis otvorených súborov procesu cez lsof**

```bash
sudo lsof -i | awk 'NR > 1 { print $1, $2, $8, $9 }' | head
```

Vhodné pri diagnostike sieťových spojení a procesov.

Vysvetlenie:

- `lsof` vypisuje otvorené súbory.
- `-i` obmedzí výstup na sieťové súbory a spojenia.
- `sudo` zobrazí viac procesových informácií.
- `NR > 1` preskočí hlavičku.
- `$1` je názov procesu, `$2` PID, `$8` typ alebo stav, `$9` sieťový názov/adresa.
- `head` skráti výstup.

## 📜 Logy a bezpečnostná analýza

**33. Neúspešné SSH prihlásenia z auth logu**

```bash
sudo awk '/Failed password/ { print }' /var/log/auth.log
```

Zobrazí neúspešné pokusy o prihlásenie. Typické pre Ubuntu/Debian.

Vysvetlenie:

- `sudo` môže byť potrebné na čítanie `/var/log/auth.log`.
- `/Failed password/` je vzor, ktorý vyberá riadky obsahujúce tento text.
- `{ print }` vypíše celý riadok.
- Na Kali alebo iných systémoch môže byť log v inom súbore alebo v journale.

**34. Počítanie IP adries pri neúspešných SSH pokusoch**

```bash
sudo awk '/Failed password/ { ip[$NF]++ } END { for (i in ip) print i, ip[i] }' /var/log/auth.log
```

Spočíta výskyty IP adries. Formát logu sa môže líšiť podľa distribúcie.

Vysvetlenie:

- `/Failed password/` vyberie iba neúspešné SSH prihlasovania.
- `$NF` znamená posledné pole riadku.
- `ip[$NF]++` vytvorí asociatívne pole, kde kľúč je IP adresa a hodnota je počet výskytov.
- `END` sa spustí až po spracovaní celého logu.
- `for (i in ip)` prejde všetky uložené IP adresy.
- Poradie výstupu z asociatívneho poľa nie je garantované.

**35. Najčastejšie IP adresy z auth logu cez pipe**

```bash
sudo grep "Failed password" /var/log/auth.log | awk '{ print $NF }' | sort | uniq -c | sort -nr | head
```

Kombinácia `grep`, `awk`, `sort`, `uniq` a `head`. Vhodné na rýchlu bezpečnostnú analýzu.

Vysvetlenie:

- `grep "Failed password"` vyfiltruje iba neúspešné SSH pokusy.
- `awk '{ print $NF }'` vypíše posledné pole, často IP adresu.
- `sort` zoradí IP adresy.
- `uniq -c` spočíta rovnaké riadky.
- `sort -nr` zoradí výsledky číselne a zostupne.
- `head` zobrazí najčastejšie položky.

**36. Webové status kódy z Apache access logu**

```bash
sudo awk '{ code[$9]++ } END { for (c in code) print c, code[c] }' /var/log/apache2/access.log
```

Spočíta HTTP status kódy.

Vysvetlenie:

- V bežnom Apache access logu býva `$9` HTTP status kód.
- `code[$9]++` počíta výskyty jednotlivých status kódov.
- `END` vypíše výsledok až po spracovaní celého logu.
- Výstup nie je automaticky zoradený.

**37. Najaktívnejšie IP adresy z Apache logu**

```bash
sudo awk '{ print $1 }' /var/log/apache2/access.log | sort | uniq -c | sort -nr | head
```

Zobrazí IP adresy s najväčším počtom požiadaviek.

Vysvetlenie:

- `$1` je pri bežnom Apache logu klientská IP adresa.
- `sort` pripraví dáta pre `uniq`.
- `uniq -c` spočíta opakovania.
- `sort -nr` zoradí najvyššie počty na začiatok.
- `head` zobrazí najaktívnejšie IP adresy.

**38. Požiadavky so statusom 404**

```bash
sudo awk '$9 == 404 { print $1, $7, $9 }' /var/log/apache2/access.log | head
```

Pomáha pri identifikácii skenovania, botov alebo chýbajúcich URL.

Vysvetlenie:

- `$9 == 404` vyberá riadky so stavovým kódom 404.
- `$1` je IP adresa klienta.
- `$7` je požadovaná URL cesta.
- `$9` je status kód.
- `head` skráti výstup na prvých 10 riadkov.

**39. Serverové chyby 5xx**

```bash
sudo awk '$9 ~ /^5/ { print $1, $7, $9 }' /var/log/apache2/access.log
```

Zobrazí serverové chyby, ktoré môžu signalizovať problém aplikácie.

Vysvetlenie:

- `$9` je HTTP status kód.
- `$9 ~ /^5/` vyberá všetky status kódy začínajúce číslom 5.
- `^5` znamená, že hodnota sa musí začínať päťkou.
- Typicky ide o chyby 500, 502, 503, 504.

**40. Analýza Nginx access logu**

```bash
sudo awk '{ print $1, $7, $9 }' /var/log/nginx/access.log | head
```

Zobrazí IP adresu, URL a HTTP status kód.

Vysvetlenie:

- `$1` je IP adresa klienta.
- `$7` je URL cesta.
- `$9` je HTTP status kód v bežnom combined log formáte.
- `head` obmedzí výstup.
- Pri vlastnom Nginx log formáte sa čísla polí môžu líšiť.

**41. Najčastejšie URL v Nginx logu**

```bash
sudo awk '{ print $7 }' /var/log/nginx/access.log | sort | uniq -c | sort -nr | head
```

Pomáha zistiť, ktoré endpointy sú najviac používané alebo skenované.

Vysvetlenie:

- `$7` je URL cesta v typickom access logu.
- `sort` zoradí rovnaké URL vedľa seba.
- `uniq -c` spočíta počet výskytov.
- `sort -nr` zoradí výsledky podľa počtu zostupne.
- `head` vypíše najčastejšie URL.

**42. Kontrola posledných prihlásení cez `last`**

```bash
last | awk 'NF >= 5 { print $1, $3, $4, $5 }' | head
```

Zobrazí používateľa, zdroj a čas posledných prihlásení.

Vysvetlenie:

- `last` číta históriu prihlásení zo systémových záznamov.
- `NF >= 5` filtruje riadky, ktoré majú aspoň päť polí.
- `$1` je používateľ.
- `$3` býva zdroj alebo adresa.
- `$4`, `$5` sú časové údaje podľa formátu výstupu.
- `head` zobrazí iba začiatok výstupu.

**43. Neúspešné prihlásenia cez `lastb`**

```bash
sudo lastb | awk 'NF >= 5 { print $1, $3, $4, $5 }' | head
```

Vhodné na kontrolu neúspešných login pokusov. Dostupnosť závisí od systému a logovania.

Vysvetlenie:

- `lastb` zobrazuje neúspešné prihlasovania.
- `sudo` môže byť potrebné na čítanie príslušných systémových záznamov.
- `NF >= 5` filtruje neúplné riadky.
- Význam polí závisí od formátu výstupu, preto je vhodné ho overiť príkazom `lastb | head`.

## ⏱️ Cron, balíky a inventár systému

**44. Kontrola cronu bez komentárov**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/crontab
```

Zobrazí aktívne plánované úlohy v systémovom crone.

Vysvetlenie:

- `/etc/crontab` obsahuje systémové plánované úlohy.
- `NF > 0` odstráni prázdne riadky.
- `$1 !~ /^#/` odstráni komentáre.
- `{ print }` vypíše aktívne riadky.

**45. Výpis cron súborov cez pipe**

```bash
ls -1 /etc/cron.d 2>/dev/null | awk '{ print "/etc/cron.d/" $1 }'
```

Zobrazí cesty k cron súborom.

Vysvetlenie:

- `ls -1` vypíše jeden názov súboru na jeden riadok.
- `2>/dev/null` potlačí chyby, napríklad ak adresár neexistuje alebo nie je prístupný.
- `awk` doplní pred názov súboru cestu `/etc/cron.d/`.
- `$1` je názov súboru z výstupu `ls`.

**46. Hľadanie podozrivých reťazcov v cron súboroch**

```bash
sudo grep -R "curl\|wget\|nc\|bash" /etc/cron* 2>/dev/null | awk -F: '{ print $1, $2 }'
```

Pomáha hľadať potenciálne rizikové plánované úlohy. Výsledok treba vždy manuálne overiť.

Vysvetlenie:

- `sudo` umožní čítať systémové cron súbory.
- `grep -R` hľadá rekurzívne v súboroch a adresároch.
- `curl\|wget\|nc\|bash` hľadá reťazce často používané v automatizovaných skriptoch.
- `2>/dev/null` potlačí chybové hlásenia.
- `awk -F:` nastaví dvojbodku ako oddeľovač, pretože `grep` vracia formát `súbor:riadok`.
- `$1` je názov súboru.
- `$2` je časť nájdeného riadku za prvou dvojbodkou.

**47. Kontrola systémových používateľov cez `getent` bez priameho čítania `/etc/passwd`**

```bash
getent passwd | awk -F: '$7 !~ /nologin|false/ { print $1, $7 }'
```

Nepoužíva priamo `/etc/passwd`, ale systémovú databázu cez NSS. Hodí sa aj pri LDAP/AD integrácii.

Vysvetlenie:

- `getent passwd` číta používateľov cez systémové rozhranie NSS.
- `-F:` nastaví oddeľovač polí na dvojbodku.
- `$7` je prihlasovací shell.
- `$7 !~ /nologin|false/` vyberá účty, ktoré nemajú shell typu `nologin` alebo `false`.
- `$1` je používateľské meno.

**48. Kontrola skupín cez `getent`**

```bash
getent group | awk -F: '$1 ~ /sudo|wheel|docker|adm/ { print $1, $4 }'
```

Bezpečnostná kontrola privilegovaných skupín cez systémové rozhranie.

Vysvetlenie:

- `getent group` číta skupiny cez NSS.
- `-F:` nastaví dvojbodku ako oddeľovač.
- `$1` je názov skupiny.
- Regulárny výraz vyberá skupiny s potenciálne vyššími oprávneniami.
- `$4` je zoznam členov skupiny.

**49. Kontrola balíkov cez dpkg**

```bash
dpkg -l | awk '$1 == "ii" { print $2, $3 }' | head
```

Zobrazí nainštalované balíky a verzie.

Vysvetlenie:

- `dpkg -l` vypíše balíky v Debian/Ubuntu/Kali systémoch.
- `$1 == "ii"` vyberá balíky, ktoré sú nainštalované.
- `$2` je názov balíka.
- `$3` je verzia balíka.
- `head` skráti výstup.

**50. Hľadanie bezpečnostných balíkov**

```bash
dpkg -l | awk '$2 ~ /openssh|sudo|ufw|apparmor|auditd/ { print $2, $3 }'
```

Užitočné pri základnom bezpečnostnom inventári.

Vysvetlenie:

- `dpkg -l` poskytne zoznam balíkov.
- `$2` je názov balíka.
- `$2 ~ /openssh|sudo|ufw|apparmor|auditd/` hľadá bezpečnostne významné balíky.
- `$3` je verzia balíka.
- Výsledok pomáha pri rýchlej kontrole bezpečnostných komponentov systému.

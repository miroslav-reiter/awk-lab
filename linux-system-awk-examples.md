# 🐧 Praktické príklady AWK nad Linux systémom

Tento súbor obsahuje praktické príklady použitia `awk` nad reálnymi systémovými súbormi a výstupmi príkazov v Linuxe. Je určený pre administrátorov, DevOps tímy, odborníkov na kybernetickú bezpečnosť, etických hackerov, testerov a technických uchádzačov na pracovné pohovory.

Príklady zámerne nepoužívajú `/etc/passwd`, pretože ten je riešený v hlavnom `README.md` a v základných ukážkach.

## 🔒 Bezpečnostná poznámka

Príkazy v tomto súbore sú určené primárne na čítanie, filtrovanie a analýzu. Pri súboroch ako `/etc/sudoers`, `/etc/ssh/sshd_config`, `/etc/fstab`, logoch a konfiguráciách nemeníme obsah priamo cez `awk` bez zálohy, testovania a znalosti dopadov.

Niektoré príkazy používajú `sudo`, pretože systémové logy a bezpečnostné konfigurácie nemusia byť dostupné bežnému používateľovi.

## 🧩 Konfiguračné súbory a systémové databázy

**1. Aktívne skupiny zo súboru `/etc/group`**

```bash
awk -F: '$4 != "" { print $1, $4 }' /etc/group
```

Vypíše skupiny, ktoré majú explicitne uvedených členov. Hodí sa pri kontrole oprávnení.

**2. Kontrola privilegovaných skupín**

```bash
awk -F: '$1 ~ /sudo|wheel|adm|docker|lxd/ { print $1, $4 }' /etc/group
```

Zobrazí skupiny, ktoré môžu mať zvýšené oprávnenia. Dôležité pri bezpečnostnom audite.

**3. Aktívne pravidlá v `/etc/sudoers`**

```bash
sudo awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/sudoers
```

Zobrazí aktívne pravidlá bez komentárov a prázdnych riadkov. Súbor iba čítame. Na úpravu používame `visudo`.

**4. SSH konfigurácia bez komentárov**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/ssh/sshd_config
```

Vypíše aktívne nastavenia SSH servera.

**5. Kontrola dôležitých SSH nastavení**

```bash
awk '$1 ~ /Port|PermitRootLogin|PasswordAuthentication|PubkeyAuthentication|AllowUsers|AllowGroups/ { print }' /etc/ssh/sshd_config
```

Pomôže rýchlo nájsť nastavenia, ktoré ovplyvňujú bezpečnosť vzdialeného prístupu.

**6. Aktívne záznamy v `/etc/fstab`**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print $1, $2, $3, $4 }' /etc/fstab
```

Zobrazí zariadenie, mount point, typ súborového systému a mount voľby.

**7. Hľadanie mount záznamov bez bezpečnostných volieb**

```bash
awk 'NF > 0 && $1 !~ /^#/ && $4 !~ /nodev|nosuid|noexec/ { print }' /etc/fstab
```

Pomáha odhaliť miesta, kde môžu chýbať bezpečnostné voľby `nodev`, `nosuid` alebo `noexec`.

**8. DNS resolvery**

```bash
awk '$1 == "nameserver" { print $2 }' /etc/resolv.conf
```

Vypíše DNS servery používané systémom.

**9. Lokálne hostname záznamy**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/hosts
```

Zobrazí aktívne lokálne DNS záznamy bez komentárov.

**10. Aktívne APT repozitáre**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/apt/sources.list
```

Zobrazí aktívne zdroje balíkov. Na novších systémoch treba skontrolovať aj `/etc/apt/sources.list.d/`.

**11. APT zdroje z viacerých súborov**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print FILENAME ": " $0 }' /etc/apt/sources.list /etc/apt/sources.list.d/*.list 2>/dev/null
```

Vypíše aktívne zdroje aj s názvom súboru.

**12. Výpis služieb a portov zo `/etc/services`**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print $1, $2 }' /etc/services | head
```

Zobrazí názov služby a port. Príklad zároveň používa pipe do `head`.

**13. Vyhľadanie známych služieb**

```bash
awk '$1 ~ /ssh|http|https|mysql|postgres|domain/ { print $1, $2 }' /etc/services
```

Pomáha rýchlo nájsť porty známych služieb.

## 🧠 /proc a systémové informácie

**14. Čítanie základných údajov o pamäti**

```bash
awk '/MemTotal|MemAvailable|SwapTotal|SwapFree/ { print $1, $2, $3 }' /proc/meminfo
```

Zobrazí základné informácie o RAM a swape.

**15. Informácie o CPU**

```bash
awk -F: '/model name|cpu cores|siblings/ { print $1 ":" $2 }' /proc/cpuinfo | head
```

Vypíše model CPU, jadrá a súvisiace údaje. Pipe do `head` obmedzí dlhý výstup.

**16. Kontrola IP forwarding**

```bash
awk '{ if ($1 == 1) print "IP forwarding je zapnuty"; else print "IP forwarding je vypnuty" }' /proc/sys/net/ipv4/ip_forward
```

Dôležité pri routingu, NAT, laboch, kontajneroch a bezpečnostnej kontrole.

## 💽 Disky, procesy a služby

**17. Kontrola zaplnenia diskov**

```bash
df -h | awk 'NR > 1 { print $1, $5, $6 }'
```

Používa pipe z `df -h` do `awk`. Vypíše zariadenie, zaplnenie a mount point.

**18. Disky zaplnené nad 80 %**

```bash
df -h | awk 'NR > 1 { gsub("%","",$5); if ($5 >= 80) print $1, $5 "%", $6 }'
```

Jednoduchý monitoring diskovej kapacity.

**19. Procesy s vyššou spotrebou CPU**

```bash
ps aux | awk 'NR > 1 && $3 > 5 { print $1, $2, $3, $11 }'
```

Zobrazí používateľa, PID, CPU a názov príkazu pri procesoch s CPU nad 5 %.

**20. Procesy spustené pod rootom**

```bash
ps aux | awk '$1 == "root" { print $2, $11 }' | head
```

Vhodné na rýchlu kontrolu root procesov. Pipe do `head` obmedzí výstup.

**21. Najviac pamäte používajúce procesy**

```bash
ps aux --sort=-%mem | awk 'NR <= 10 { print $1, $2, $4, $11 }'
```

Zobrazí prvých 10 procesov podľa spotreby RAM.

**22. Výpis aktívnych systemd služieb**

```bash
systemctl --type=service --state=running | awk 'NR > 1 { print $1, $2, $3 }'
```

Zobrazí bežiace služby.

**23. Hľadanie zlyhaných služieb**

```bash
systemctl --failed | awk 'NR > 1 && $1 != "UNIT" { print $1, $2, $3, $4 }'
```

Pomáha pri diagnostike systému.

**24. Chyby z journalctl**

```bash
journalctl -p err -n 50 --no-pager | awk '{ print NR, $0 }'
```

Vypíše posledných 50 chýb s číslom riadku.

## 🌐 Sieť, porty a routing

**25. Počúvajúce TCP porty**

```bash
ss -tlnp | awk 'NR > 1 { print $1, $4, $6 }'
```

Zobrazí protokol, lokálnu adresu/port a proces. Niektoré informácie vyžadujú `sudo`.

**26. Počúvajúce porty zoradené cez pipe**

```bash
ss -tuln | awk 'NR > 1 { print $1, $5 }' | sort | uniq
```

Kombinuje `ss`, `awk`, `sort` a `uniq`. Praktické pri sieťovej kontrole.

**27. Výpis sieťových rozhraní cez ip**

```bash
ip -br addr | awk '{ print $1, $2, $3 }'
```

Zobrazí rozhranie, stav a IP adresu.

**28. Len aktívne sieťové rozhrania**

```bash
ip -br addr | awk '$2 == "UP" { print $1, $3 }'
```

Rýchla kontrola aktívnych sieťových rozhraní.

**29. Routing tabuľka**

```bash
ip route | awk '{ print NR, $0 }'
```

Vypíše routing tabuľku s číslom riadku.

**30. Predvolená brána**

```bash
ip route | awk '$1 == "default" { print $3 }'
```

Zobrazí IP adresu default gateway.

**31. Výpis firewall pravidiel cez ufw**

```bash
sudo ufw status numbered | awk 'NR > 3 { print }'
```

Zobrazí očíslované pravidlá firewallu.

**32. Výpis otvorených súborov procesu cez lsof**

```bash
sudo lsof -i | awk 'NR > 1 { print $1, $2, $8, $9 }' | head
```

Vhodné pri diagnostike sieťových spojení a procesov.

## 📜 Logy a bezpečnostná analýza

**33. Neúspešné SSH prihlásenia z auth logu**

```bash
sudo awk '/Failed password/ { print }' /var/log/auth.log
```

Zobrazí neúspešné pokusy o prihlásenie. Typické pre Ubuntu/Debian.

**34. Počítanie IP adries pri neúspešných SSH pokusoch**

```bash
sudo awk '/Failed password/ { ip[$NF]++ } END { for (i in ip) print i, ip[i] }' /var/log/auth.log
```

Spočíta výskyty IP adries. Formát logu sa môže líšiť podľa distribúcie.

**35. Najčastejšie IP adresy z auth logu cez pipe**

```bash
sudo grep "Failed password" /var/log/auth.log | awk '{ print $NF }' | sort | uniq -c | sort -nr | head
```

Kombinácia `grep`, `awk`, `sort`, `uniq` a `head`. Vhodné na rýchlu bezpečnostnú analýzu.

**36. Webové status kódy z Apache access logu**

```bash
sudo awk '{ code[$9]++ } END { for (c in code) print c, code[c] }' /var/log/apache2/access.log
```

Spočíta HTTP status kódy.

**37. Najaktívnejšie IP adresy z Apache logu**

```bash
sudo awk '{ print $1 }' /var/log/apache2/access.log | sort | uniq -c | sort -nr | head
```

Zobrazí IP adresy s najväčším počtom požiadaviek.

**38. Požiadavky so statusom 404**

```bash
sudo awk '$9 == 404 { print $1, $7, $9 }' /var/log/apache2/access.log | head
```

Pomáha pri identifikácii skenovania, botov alebo chýbajúcich URL.

**39. Serverové chyby 5xx**

```bash
sudo awk '$9 ~ /^5/ { print $1, $7, $9 }' /var/log/apache2/access.log
```

Zobrazí serverové chyby, ktoré môžu signalizovať problém aplikácie.

**40. Analýza Nginx access logu**

```bash
sudo awk '{ print $1, $7, $9 }' /var/log/nginx/access.log | head
```

Zobrazí IP adresu, URL a HTTP status kód.

**41. Najčastejšie URL v Nginx logu**

```bash
sudo awk '{ print $7 }' /var/log/nginx/access.log | sort | uniq -c | sort -nr | head
```

Pomáha zistiť, ktoré endpointy sú najviac používané alebo skenované.

**42. Kontrola posledných prihlásení cez `last`**

```bash
last | awk 'NF >= 5 { print $1, $3, $4, $5 }' | head
```

Zobrazí používateľa, zdroj a čas posledných prihlásení.

**43. Neúspešné prihlásenia cez `lastb`**

```bash
sudo lastb | awk 'NF >= 5 { print $1, $3, $4, $5 }' | head
```

Vhodné na kontrolu neúspešných login pokusov. Dostupnosť závisí od systému a logovania.

## ⏱️ Cron, balíky a inventár systému

**44. Kontrola cronu bez komentárov**

```bash
awk 'NF > 0 && $1 !~ /^#/ { print }' /etc/crontab
```

Zobrazí aktívne plánované úlohy v systémovom crone.

**45. Výpis cron súborov cez pipe**

```bash
ls -1 /etc/cron.d 2>/dev/null | awk '{ print "/etc/cron.d/" $1 }'
```

Zobrazí cesty k cron súborom.

**46. Hľadanie podozrivých reťazcov v cron súboroch**

```bash
sudo grep -R "curl\|wget\|nc\|bash" /etc/cron* 2>/dev/null | awk -F: '{ print $1, $2 }'
```

Pomáha hľadať potenciálne rizikové plánované úlohy. Výsledok treba vždy manuálne overiť.

**47. Kontrola systémových používateľov cez `getent` bez priameho čítania `/etc/passwd`**

```bash
getent passwd | awk -F: '$7 !~ /nologin|false/ { print $1, $7 }'
```

Nepoužíva priamo `/etc/passwd`, ale systémovú databázu cez NSS. Hodí sa aj pri LDAP/AD integrácii.

**48. Kontrola skupín cez `getent`**

```bash
getent group | awk -F: '$1 ~ /sudo|wheel|docker|adm/ { print $1, $4 }'
```

Bezpečnostná kontrola privilegovaných skupín cez systémové rozhranie.

**49. Kontrola balíkov cez dpkg**

```bash
dpkg -l | awk '$1 == "ii" { print $2, $3 }' | head
```

Zobrazí nainštalované balíky a verzie.

**50. Hľadanie bezpečnostných balíkov**

```bash
dpkg -l | awk '$2 ~ /openssh|sudo|ufw|apparmor|auditd/ { print $2, $3 }'
```

Užitočné pri základnom bezpečnostnom inventári.

## 🧪 Najlepšie ukážky na slajd alebo video

Na krátke demo odporúčame vybrať tieto ukážky:

- `/etc/group`
- `/etc/sudoers`
- `/etc/ssh/sshd_config`
- `/etc/fstab`
- `/etc/services`
- `/proc/meminfo`
- `df -h | awk ...`
- `ps aux | awk ...`
- `ss -tuln | awk ... | sort | uniq`
- `journalctl | awk ...`
- `/var/log/auth.log`
- `/var/log/apache2/access.log`
- `systemctl --failed | awk ...`
- `ip route | awk ...`
- `getent group | awk ...`

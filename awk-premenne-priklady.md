# 🧪 AWK premenné – praktické príklady

Tento súbor obsahuje rozšírené praktické ukážky vstavaných premenných AWK v Linuxe. Príklady sú určené pre systémových administrátorov, DevOps, bezpečnostných analytikov a etických hackerov.

---

## ⚠️ Poznámky k AWK premenným

| Premenná | Význam | Dôležitá poznámka |
|----------|--------|------------------|
| NR | Globálne číslo riadku | Neresetuje sa medzi súbormi |
| FNR | Číslo riadku v súbore | Resetuje sa pri každom novom súbore |
| NF | Počet polí v riadku | Dynamické podľa vstupu |
| FS | Vstupný oddeľovač polí | Nastavuje sa v BEGIN |
| OFS | Výstupný oddeľovač polí | Ovplyvňuje print výstup |
| RS | Vstupný oddeľovač záznamov | Štandardne \n |
| ORS | Výstupný oddeľovač záznamov | Štandardne \n |
| FILENAME | Aktuálny súbor | Pri viacerých súboroch |
| $NF | Posledné pole riadku | Dynamicky sa mení |

---

## 🧪 Praktické príklady (1–20)

**1. $NF – posledné pole v riadku (/etc/group)**
```bash
awk -F: '{ print $NF }' /etc/group
```
Použitie: získanie posledného stĺpca v štruktúrovaných súboroch. V `/etc/group` ide typicky o zoznam členov skupiny.

---

**2. $NF – posledné pole v výstupe ss**
```bash
ss -tuln | awk '{ print $NF }'
```
Použitie: extrakcia posledného atribútu výstupu (napr. PID/program). Vhodné pri analýze otvorených portov.

---

**3. NR – globálne číslo riadku (/etc/hosts)**
```bash
awk '{ print NR, $0 }' /etc/hosts
```
Použitie: pridanie globálneho indexu riadkov pre audit a debugovanie textu.

---

**4. NR – číslovanie logov**
```bash
journalctl -n 20 --no-pager | awk '{ print NR, $0 }'
```
Použitie: identifikácia poradia udalostí v logoch.

---

**5. FNR – číslo riadku v súbore**
```bash
awk '{ print FNR, FILENAME, $0 }' /etc/hosts /etc/hostname
```
Použitie: sledovanie začiatku každého súboru pri spracovaní viacerých vstupov.

---

**6. FNR – porovnanie súborov**
```bash
awk '{ print FNR, FILENAME }' /etc/hosts /etc/services
```
Použitie: kontrola štruktúry viacerých konfiguračných súborov.

---

**7. NF – počet polí (/etc/hosts)**
```bash
awk '{ print NF, $0 }' /etc/hosts
```
Použitie: detekcia štruktúry riadku a validácia formátu.

---

**8. NF – detekcia anomálií**
```bash
awk 'NF < 2 { print "short line:", $0 }' /etc/hosts
```
Použitie: odhalenie poškodených alebo neúplných riadkov.

---

**9. FS – nastavenie oddeľovača**
```bash
awk 'BEGIN { FS=":" } { print $1, $7 }' /etc/passwd
```
Použitie: spracovanie štruktúrovaných systémových súborov.

---

**10. FS – CSV spracovanie**
```bash
awk 'BEGIN { FS="," } { print $1, $2 }' data.csv
```
Použitie: jednoduchá analýza CSV bez externých nástrojov.

---

**11. OFS – formátovaný výstup**
```bash
awk 'BEGIN { FS=":"; OFS=" | " } { print $1, $3, $7 }' /etc/passwd
```
Použitie: zlepšenie čitateľnosti reportov.

---

**12. OFS – tabuľkový výstup**
```bash
awk 'BEGIN { OFS="\t" } { print $1, $2, $NF }' /etc/group
```
Použitie: export dát do tabuľkovej formy.

---

**13. RS – bloky textu**
```bash
awk 'BEGIN { RS="\n\n" } { print "BLOCK:\n" $0 }' /etc/services
```
Použitie: spracovanie viacriadkových záznamov ako jedného objektu.

---

**14. RS – analýza blokov**
```bash
awk 'BEGIN { RS="\n\n" } NR==1 { print }' /etc/services
```
Použitie: extrakcia prvého logického bloku.

---

**15. ORS – vlastný separátor**
```bash
awk 'BEGIN { ORS="---\n" } { print $1 }' /etc/group
```
Použitie: oddelenie výstupov pre reporty.

---

**16. ORS – čitateľné reporty**
```bash
awk 'BEGIN { ORS="\n\n" } { print $0 }' /etc/hosts
```
Použitie: vizuálne oddelenie záznamov.

---

**17. FILENAME – zdroj dát**
```bash
awk '{ print FILENAME, NR, $0 }' /etc/hosts /etc/hostname
```
Použitie: audit viacerých súborov naraz.

---

**18. FILENAME – konfigurácie**
```bash
awk '{ print FILENAME ":" $0 }' /etc/ssh/sshd_config /etc/fstab
```
Použitie: identifikácia zdroja konfigurácie.

---

**19. NR + NF – štruktúrna analýza**
```bash
awk '{ print NR, NF, $0 }' /etc/hosts
```
Použitie: kontrola konzistencie riadkov.

---

**20. Kompletná diagnostika**
```bash
awk -F: '{ print FILENAME, NR, FNR, NF, $1, $NF }' /etc/group /etc/hosts
```
Použitie: kombinovaný audit dát (súbor + riadky + polia + obsah).

---

## ⚠️ Zhrnutie

AWK premenné umožňujú:
- analyzovať štruktúru dát
- validovať vstupy
- spracovať logy
- vytvárať reporty
- korelovať dáta z viacerých súborov

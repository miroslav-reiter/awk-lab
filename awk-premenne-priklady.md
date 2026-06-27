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

### **1. $NF – posledné pole v riadku (/etc/group)**
```bash
awk -F: '{ print $NF }' /etc/group
```
**Vysvetlenie:** AWK rozdelí riadok podľa `:` a `$NF` vyberie posledné pole (členovia skupiny alebo prázdne pole). Premenná NF sa vyhodnocuje dynamicky pre každý riadok.

**Použitie:** Používame pri audite skupín, kontrole členstva a identifikácii prístupových práv v systéme.

---

### **2. $NF – posledné pole v výstupe ss**
```bash
ss -tuln | awk '{ print $NF }'
```
**Vysvetlenie:** Výstup príkazu `ss` sa spracuje riadok po riadku a `$NF` extrahuje posledný stĺpec (často PID alebo proces).

**Použitie:** Analýza otvorených portov a mapovanie sieťových spojení na procesy.

---

### **3. NR – globálne číslo riadku (/etc/hosts)**
```bash
awk '{ print NR, $0 }' /etc/hosts
```
**Vysvetlenie:** NR sa zvyšuje pre každý riadok vstupu bez ohľadu na súbor.

**Použitie:** Audit a debugovanie textových konfigurácií.

---

### **4. NR – číslovanie logov**
```bash
journalctl -n 20 --no-pager | awk '{ print NR, $0 }'
```
**Vysvetlenie:** Každý logový riadok dostane globálne poradie.

**Použitie:** Incident response a analýza poradia udalostí.

---

### **5. FNR – číslo riadku v súbore**
```bash
awk '{ print FNR, FILENAME, $0 }' /etc/hosts /etc/hostname
```
**Vysvetlenie:** FNR sa resetuje pri každom novom súbore, NR nie.

**Použitie:** Porovnávanie štruktúry viacerých konfiguračných súborov.

---

### **6. FNR – porovnanie súborov**
```bash
awk '{ print FNR, FILENAME }' /etc/hosts /etc/services
```
**Vysvetlenie:** Identifikuje aktuálny riadok v rámci konkrétneho súboru.

**Použitie:** Kontrola konzistencie konfigurácií.

---

### **7. NF – počet polí (/etc/hosts)**
```bash
awk '{ print NF, $0 }' /etc/hosts
```
**Vysvetlenie:** NF určuje počet polí v každom riadku.

**Použitie:** Detekcia neštandardných alebo poškodených riadkov.

---

### **8. NF – detekcia anomálií**
```bash
awk 'NF < 2 { print "short line:", $0 }' /etc/hosts
```
**Vysvetlenie:** Filtruje riadky s nedostatočným počtom polí.

**Použitie:** Validácia integrity konfiguračných súborov.

---

### **9. FS – nastavenie oddeľovača**
```bash
awk 'BEGIN { FS=":" } { print $1, $7 }' /etc/passwd
```
**Vysvetlenie:** FS definuje vstupný delimiter pre parsovanie riadkov.

**Použitie:** Spracovanie systémových databáz (passwd, group, shadow).

---

### **10. FS – CSV spracovanie**
```bash
awk 'BEGIN { FS="," } { print $1, $2 }' data.csv
```
**Vysvetlenie:** Nastavuje CSV ako vstupný formát.

**Použitie:** Rýchla analýza CSV bez externých nástrojov.

---

### **11. OFS – formátovaný výstup**
```bash
awk 'BEGIN { FS=":"; OFS=" | " } { print $1, $3, $7 }' /etc/passwd
```
**Vysvetlenie:** OFS definuje oddelovač výstupu medzi poliami.

**Použitie:** Generovanie čitateľných reportov.

---

### **12. OFS – tabuľkový výstup**
```bash
awk 'BEGIN { OFS="\t" } { print $1, $2, $NF }' /etc/group
```
**Vysvetlenie:** Formátuje výstup do tabuľkovej štruktúry.

**Použitie:** Export dát do CSV/TXT reportov.

---

### **13. RS – bloky textu**
```bash
awk 'BEGIN { RS="\n\n" } { print "BLOCK:\n" $0 }' /etc/services
```
**Vysvetlenie:** RS definuje logický záznam ako blok riadkov.

**Použitie:** Spracovanie viacriadkových logických štruktúr.

---

### **14. RS – analýza blokov**
```bash
awk 'BEGIN { RS="\n\n" } NR==1 { print }' /etc/services
```
**Vysvetlenie:** Spracováva jednotlivé bloky ako samostatné záznamy.

**Použitie:** Extrakcia prvých sekcií konfigurácií.

---

### **15. ORS – vlastný separátor**
```bash
awk 'BEGIN { ORS="---\n" } { print $1 }' /etc/group
```
**Vysvetlenie:** ORS určuje, ako sa oddelia výstupné záznamy.

**Použitie:** Generovanie reportov s vizuálnym oddelením.

---

### **16. ORS – čitateľné reporty**
```bash
awk 'BEGIN { ORS="\n\n" } { print $0 }' /etc/hosts
```
**Vysvetlenie:** Vkladá prázdne riadky medzi výstupy.

**Použitie:** Zlepšenie čitateľnosti exportov.

---

### **17. FILENAME – zdroj dát**
```bash
awk '{ print FILENAME, NR, $0 }' /etc/hosts /etc/hostname
```
**Vysvetlenie:** Identifikuje súbor, z ktorého pochádza riadok.

**Použitie:** Audit viacerých súborov naraz.

---

### **18. FILENAME – konfigurácie**
```bash
awk '{ print FILENAME ":" $0 }' /etc/ssh/sshd_config /etc/fstab
```
**Vysvetlenie:** Označuje zdroj každého riadku.

**Použitie:** Bezpečnostný audit konfigurácií.

---

### **19. NR + NF – štruktúrna analýza**
```bash
awk '{ print NR, NF, $0 }' /etc/hosts
```
**Vysvetlenie:** Kombinuje číslovanie riadkov a počet polí.

**Použitie:** Kontrola integrity dát.

---

### **20. Kompletná diagnostika**
```bash
awk -F: '{ print FILENAME, NR, FNR, NF, $1, $NF }' /etc/group /etc/hosts
```
**Vysvetlenie:** Kombinuje všetky kľúčové premenné AWK.

**Použitie:** Kompletný systémový audit a korelácia dát.

---

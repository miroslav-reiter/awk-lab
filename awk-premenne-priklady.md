# 🧪 AWK premenné – praktické príklady

Tento súbor obsahuje rozšírené praktické ukážky použitia vstavaných premenných AWK v Linuxe. Príklady sú určené pre systémových administrátorov, DevOps, bezpečnostných analytikov a etických hackerov.

---

## 🔢 Prehľad: AWK premenné v praxi

Nižšie sú uvedené praktické príklady, ktoré demonštrujú správanie premenných v reálnych Linux systémoch a logoch.

---

## 🧪 Praktické príklady (1–20)

**1. $NF – posledné pole v riadku (/etc/group)**
```bash
awk -F: '{ print $NF }' /etc/group
```
Vypíše posledný stĺpec každého riadku (napr. členovia skupín). Používame pri analýze skupín a ich členstva.

**2. $NF – posledné pole v logickom výstupe (ss)**
```bash
ss -tuln | awk '{ print $NF }'
```
Zobrazí posledný stĺpec výstupu (často PID/program). Vhodné pri analýze procesov.

**3. NR – globálne číslo riadku (/etc/hosts)**
```bash
awk '{ print NR, $0 }' /etc/hosts
```
Každý riadok je očíslovaný naprieč celým vstupom.

**4. NR – sledovanie poradia v logu**
```bash
journalctl -n 20 --no-pager | awk '{ print NR, $0 }'
```
Pridá globálne číslovanie riadkov výstupu logov.

**5. FNR – číslo riadku v súbore**
```bash
awk '{ print FNR, FILENAME, $0 }' /etc/hosts /etc/hostname
```
Každý súbor začína číslovaním od 1.

**6. FNR – porovnanie viacerých súborov**
```bash
awk '{ print FNR, FILENAME }' /etc/hosts /etc/services
```
Umožňuje vidieť, kde začína nový súbor.

**7. NF – počet polí v riadku (/etc/hosts)**
```bash
awk '{ print NF, $0 }' /etc/hosts
```
Ukazuje počet stĺpcov v každom riadku.

**8. NF – detekcia neštandardných riadkov**
```bash
awk 'NF < 2 { print "short line:", $0 }' /etc/hosts
```
Identifikuje nekompletné alebo poškodené riadky.

**9. FS – nastavenie oddeľovača (passwd štruktúra)**
```bash
awk 'BEGIN { FS=":" } { print $1, $7 }' /etc/passwd
```
Rozdeľuje riadky podľa dvojbodky.

**10. FS – dynamické spracovanie CSV štýlu**
```bash
awk 'BEGIN { FS="," } { print $1, $2 }' data.csv
```
Umožňuje spracovanie CSV dát.

**11. OFS – formátovaný výstup**
```bash
awk 'BEGIN { FS=":"; OFS=" | " } { print $1, $3, $7 }' /etc/passwd
```
Zlepšuje čitateľnosť výstupu.

**12. OFS – reportovací formát**
```bash
awk 'BEGIN { OFS="\t" } { print $1, $2, $NF }' /etc/group
```
Výstup formátovaný do tabulátorov.

**13. RS – záznamy ako bloky textu**
```bash
awk 'BEGIN { RS="\n\n" } { print "BLOCK:\n" $0 }' /etc/services
```
Spracováva viacriadkové bloky.

**14. RS – analýza logických blokov**
```bash
awk 'BEGIN { RS="\n\n" } NR==1 { print }' /etc/services
```
Pracuje s blokmi ako jednotkami.

**15. ORS – vlastný oddelovač výstupu**
```bash
awk 'BEGIN { ORS="---\n" } { print $1 }' /etc/group
```
Každý riadok je oddelený vlastným reťazcom.

**16. ORS – generovanie reportov**
```bash
awk 'BEGIN { ORS="\n\n" } { print $0 }' /etc/hosts
```
Zlepšuje čitateľnosť výstupu.

**17. FILENAME – identifikácia zdroja dát**
```bash
awk '{ print FILENAME, NR, $0 }' /etc/hosts /etc/hostname
```
Ukazuje, z ktorého súboru pochádza riadok.

**18. FILENAME – audit viacerých súborov**
```bash
awk '{ print FILENAME ":" $0 }' /etc/ssh/sshd_config /etc/fstab
```
Vhodné pri audite konfigurácií.

**19. Kombinácia NR + NF (analýza štruktúry)**
```bash
awk '{ print NR, NF, $0 }' /etc/hosts
```
Ukazuje štruktúru každého riadku.

**20. Kombinácia všetkých premenných (diagnostika)**
```bash
awk -F: '{ print FILENAME, NR, FNR, NF, $1, $NF }' /etc/group /etc/hosts
```
Komplexný prehľad dát: súbor, riadok, polia a obsah.

---

## ⚠️ Poznámky

- NR = globálne číslovanie riadkov
- FNR = resetuje sa pre každý súbor
- NF = počet polí
- FS/OFS = vstupný a výstupný separátor
- RS/ORS = spracovanie blokov a výstupu
- FILENAME = zdroj dát pri viacerých súboroch

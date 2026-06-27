# 🧪 AWK premenné – praktické príklady

Tento súbor obsahuje praktické ukážky použitia základných vstavaných premenných AWK v Linuxe. Príklady sú určené pre systémových administrátorov, DevOps, bezpečnostných analytikov a etických hackerov.

---

## 🔎 $NF – posledné pole v riadku

```bash
awk -F: '{ print $NF }' /etc/group
```

Vypíše posledný stĺpec riadku (napr. členovia skupiny).

---

## 🔢 NR – číslo riadku (globálne)

```bash
awk '{ print NR, $0 }' /etc/hosts
```

NR sa zvyšuje naprieč všetkými vstupnými riadkami zo všetkých súborov.

---

## 📄 FNR – číslo riadku v aktuálnom súbore

```bash
awk '{ print FNR, FILENAME, $0 }' /etc/hosts /etc/hostname
```

FNR sa resetuje pre každý nový súbor.

---

## 📊 NF – počet polí v riadku

```bash
awk '{ print NF, $0 }' /etc/hosts
```

NF udáva počet stĺpcov v riadku.

---

## 📥 FS – vstupný oddeľovač polí

```bash
awk 'BEGIN { FS=":" } { print $1, $7 }' /etc/passwd
```

Definuje vstupný delimiter (napr. : pre systémové súbory).

---

## 📤 OFS – výstupný oddeľovač polí

```bash
awk 'BEGIN { FS=":"; OFS=" | " } { print $1, $3, $7 }' /etc/passwd
```

Formátuje výstup medzi stĺpcami.

---

## 🔁 RS – vstupný oddeľovač záznamov

```bash
awk 'BEGIN { RS="\n\n" } { print "RECORD:\n" $0 }' /etc/services
```

Záznam sa spracuje ako blok (napr. odseky textu).

---

## 📤 ORS – výstupný oddeľovač záznamov

```bash
awk 'BEGIN { ORS="\n---\n" } { print $1 }' /etc/group
```

Každý výstupný záznam je oddelený vlastným separátorom.

---

## 📁 FILENAME – aktuálny súbor

```bash
awk '{ print FILENAME, NR, $0 }' /etc/hosts /etc/hostname
```

Umožňuje identifikovať zdroj vstupu pri viacerých súboroch.

---

## ⚙️ Kombinovaný príklad

```bash
awk -F: '{ print FILENAME, NR, NF, $1, $NF }' /etc/group /etc/hosts
```

Ukáže všetky kľúčové informácie v jednom výstupe.

---

## ⚠️ Poznámky

- NR = globálne číslovanie riadkov
- FNR = číslovanie per súbor
- FS = vstupný separator
- OFS = výstupný separator
- RS/ORS = riadky/záznamy
- $NF = dynamický prístup k poslednému poľu

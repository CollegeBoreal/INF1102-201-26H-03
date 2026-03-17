# **Expressions Régulières (Regex) 📝**

## **1. Qu’est-ce qu’une expression régulière ? 🤔**

Une **expression régulière (Regex)** est une **chaîne spéciale utilisée pour rechercher, valider ou manipuler du texte**.

* Exemples d’usage : filtrer les logs, valider des emails, extraire des numéros de téléphone, nettoyer des fichiers.
* Les principaux concepts sont les mêmes dans Bash, PowerShell et Python, mais la syntaxe pour les utiliser peut varier légèrement.

---

## **2. Composants de base des Regex 🧩**

| Symbole | Signification              | Exemple                                |       |                            |
| ------- | -------------------------- | -------------------------------------- | ----- | -------------------------- |
| `.`     | n’importe quel caractère   | `a.c` → `abc`, `a2c`, `a-c`            |       |                            |
| `*`     | 0 ou plusieurs répétitions | `ab*c` → `ac`, `abc`, `abbc`           |       |                            |
| `+`     | 1 ou plusieurs répétitions | `ab+c` → `abc`, `abbc`                 |       |                            |
| `?`     | 0 ou 1 répétition          | `colou?r` → `color`, `colour`          |       |                            |
| `^`     | Début de ligne             | `^Hello` → lignes commençant par Hello |       |                            |
| `$`     | Fin de ligne               | `end$` → lignes finissant par end      |       |                            |
| `[]`    | Classe de caractères       | `[aeiou]` → une voyelle                |       |                            |
| `[^]`   | Négation                   | `[^0-9]` → tout sauf un chiffre        |       |                            |
| `()`    | Groupement / capture       | `(ab)+` → `ab`, `abab`                 |       |                            |
| `       | `                          | OU logique                             | `chat | chien` → “chat” ou “chien” |

---

## **3. Utilisation en Bash 🐚**

En Bash, on utilise surtout **grep**, **sed**, **awk** pour manipuler les Regex.

**Exemples :**

1. Chercher toutes les lignes contenant “error” dans un fichier :

```bash
grep "error" fichier.log
```

2. Chercher toutes les lignes contenant un chiffre :

```bash
grep "[0-9]" fichier.txt
```

3. Supprimer les lignes vides :

```bash
grep -v "^\s*$" fichier.txt > fichier_sans_vide.txt
```

4. Extraire un mot particulier avec `sed` :

```bash
echo "Nom: John" | sed -E 's/Nom: (.*)/\1/'
# ➜ John
```

---

## **4. Utilisation en PowerShell ⚡**

PowerShell utilise **-match**, **Select-String**, ou `[regex]` pour manipuler les expressions régulières.

**Exemples :**

1. Chercher toutes les lignes contenant “error” dans un fichier :

```powershell
Select-String -Path "C:\logs\log.txt" -Pattern "error"
```

2. Vérifier si une chaîne contient un chiffre :

```powershell
"abc123" -match "\d"
# True
```

3. Extraire une partie de texte :

```powershell
$text = "Nom: John"
if ($text -match "Nom: (.+)") {
    $matches[1]  # ➜ John
}
```

4. Supprimer les lignes vides d’un fichier :

```powershell
Get-Content fichier.txt | Where-Object { $_ -notmatch "^\s*$" } | Set-Content fichier_sans_vide.txt
```

---

## **5. Utilisation en Python 🐍**

Python utilise le module `re` pour gérer les Regex.

**Exemples :**

1. Chercher tous les chiffres dans un texte :

```python
import re
texte = "abc123"
chiffres = re.findall(r"\d", texte)
print(chiffres)  # ➜ ['1','2','3']
```

2. Vérifier si une chaîne commence par “Hello” :

```python
if re.match(r"^Hello", "Hello World"):
    print("OK")
```

3. Extraire un nom après “Nom:” :

```python
texte = "Nom: John"
match = re.search(r"Nom: (.+)", texte)
if match:
    print(match.group(1))  # ➜ John
```

4. Supprimer les lignes vides d’un fichier :

```python
with open("fichier.txt", "r") as f:
    lignes = [l for l in f if l.strip() != ""]

with open("fichier_sans_vide.txt", "w") as f:
    f.writelines(lignes)
```

---

## **6. Comparatif Bash / PowerShell / Python 📊**

| Action                 | Bash                      | PowerShell                              | Python                        |
| ---------------------- | ------------------------- | --------------------------------------- | ----------------------------- |
| Chercher un mot        | `grep "mot" fichier`      | `Select-String -Pattern "mot"`          | `re.search(r"mot", texte)`    |
| Vérifier un chiffre    | `grep "[0-9]" fichier`    | `"abc" -match "\d"`                     | `re.findall(r"\d", texte)`    |
| Extraire texte         | `sed -E 's/.*: (.*)/\1/'` | `$matches[1]`                           | `match.group(1)`              |
| Supprimer lignes vides | `grep -v "^\s*$"`         | `Where-Object { $_ -notmatch "^\s*$" }` | `[l for l in f if l.strip()]` |

---

## **7. Conseils et bonnes pratiques ⚡**

1. Tester vos Regex avant usage.
2. Utiliser des **groupes** `()` pour capturer les parties importantes.
3. Préférer **regex étendues** (`-E` en Bash, `r"..."` en Python).
4. Documenter votre regex pour les scripts complexes.

# **🧠 Cheat Sheet – Expressions Régulières (Regex)**

## **1. Symboles essentiels**

| Regex   | Signification            | Exemple   | Résultat    |        |      |
| ------- | ------------------------ | --------- | ----------- | ------ | ---- |
| `.`     | N’importe quel caractère | `a.c`     | abc, a1c    |        |      |
| `\d`    | Chiffre (0–9)            | `\d\d`    | 12, 45      |        |      |
| `\w`    | Lettre ou chiffre        | `\w+`     | abc123      |        |      |
| `\s`    | Espace                   | `\s+`     | "   "       |        |      |
| `^`     | Début de ligne           | `^Hello`  | Hello world |        |      |
| `$`     | Fin de ligne             | `end$`    | the end     |        |      |
| `*`     | 0 ou plusieurs           | `ab*c`    | ac, abc     |        |      |
| `+`     | 1 ou plusieurs           | `ab+c`    | abc         |        |      |
| `?`     | 0 ou 1                   | `colou?r` | color       |        |      |
| `{n}`   | Exactement n             | `\d{3}`   | 123         |        |      |
| `{n,}`  | n ou plus                | `\d{2,}`  | 12, 123     |        |      |
| `{n,m}` | entre n et m             | `\d{2,4}` | 12, 1234    |        |      |
| `[]`    | Choix de caractères      | `[abc]`   | a, b, c     |        |      |
| `[^]`   | Négation                 | `[^0-9]`  | lettre      |        |      |
| `()`    | Groupe                   | `(ab)+`   | abab        |        |      |
| `       | `                        | OU        | `chat       | chien` | chat |

---

## **2. Patterns utiles (prêts à utiliser)**

| Cas               | Regex                                         |
| ----------------- | --------------------------------------------- |
| Email             | `[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}` |
| Téléphone         | `\d{3}-\d{3}-\d{4}`                           |
| Date (YYYY-MM-DD) | `\d{4}-\d{2}-\d{2}`                           |
| Ligne vide        | `^\s*$`                                       |
| Ligne commentée   | `^#`                                          |
| Mot majuscule     | `\b[A-Z][a-z]+\b`                             |

---

## **3. Bash 🐚 (grep / sed)**

### 🔍 Recherche

```bash
grep -E "\d{3}" fichier.txt
```

### ❌ Supprimer lignes vides

```bash
grep -v "^\s*$" fichier.txt
```

### ✂️ Extraire du texte

```bash
echo "Nom: John" | sed -E 's/Nom: (.*)/\1/'
```

---

## **4. PowerShell ⚡**

### 🔍 Recherche

```powershell
Select-String -Path fichier.txt -Pattern "\d{3}"
```

### ✔️ Test Regex

```powershell
"abc123" -match "\d+"
```

### ✂️ Extraction

```powershell
$text = "Nom: John"
if ($text -match "Nom: (.+)") {
    $matches[1]
}
```

### ❌ Supprimer lignes vides

```powershell
Get-Content fichier.txt | Where-Object { $_ -notmatch "^\s*$" }
```

---

## **5. Python 🐍**

### 🔍 Recherche

```python
import re
re.findall(r"\d{3}", "abc123def456")
```

### ✔️ Test

```python
re.match(r"^Hello", "Hello world")
```

### ✂️ Extraction

```python
match = re.search(r"Nom: (.+)", "Nom: John")
match.group(1)
```

### ❌ Supprimer lignes vides

```python
[l for l in lignes if l.strip()]
```

---

## **6. Différences importantes ⚠️**

| Élément           | Bash      | PowerShell    | Python             |
| ----------------- | --------- | ------------- | ------------------ |
| Regex étendues    | `grep -E` | par défaut    | par défaut         |
| Variables capture | `sed \1`  | `$matches[1]` | `group(1)`         |
| Syntaxe string    | `" "`     | `" "`         | `r" "` (important) |

---

## **7. Astuces rapides 💡**

* Toujours tester avec un outil comme :

  * regex101.com (très recommandé)
* En Python ➜ toujours utiliser `r"..."`
* En Bash ➜ penser à `-E`
* En PowerShell ➜ `$matches` contient les résultats

---

## **8. Mini exercice 🏋️**

Trouver tous les emails dans un fichier :

* Bash :

```bash
grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}" fichier.txt
```

* PowerShell :

```powershell
Select-String -Pattern "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}" fichier.txt
```

* Python :

```python
re.findall(r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}", texte)
```

---



# 🔧 Lab PWSH – DevOps Batch PowerShell sous Linux

## 🎯 Objectif
.
Ce laboratoire a pour objectif de créer un script PowerShell (pwsh) sous Linux permettant de :

* Vérifier l’état du système (CPU, mémoire, disque)
* Tester la connectivité réseau (SSH)
* Générer un rapport texte et JSON
* Automatiser des tâches DevOps

---

## 🗂️ Structure du projet

```bash
6.PWSH/
└── 300138576/
    ├── devops_batch.ps1
    ├── rapport.txt
    ├── rapport.json
    └── images/
        └── 1.png
```

---

## ⚙️ Description du script

### 📌 1. Informations système

Le script récupère :

* Utilisateur (`whoami`)
* Nom de la machine (`hostname`)
* Date (`Get-Date`)

---

### 📌 2. Analyse CPU

```powershell
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
```

➡ Affiche les 5 processus les plus gourmands en CPU

---

### 📌 3. Analyse mémoire

```powershell
Get-Process | Sort-Object WS -Descending | Select-Object -First 5
```

➡ Affiche les 5 processus utilisant le plus de mémoire

---

### 📌 4. Vérification disque

```bash
df -h
```

➡ Affiche l’espace disque disponible

---

### 📌 5. Test réseau (SSH)

```powershell
ssh 127.0.0.1 "echo OK"
```

➡ Vérifie la connectivité SSH locale

---

### 📌 6. Génération des rapports

* 📄 `rapport.txt` → rapport lisible
* 📄 `rapport.json` → format structuré (DevOps/API)

```powershell
ConvertTo-Json
```

---

## 📊 Résultat obtenu

✔ Rapport système généré
✔ Top CPU et mémoire affichés
✔ Espace disque vérifié
✔ Connectivité testée
✔ Fichiers `rapport.txt` et `rapport.json` créés

---

## 🖼️ Preuve d’exécution

![Preuve d'exécution](images/1.png)

---

## ⚠️ Remarque technique

Un avertissement peut apparaître :

```text
WARNING: JSON is truncated due to depth limit
```

Solution :

```powershell
ConvertTo-Json -Depth 10
```

---

## 🧠 Avantages de PowerShell sous Linux

* Pipeline orienté objets (plus puissant que Bash)
* Compatible multi-plateforme (Windows/Linux/macOS)
* Génération directe de JSON (idéal DevOps)
* Scripts plus lisibles et maintenables

---

## ✅ Conclusion

Ce TP permet de :

* Utiliser PowerShell sous Linux
* Automatiser des tâches système
* Générer des rapports DevOps
* Comprendre le pipeline orienté objets

Il représente un scénario réel d’administration système moderne.

---

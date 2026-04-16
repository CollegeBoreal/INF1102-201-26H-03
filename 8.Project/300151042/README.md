# 🚀 INF1102 – programation systeme 

## 📊 Analyse de Logs Web

---

## 👤 Informations

* 👨‍💻 **Nom :** hamdi hicham
* 🆔 **Identifiant :** 300151042
* 🎓 **Cours :** INF1102 – Automatisation / DevOps
* 🖥️ **Environnement :** Ubuntu VM

---

## 🎯 Objectif

Ce projet vise à automatiser l’analyse d’un fichier de logs web à l’aide de scripts Bash, Python et PowerShell.

👉 Il permet de :

* 📂 Lire un fichier log
* 🌐 Identifier les IP les plus actives
* 📄 Analyser les pages visitées
* ⚠️ Détecter les codes HTTP
* 📝 Générer un rapport automatique

---

## 🧱 Structure du projet

```id="g3f8q2"
300151042/
├── scripts/
│   ├── analyse.sh        🐧 Bash
│   ├── analyse.ps1       🪟 PowerShell
│   ├── analyse.py        🐍 Python
│   └── create_rapport.py 📝 Génération rapport
├── data/
│   └── sample.log        📂 Fichier logs
├── output/
│   └── rapport.txt       📊 Résultat
├── RAPPORT.ipynb         📓 Notebook
└── README.md             📘 Documentation
```

---

## ⚙️ Technologies utilisées

* 🐧 **Bash** → orchestration
* 🐍 **Python 3** → analyse des données
* 🪟 **PowerShell** → exécution alternative
* 📓 **Jupyter Notebook** → visualisation

---

## 🔁 Fonctionnement

1. 🐧 Le script Bash lance le projet
2. 🐍 Python analyse le fichier log
3. 📊 Les données sont traitées
4. 📝 Un rapport est généré automatiquement

---

## 🚀 Exécution

### ▶️ Méthode 1 – Bash

```bash
cd scripts
bash analyse.sh
```

### ▶️ Méthode 2 – Python

```bash
python3 scripts/create_rapport.py
```

### ▶️ Méthode 3 – PowerShell

```bash
pwsh scripts/analyse.ps1
```

---

## 📄 Résultat

📁 Fichier généré :

```id="5n9k1l"
output/rapport.txt
```
<img width="696" height="69" alt="projet 1" src="https://github.com/user-attachments/assets/dc8dac3b-182d-4247-8228-8128aab592ab" />


### 📊 Exemple de sortie

```id="92s0h1"
TOP 5 IPs
192.168.1.1 : 3
192.168.1.2 : 2

TOP 5 URLs
/index.html : 2
/login : 1

Codes HTTP
200 : 4
404 : 1
500 : 1
```
<img width="730" height="314" alt="projet 2" src="https://github.com/user-attachments/assets/3919c973-5a51-4133-a295-e13dd4c5847c" />

---

## 📓 Rapport Jupyter

Le fichier `RAPPORT.ipynb` contient :

* 📘 explication du projet
* 🔍 analyse des résultats
* 📊 visualisations

---

## ✅ Résultats

✔ Analyse automatique des logs
✔ Génération de rapport
✔ Structure propre
✔ Compatible DevOps

---

## 💡 Améliorations possibles

* 📊 Ajouter graphiques (matplotlib)
* 🌐 Utiliser vrais logs Nginx
* ⚡ Monitoring temps réel
* 🔔 Alertes automatiques

---

## 📌 Conclusion

Ce projet démontre l’utilisation efficace de Bash, Python et PowerShell pour automatiser l’analyse de données dans un environnement DevOps.

👉 Il met en pratique :

* scripting
* analyse de logs
* automatisation
* organisation de projet

---

## 🛠️ Bonnes pratiques

* 📁 Structure claire
* 💻 Code lisible
* 🔄 Automatisation complète
* 📊 Résultats exploitables

---

🔥 **Projet prêt à être livré et évalué ✔**

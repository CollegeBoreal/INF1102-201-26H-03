# 📊 Rapport de surveillance Nginx

**Nom :** Tasnim Marzougui
**Numéro étudiant :** 300145940

---

## 🎯 Objectif du projet

Ce projet consiste à analyser un fichier de logs d’un serveur web Nginx afin de surveiller son activité et ses performances.

L’analyse permet d’identifier :

* les adresses IP les plus actives
* les pages (URLs) les plus visitées
* la répartition des codes HTTP (200, 404, 500, etc.)

---

## 📁 Structure du projet

```
8.Project/300145940/
├── scripts/
│   ├── analyse.py
│   ├── analyse.sh
│   └── analyse.ps1
├── data/
│   └── sample.log
├── output/
│   └── rapport.txt
├── images/
│   ├── graph1.png
│   ├── graph2.png
│   └── graph3.png
├── RAPPORT.ipynb
└── README.md
```

---

## ⚙️ Technologies utilisées

* Python 3
* Jupyter Notebook
* Matplotlib (visualisation)
* Bash / PowerShell

---

## 🚀 Exécution du projet

### 1. Exécuter le script Python

```bash
python3 scripts/analyse.py
```

### 2. Exécuter via Bash

```bash
bash scripts/analyse.sh
```

### 3. Exécuter via PowerShell

```powershell
./scripts/analyse.ps1
```

---

## 📊 Résultats de l’analyse

### 🔹 Top 5 adresses IP

![Top IP](images/graph1.png)

---

### 🔹 Top 5 URLs visitées

![Top URLs](images/graph2.png)

---

### 🔹 Répartition des codes HTTP

![Codes HTTP](images/graph3.png)

---

## 📈 Interprétation des résultats

* L’adresse IP **192.168.1.10** est la plus active.
* La page **/index.html** est la plus visitée.
* La majorité des requêtes sont des succès (**code 200**).
* Certaines erreurs (**404, 500, 403**) sont présentes et doivent être surveillées.

---

## ✅ Conclusion

Ce projet permet de mettre en place une surveillance simple et efficace d’un serveur web Nginx.

L’utilisation de Python et de visualisations graphiques facilite l’analyse des logs et permet d’identifier rapidement :

* les comportements utilisateurs
* les erreurs serveur
* les points à améliorer

Ce type d’analyse est essentiel pour assurer la performance et la sécurité d’un serveur.

---


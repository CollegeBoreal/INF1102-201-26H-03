cat << 'EOF' > README.md
# 📊 Analyseur de Logs — Bash & Python

---

## 👤 Informations

| Champ | Valeur |
|------|--------|
| Identifiant | 300150416 |
| Nom | Hachem Souyadi |
| Cours | INF1102 – Programmation système |
| Type | Projet DevOps / Automatisation |
| Sujet | Analyse de logs serveur |

---

## 🎯 Objectif du projet

Ce projet permet d'automatiser l'analyse d’un fichier de logs serveur en utilisant :

- Python → traitement et analyse des données  
- Bash → automatisation et orchestration  

Le système génère automatiquement :
- un rapport texte
- des graphiques
- un histogramme
- un nuage de mots (WordCloud)

---

## 🧠 Architecture

\`\`\`text
Utilisateur
   ↓
Script Bash (analyse.sh)
   ↓
Script Python (analyse.py)
   ↓
Analyse des logs
   ↓
Génération des résultats (output/)
\`\`\`

---

## 📁 Structure du projet

\`\`\`text
300150416/
├── scripts/
│   ├── analyse.py
│   ├── analyse.sh
│   └── requirements.txt
│
├── data/
│   └── sample.log
│
├── output/
│   ├── rapport.txt
│   ├── top_ip.png
│   ├── top_urls.png
│   ├── http_codes.png
│   ├── histogram.png
│   └── wordcloud.png
│
├── images/
├── RAPPORT.ipynb
└── README.md
\`\`\`

---

## ⚙️ Technologies utilisées

| Technologie | Rôle |
|------------|------|
| Python 3 | Analyse des données |
| Bash | Automatisation |
| Matplotlib | Graphiques |
| WordCloud | Nuage de mots |
| Jupyter | Notebook |
| Git / GitHub | Versioning |

---

## 🚀 Lancement du projet

\`\`\`bash
cd 300150416
bash scripts/analyse.sh
\`\`\`

---

## 🔍 Fonctionnement

\`\`\`bash
python3 scripts/analyse.py
\`\`\`

---

## 📊 Résultats générés

| Fichier | Description |
|--------|------------|
| rapport.txt | Résumé de l’analyse |
| top_ip.png | Top IP |
| top_urls.png | URLs |
| http_codes.png | Codes HTTP |
| histogram.png | Histogramme |
| wordcloud.png | WordCloud |

---

## 📌 Exemple de sortie

\`\`\`text
=== RAPPORT D'ANALYSE DES LOGS ===
Top 3 des IP...
\`\`\`

---

## 📦 Dépendances

\`\`\`bash
pip3 install matplotlib wordcloud jupyter
\`\`\`

---

## 📸 Captures

Voir dossier :

\`\`\`text
images/
\`\`\`

---

## ✅ Fonctionnalités

| Fonctionnalité | Statut |
|--------------|--------|
| Analyse logs | ✅ |
| Graphiques | ✅ |
| Histogramme | ✅ |
| WordCloud | ✅ |
| Script Bash | ✅ |

---

## 👨‍💻 Auteur

Hachem Souyadi — Collège Boréal
EOF

# 🌐 Global News Analyzer

👨‍💻 **Nom :** Djellouli Zakaria  
🆔 **ID :** 300150433  
📚 **Cours :** INF1102 - Programmation de systèmes  

---

# 🎯 Objectif

Ce projet permet de récupérer et analyser des titres d’actualité via un flux RSS (BBC News).

Il permet de :
- 📰 Récupérer automatiquement des articles  
- 🔤 Analyser les mots les plus fréquents  
- 📊 Générer des statistiques  
- 📄 Créer un rapport automatique  
- 📓 Visualiser les résultats dans Jupyter Notebook  

---

# 🖥️ Environnement

| Élément | Valeur |
|--------|--------|
| 💻 Machine | vm300150433 |
| 🐧 OS | Ubuntu |
| 🐍 Python | 3.x |
| ⚡ PowerShell | pwsh |
| 🌐 Source | BBC RSS |

---

# 📂 Structure du projet

---
📁 300150433/
│
├── scripts/
│ ├── analyse.ps1
│ └── analyse.py
│
├── data/
│ └── sample.log
│
├── output/
│ └── rapport.txt
│
├── RAPPORT.ipynb
├── create_notebook.py
└── README.md


# ▶️ Exécution

## 🔹 1. Lancer le script principal

```bash
pwsh scripts/analyse.ps1
```
## 🔹 2. Vérifier le rapport
```
cat output/rapport.txt
```
## 🔹 3. Lancer Jupyter
```
jupyter lab
```
# 📸 Captures d’écran
### 🧠 Script PowerShell 
Script PowerShell utilisé pour récupérer les titres RSS et lancer l’analyse.
<img width="953" height="609" alt="nano analyse ps1" src="https://github.com/user-attachments/assets/7a9d3b6b-692a-41c7-902d-5ee227fa7ec7" />

### 🐍 Script Python
Script Python qui analyse les données et génère le rapport automatiquement.
<img width="820" height="638" alt="nano analyse py" src="https://github.com/user-attachments/assets/467fb5de-f35b-4fc5-9edb-943ba1067921" />

### 📓 Création du Notebook
Script permettant de générer automatiquement le notebook Jupyter.
<img width="912" height="623" alt="nano  create notebook" src="https://github.com/user-attachments/assets/bf93389b-67bd-4a94-b0f3-c482832048cd" />

### ⚡ Exécution PowerShell
Exécution du script PowerShell pour récupérer et traiter les données.
<img width="815" height="120" alt="pwsh analyse ps1" src="https://github.com/user-attachments/assets/05cb6959-313d-4eee-97ae-efef99dbb94b" />

### 📄 Rapport généré
Affichage du rapport texte contenant les résultats de l’analyse.
<img width="1095" height="692" alt="cat rapport" src="https://github.com/user-attachments/assets/957631cf-0291-4849-a0b7-0ea5a340e779" />


### 📊 Interface Jupyter
Interface Jupyter utilisée pour visualiser et analyser les données.
<img width="1365" height="649" alt="jupyter" src="https://github.com/user-attachments/assets/13c6adc2-b118-498f-b293-2d0d7dbda111" />


### 📈 Résultat final
Résultats finaux affichés dans le notebook après exécution.
<img width="1363" height="651" alt="lancer rapport depuis jupyter" src="https://github.com/user-attachments/assets/eb37b672-5d0d-4414-8e3d-b3199d5e5594" />


📊 Résultats obtenus
- ✔ 20 articles récupérés
- ✔ Analyse des mots fréquents
- ✔ Statistiques générées automatiquement
- ✔ Rapport structuré
🧠 Compétences développées
Python (Regex, Counter)
PowerShell scripting
Analyse de données
Automatisation
Jupyter Notebook

# ✅ Conclusion
Ce projet démontre l’utilisation combinée de PowerShell et Python pour automatiser la récupération et l’analyse de données.
Il met en évidence des compétences pratiques en programmation de systèmes et en traitement de données.

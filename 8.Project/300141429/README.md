# 📽️ Projet – Scraping et analyse de BBC News

## 👤 Informations de l’étudiant
Nom : Elhadji Arona Barry  
Matricule : 300141429  
Cours : INF1102  
Session : Hiver 2026  

---

## 🎯 Objectif du projet
Ce projet a pour objectif de démontrer l’utilisation de plusieurs langages de script
(**Bash, PowerShell et Python**) pour automatiser :
- la récupération de titres de nouvelles depuis le site BBC News
- l’analyse des mots les plus fréquents
- la génération d’un rapport texte
- la création de visualisations graphiques avec Jupyter Notebook

---

## 🛠️ Technologies utilisées
- **Bash** : exécution du script principal
- **PowerShell (pwsh)** : exécution alternative de l’analyse
- **Python 3** : scraping et traitement des données
- **BeautifulSoup** : extraction des données HTML
- **Matplotlib** : génération de graphiques
- **Jupyter Notebook** : rapport et visualisation des résultats

---

## 📂 Structure du projet

 Exécution avec PowerShell

```powershell
pwsh scripts/analyse.ps1
```
Ces commandes :

récupèrent automatiquement les titres depuis BBC News
génèrent le fichier data/articles.json
produisent le rapport texte output/rapport.txt

📊 Analyse et visualisation
Le fichier RAPPORT.ipynb contient :

le chargement des données
le calcul des statistiques
plusieurs graphiques (fréquence des mots, répartition, distributions)
une analyse écrite des résultats obtenus








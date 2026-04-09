# Projet Web Musique – Analyse Last.fm 🎵

Ce projet récupère les **top artistes** de Last.fm via l’API officielle, analyse les données et génère un **graphique** et un **rapport texte** des 5 artistes les plus écoutés.

---

## 📝 Objectifs du projet

- Collecter des données musicales automatiquement depuis Last.fm  
- Analyser et traiter les données en Python  
- Générer un **graphique** des artistes les plus populaires  
- Produire un **rapport texte** clair et lisible  

Ce projet combine **Python**, **JSON**, et **visualisation avec matplotlib**, ce qui permet de montrer vos compétences en **programmation, automatisation et analyse de données**.

---

## 🛠️ Installation et configuration

1. **Cloner le dépôt :**
```bash
git clone https://github.com/ton-username/mon-projet-musique.git


##Accéder au dossier du projet :

cd mon-projet-musique/projet_musique/scripts

Installer les dépendances Python :

pip install -r requirements.txt


##🚀 Utilisation
1️⃣ Générer les données JSON

Récupère les top artistes depuis Last.fm et enregistre-les dans data.json :
curl "https://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=TA_CLE_API&format=json" -o ../output/data.json

2️⃣ Lancer l’analyse Python

##Génère le graphique et le rapport texte :

python analyse.py ../output/data.json ../output/graph.png
graph.png → Graphique des 5 artistes les plus écoutés
rapport.txt → Rapport texte avec le nombre d’écoutes


##📊 Résultats attendus

Exemple :

#Top 5 artistes

-The Weeknd : 12345 écoutes
-Dua Lipa : 11023 écoutes
-Imagine Dragons : 9876 écoutes
-Billie Eilish : 8765 écoutes
-Drake : 7654 écoutes

Graphique : barre verticale des écoutes par artiste (fichier graph.png).

##🔧 Technologies utilisées
Python 3.x
JSON pour le stockage des données
matplotlib pour la visualisation
PowerShell ou terminal pour l’exécution des scripts

##💡 Notes importantes
Le script a été testé sous Windows PowerShell
Encodage UTF-8 utilisé pour supporter les caractères spéciaux et emojis
Pour Linux/Mac, les commandes peuvent nécessiter python3 au lieu de python

##📂 Organisation du projet

projet_musique/
│
├─ scripts/
│   ├─ analyse.py        # Script Python principal
│   ├─ analyse.sh        # Ancien script bash (Windows pas compatible)
│
├─ output/
│   ├─ data.json         # Données JSON récupérées de Last.fm
│   ├─ graph.png         # Graphique généré
│   ├─ rapport.txt       # Rapport texte


##🔗 Liens utiles
API Last.fm
Documentation matplotlib


---

💡 **Astuce** : tu peux mettre un **aperçu du graphique** directement dans le README avec Markdown :

```markdown


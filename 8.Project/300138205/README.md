# Projet 4 : Analyse de données COVID via API publique

## 👤 Étudiant

- Identifiant : **300138205**
- Nom: Taylor Ngue Ngan
- Cours : Programmation système 
- Thème : **Analyse de données COVID via API publique**
---
  **Objectif :** Récupérer les statistiques COVID par pays et générer analyses et graphiques.

**Livrables attendus :**

* `scripts/analyse.ps1` : récupère les données via API
* `scripts/analyse.py` : analyse cas, décès, guérisons et génère graphiques
* `RAPPORT.ipynb` : évolution des cas dans un ou plusieurs pays
* `output/rapport.txt` : résumé texte des statistiques principales

**Astuce pédagogique :** API recommandée : `https://covid19api.com/` ( elle ne fonctionne pas) 
je vais utiliser cette API: https://disease.sh/v3/covid-19

---
# ℹ️installation des libreries necessaire pour notre project

```powershell
sudo apt update
sudo apt install python3-pip
```
<img width="1422" height="603" alt="image" src="https://github.com/user-attachments/assets/4bdb3ab8-6cc8-4185-b84c-de75b21d8bfe" />

-----
# Installer les bibliothèques Python (pandas et matplotlib) dans la VM

```powershell
pip3 install pandas matplotlib
```
<img width="1390" height="557" alt="image" src="https://github.com/user-attachments/assets/9535b7b8-ffba-4e96-b2b0-70ffc994055c" />

---
# 1️⃣ Script PowerShell → scripts/analyse.ps1

👉 Objectif : récupérer les données depuis l’API et les sauvegarder

la commande pour executer le script powershell est la suivante:
```powershell
pwsh ./scripts/analyse.ps1
```
<img width="1077" height="622" alt="image" src="https://github.com/user-attachments/assets/604f7a16-2d6d-4f4b-beea-2356c1406f20" />
<img width="1052" height="705" alt="image" src="https://github.com/user-attachments/assets/b127d1be-2a1c-4387-8f82-dd45f826e95f" />


D'apres cette image, nous voyons que les données ont éte telechargé des le repertoir output.

---

# 2️⃣ Script Python → scripts/analyse.py

👉 Objectif : analyser + générer graphique + rapport

la commande pour executer le script powershell est la suivante:
```powershell
python3 scripts/analyse.py
```
<img width="1473" height="569" alt="image" src="https://github.com/user-attachments/assets/73177de1-d6d5-4077-9f5d-59c028f81eca" />
<img width="1478" height="548" alt="image" src="https://github.com/user-attachments/assets/a65494aa-34bc-498b-8346-60279f1448d0" />

-----
# 🏘️ creation du fichier qui va recenser tous les cas et faire sont analyse grace au script analyse.py

Le fichier covid_data.json est la source unique de toutes les analyses de mon projet. Il contient :

---
- 1️⃣ metadata : informations sur la source et l’extraction des données (utile pour le rapport et la traçabilité).
- 2️⃣global : statistiques mondiales (cas totaux, décès, guérisons, actifs).
- 📉countries : données détaillées par pays (cas, décès, taux de mortalité, etc.) pour les graphiques.
- 4️⃣historical : données quotidiennes (exemple : France 30 derniers jours) pour les graphiques d’évolution.

---
Sans ce fichier, analyse.py ne peut pas fonctionner, car tout est basé sur ces données JSON.
# Découplage entre récupération et analyse
analyse.ps1 : télécharge les données depuis une API ou un endpoint externe et les sauvegarde dans covid_data.json.
analyse.py : lit ce fichier, analyse les données, génère les graphiques et le rapport texte.

Le fichier JSON sert donc de pont entre la collecte des données et leur analyse.
<img width="605" height="95" alt="image" src="https://github.com/user-attachments/assets/5068b612-16fe-4a2d-998c-0a2741017fe3" />

----
# verification des livrables des le repertoire output

<img width="1288" height="261" alt="image" src="https://github.com/user-attachments/assets/478405e5-159c-472c-910a-3b6375d93192" />
<img width="1112" height="670" alt="image" src="https://github.com/user-attachments/assets/922c0359-5c0e-4eaf-b0b6-bb0a2f40ba1b" />
<img width="985" height="612" alt="image" src="https://github.com/user-attachments/assets/96b1117a-a781-4c90-884e-51d377680cda" />



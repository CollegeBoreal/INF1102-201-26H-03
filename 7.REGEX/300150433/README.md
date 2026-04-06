# 📊 TP Regex — Analyse des logs Nginx

* **Nom :** Zakaria Djellouli
* **ID :** 300150433

---

# 🎯 Objectif du TP

Ce TP consiste à analyser les logs du serveur Nginx en utilisant des **expressions régulières (Regex)** afin de générer un rapport automatique contenant :

* Le nombre total de requêtes
* Les erreurs HTTP (404, 500…)
* Les adresses IP les plus fréquentes
* Les pages les plus demandées

Le projet est réalisé avec :

* PowerShell
* Python
* Automatisation avec cron

---

# 📂 Structure du projet

```bash
7.REGEX/300150433/
│── analyse_nginx.ps1
│── analyse_nginx.py
│── images/
│── README.md
```

---

# ⚙️ Étapes réalisées (Résumé)

## 🔹 1. Connexion à la VM

```bash
ssh ubuntu@300150433
```

---

## 🔹 2. Création du dossier

```bash
mkdir REGEX
cd REGEX
```

---

## 🔹 3. Vérification des logs Nginx

```bash
ls /var/log/nginx/
cat /var/log/nginx/access.log
```

👉 Si le fichier est vide :

```bash
curl http://localhost
```

---

## 🔹 4. Création des scripts

```bash
nano analyse_nginx.ps1
nano analyse_nginx.py
```

---

## 🔹 5. Exécution

```bash
pwsh ./analyse_nginx.ps1
python3 analyse_nginx.py
```

---

## 🔹 6. Automatisation avec cron

```bash
crontab -e
```

Ajout :

```bash
0 2 * * * /usr/bin/pwsh /home/ubuntu/REGEX/analyse_nginx.ps1
```
---

# 🧠 Fonctionnement des scripts

## ⚡ PowerShell

Le script :

* Lit le fichier de log Nginx
* Extrait les codes HTTP avec Regex
* Compte les erreurs (404, 500)
* Identifie les IP les plus actives
* Génère un rapport

---

## 🐍 Python

Le script Python :

* Utilise le module `re`
* Analyse les logs
* Compte les occurrences
* Génère un rapport similaire au script PowerShell

---

# 🖼️ Captures d’écran

## 📌 Création des fichiers

<img width="474" height="34" alt="nano analyse nginx" src="https://github.com/user-attachments/assets/62088fb2-41c3-4b3c-bdd5-810f8ecdfe9a" />

## 📌 Exécution des scripts

<img width="664" height="250" alt="pwsh analyse nginx" src="https://github.com/user-attachments/assets/37a4e836-c79c-4bb7-a779-a9d347898a06" />


---
## 📌 Création des fichiers

<img width="459" height="37" alt="nano analyse nginx py " src="https://github.com/user-attachments/assets/a34f2bd3-66d6-4680-a5f8-ec00045c6d7b" />

## 📌 Exécution des scripts

<img width="478" height="125" alt="python3 analyse nginx py " src="https://github.com/user-attachments/assets/efbb593c-e5bd-4492-84fa-612234c9e439" />


---

## 📌 Résultat des rapports

<img width="725" height="180" alt="all" src="https://github.com/user-attachments/assets/b0925312-73c4-4715-94be-a6a25041075f" />

---

## 📌 Automatisation avec cron

<img width="662" height="571" alt="automatisation " src="https://github.com/user-attachments/assets/d459878d-03e3-4300-a0cf-e68a7d36a8ff" />


---

## 📌 Vérification cron

<img width="1365" height="706" alt="verif automatisation " src="https://github.com/user-attachments/assets/51e93221-40e8-4ffc-8941-169e946701f6" />


---

# ✅ Résultats obtenus

* ✔ Scripts fonctionnels (PowerShell et Python)
* ✔ Génération automatique de rapports
* ✔ Utilisation efficace des Regex
* ✔ Automatisation avec cron validée
* ✔ Intégration Git réussie

---

# 🚀 Conclusion

Ce TP m’a permis de :

* Comprendre les expressions régulières
* Manipuler des logs systèmes
* Automatiser des tâches sous Linux
* Utiliser PowerShell et Python dans un même projet
* Gérer un projet avec Git et GitHub

---


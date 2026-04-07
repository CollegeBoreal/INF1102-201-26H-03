# Laboratoire — 🧪 TP : Analyse des logs Nginx avec Regex (PowerShell & Python)
---
## 👤 Étudiant

- Identifiant : **300138205**
- Nom: Taylor Ngue Ngan
- Cours : Programmation système
-Durée : 90 à 120 minutes
- Environnement : Ubuntu 22.04 (Jammy)
  
----
# -Shell : PowerShell (pwsh)
---
# 🎯 Objectifs
Créer un script capable de :

Analyser le fichier /var/log/nginx/access.log
Utiliser des expressions régulières (Regex)
Générer un rapport automatique
Être automatisé (cron / tâche planifiée)

---
# 📂 Structure du projet

```
REGEX/
├── analyse_nginx.ps1           # Script PowerShell complet à exécuter
├── analyse_nginx.py            # Script Python complet à exécuter
├── rapport_nginx_ps1_YYYY-MM-DD.txt
└── rapport_nginx_py_YYYY-MM-DD.txt
```
-----




## 📥 Entrée

```bash
/var/log/nginx/access.log
```
<img width="1485" height="494" alt="image" src="https://github.com/user-attachments/assets/a5c81ced-9096-433c-abfb-fbb07efc9590" />



## 📤 Sortie

```bash
REGEX/rapport_nginx_ps1_YYYY-MM-DD.txt
```

---

# 🧾 **2. Format du log Nginx**

```text
192.168.1.10 - - [17/Mar/2026:14:32:10 +0000] "GET /index.html HTTP/1.1" 200 1024
```

---

# 🧠 **3. Regex utiles**

| Élément   | Regex                   |           |
| --------- | ----------------------- | --------- |
| IP        | `(\d{1,3}\.){3}\d{1,3}` |           |
| Code HTTP | `" (\d{3}) `            |           |
| Pages GET | `"GET ([^ ]+)`          |           |
| Erreurs   | `" (4 \| 5)\d{2} `      |           |

---

# ⚡ **PARTIE 1 — Script PowerShell**

## ✏️ **analyse_nginx.ps1**

nano analyse_nginx.ps1 dans le repertoire REGEX


## ▶️ **Exécution**

```powershell
pwsh ./REGEX/analyse_nginx.ps1
```
<img width="1919" height="816" alt="image" src="https://github.com/user-attachments/assets/8482ed7b-c074-4af1-ac82-43f97c039cb0" />

le fichier powershell

<img width="720" height="113" alt="image" src="https://github.com/user-attachments/assets/d45408f4-74c0-45aa-8419-be81e8effefa" />


---

# 🐍 **PARTIE 2 — Script Python**

## ✏️ **analyse_nginx.py**


---

## ▶️ **Exécution**

```bash
python3 REGEX/analyse_nginx.py
```
<img width="808" height="103" alt="image" src="https://github.com/user-attachments/assets/a67eee6f-75aa-4d11-993c-42419a121482" />

<img width="892" height="114" alt="image" src="https://github.com/user-attachments/assets/8c8f44ba-b85f-4c98-92a3-8a73c8e31cd2" />
<img width="963" height="229" alt="image" src="https://github.com/user-attachments/assets/89e04fc7-f146-45ed-8ff1-d5a9c4ef5a8c" />


---

# ⏰ **PARTIE 3 — Automatisation**

## Linux (cron)

```bash
crontab -e
```

```bash
0 2 * * * /usr/bin/pwsh /home/user/REGEX/analyse_nginx.ps1
```
<img width="1038" height="760" alt="image" src="https://github.com/user-attachments/assets/9f865789-0b59-427d-bfc7-2d2cf0f8af74" />

---

# 🔍 **PARTIE 4 — Vérification**

```bash
grep CRON /var/log/syslog
```
<img width="1857" height="828" alt="image" src="https://github.com/user-attachments/assets/587a5635-e06a-4c81-a979-2e44961f78b5" />

---



# 🎓 **Compétences couvertes**

- ✔ Regex (PowerShell + Python)
- ✔ Analyse de logs web
- ✔ Traitement de texte
- ✔ Automatisation
- ✔ Débogage

---



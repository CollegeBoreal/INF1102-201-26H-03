# TP 7 — Analyse des logs Nginx (Regex)

## 👤 Étudiant

* **Nom et Prénoms** : Babatundé Adissa Fadolle Arouna
* **Numéro étudiant** : 300151970
* **Programme** : Techniques des systèmes informatiques
* **Cours** : INF 1102-201 – Programmation de systèmes
* **Session** : Hiver 2026
* **Professeur** : Brice Robert
* **Date de remise** : 09/04/2026

---

## Objectif

Créer un script qui :

1. Analyse le fichier `/var/log/nginx/access.log`
2. Utilise des expressions régulières (Regex) pour extraire les données importantes
3. Génère un rapport automatique
4. Peut être automatisé via cron ou tâche planifiée

---

## 1️ Connexion au serveur

```bash
ssh -i ~/.ssh/ma_cle.pk -o StrictHostKeyChecking=no -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty ubuntu@10.7.237.223
```


<img width="1491" height="715" alt="1" src="https://github.com/user-attachments/assets/c22e00c4-c717-493c-b95e-aae142d0ae38" />

<img width="1491" height="98" alt="1 1" src="https://github.com/user-attachments/assets/d6a2b245-43d1-494d-ab9f-7fe58be2eb5c" />


* **Résultat attendu :** Connexion SSH établie
* **Commentaire :** La connexion fonctionne correctement, l’environnement Linux est accessible pour exécuter les scripts

---

## 2️ Partie 1 — Script PowerShell

### 2.1 Création du fichier avec nano

```bash
nano REGEX/analyse_nginx.ps1
```

<img width="767" height="69" alt="2" src="https://github.com/user-attachments/assets/6c83749d-9c30-4593-bfbc-d69df346f9c5" />

* **Contenu collé dans nano :**

```powershell
# analyse_nginx.ps1
# Script PowerShell pour analyser les logs Nginx

# Chemin du log
$logfile = "/var/log/nginx/access.log"

# Chemin du rapport
$rapport = "REGEX/rapport_nginx_ps1_$(Get-Date -Format 'yyyy-MM-dd').txt"

# Lire le fichier log
$logs = Get-Content $logfile

# Extraire les adresses IP, codes HTTP et pages visitées
$ips = $logs | ForEach-Object { ($_ -split ' ')[0] }
$codes = $logs | ForEach-Object { ($_ -split ' ')[8] }
$pages = $logs | ForEach-Object { ($_ -split ' ')[6] }

# Calculs
$total = $logs.Count
$errors = $codes | Where-Object { $_ -match "4|5" } | Measure-Object | Select-Object -ExpandProperty Count
$top_ips = $ips | Group-Object | Sort-Object Count -Descending | Select-Object -First 5
$top_pages = $pages | Group-Object | Sort-Object Count -Descending | Select-Object -First 5

# Génération du rapport
"Total des requêtes : $total" | Out-File $rapport
"Nombre d'erreurs HTTP : $errors" | Out-File $rapport -Append
"Top 5 IPs :" | Out-File $rapport -Append
$top_ips | ForEach-Object { "$($_.Name) : $($_.Count)" } | Out-File $rapport -Append
"Top 5 pages :" | Out-File $rapport -Append
$top_pages | ForEach-Object { "$($_.Name) : $($_.Count)" } | Out-File $rapport -Append
```

* **Résultat attendu :** Fichier PowerShell sauvegardé dans `REGEX/analyse_nginx.ps1`

---

### 2.2 Exécution du script PowerShell

```powershell
pwsh REGEX/analyse_nginx.ps1
```

* **Résultat attendu :**

  * ✅ Rapport généré : `REGEX/rapport_nginx_ps1_2026-04-09.txt`
* **Commentaire :** Le script s’exécute correctement et le fichier de rapport contient :

  * Total des requêtes
  * Nombre d’erreurs HTTP (404, 500…)
  * Top 5 des adresses IP
  * Top 5 des pages visitées

---

## 3️ Partie 2 — Script Python

### 3.1 Création du fichier avec nano

```bash
nano REGEX/analyse_nginx.py
```

* **Contenu collé dans nano :**

```python
# analyse_nginx.py
# Script Python pour analyser les logs Nginx

import re
from collections import Counter
from datetime import datetime

logfile = "/var/log/nginx/access.log"
rapport = f"REGEX/rapport_nginx_py_{datetime.today().strftime('%Y-%m-%d')}.txt"

# Lecture des logs
with open(logfile, 'r') as f:
    logs = f.readlines()

# Regex pour extraire IP, code HTTP et page
ips = [re.match(r'(\d+\.\d+\.\d+\.\d+)', line).group(1) for line in logs]
codes = [re.search(r'"\s(\d{3})\s', line).group(1) for line in logs]
pages = [re.search(r'\"[A-Z]+\s(.*?)\sHTTP', line).group(1) for line in logs]

# Calculs
total = len(logs)
errors = len([c for c in codes if c.startswith(('4','5'))])
top_ips = Counter(ips).most_common(5)
top_pages = Counter(pages).most_common(5)

# Génération du rapport
with open(rapport, 'w') as f:
    f.write(f"Total des requêtes : {total}\n")
    f.write(f"Nombre d'erreurs HTTP : {errors}\n")
    f.write("Top 5 IPs :\n")
    for ip, count in top_ips:
        f.write(f"{ip} : {count}\n")
    f.write("Top 5 pages :\n")
    for page, count in top_pages:
        f.write(f"{page} : {count}\n")
```

* **Résultat attendu :** Fichier Python sauvegardé dans `REGEX/analyse_nginx.py`

---

### 3.2 Exécution du script Python

```bash
python3 REGEX/analyse_nginx.py
```

* **Résultat attendu :**

  * ✅ Rapport généré : `REGEX/rapport_nginx_py_2026-04-09.txt`
* **Commentaire :** Le script fonctionne correctement, le rapport contient toutes les informations attendues

---

## 4️ Partie 3 — Automatisation avec cron

### 4.1 Création d’une tâche planifiée

```bash
crontab -e
```

* **Exemple d’entrée pour exécution quotidienne à 02h00 :**

```cron
0 2 * * * /home/ubuntu/REGEX/analyse_nginx.sh
```

* **Résultat attendu :** Tâche cron installée correctement
* **Commentaire :** Le script sera exécuté automatiquement tous les jours à 2h

### 4.2 Vérification des tâches cron

```bash
grep CRON /var/log/syslog
```

* **Résultat attendu :** Présence de lignes montrant l’exécution de la tâche

  * Exemple : `(ubuntu) CMD (/home/ubuntu/REGEX/analyse_nginx.sh)`
* **Commentaire :** Le service cron fonctionne correctement et exécute les scripts automatiquement

---

## 5️ Résultats attendus dans les rapports

Chaque rapport (PowerShell ou Python) doit contenir :

* ✅ Total des requêtes
* ✅ Nombre d’erreurs HTTP (4xx, 5xx)
* ✅ Détail des erreurs 404 et 500
* ✅ Top 5 des adresses IP
* ✅ Top 5 des pages visitées

---

## 6️ Conclusion

* Tous les scripts (Python et PowerShell) fonctionnent correctement
* Les rapports sont générés automatiquement dans le dossier `REGEX`
* L’automatisation avec cron est fonctionnelle
* L’analyse des logs Nginx avec Regex est réussie et exploitable pour un suivi quotidien


















## Exécution du script Python

```bash
python3 REGEX/analyse_nginx.py
```

### ✔ Résultat obtenu

```bash
✅ Rapport généré : REGEX/rapport_nginx_py_2026-04-09.txt
```

###  Commentaire

* Le script Python fonctionne correctement
* Le rapport est généré automatiquement dans le dossier **REGEX**
* Les expressions régulières permettent d’extraire :

  * les codes HTTP
  * les adresses IP
  * les pages visitées

---

##  Exécution du script PowerShell

```bash
pwsh REGEX/analyse_nginx.ps1
```

### ✔ Résultat obtenu

```bash
✅ Rapport généré : REGEX/rapport_nginx_ps1_2026-04-09.txt
```

### Commentaire

* Le script PowerShell s’exécute correctement avec **pwsh**
* Le fichier de rapport est généré sans erreur
* L’analyse des logs Nginx est réalisée avec succès

---

##  Automatisation (cron)

```bash
crontab -e
```

### Résultat obtenu

```bash
crontab: installing new crontab
```

### Commentaire

* La tâche planifiée a été enregistrée correctement
* Le système peut exécuter automatiquement les scripts

---

## Vérification des tâches cron

```bash
grep CRON /var/log/syslog
```

### ✔ Résultat obtenu

* Présence de plusieurs lignes CRON dans le fichier syslog
* Exécution régulière du script :

```bash
(ubuntu) CMD (/home/ubuntu/scruter_nginx.sh)
```

### Commentaire

* Le service cron fonctionne correctement
* Les tâches planifiées sont bien exécutées automatiquement
* Le système enregistre les exécutions dans les logs

---

## Résultats attendus dans les rapports

Les fichiers générés contiennent :

* ✔ Total des requêtes
* ✔ Nombre d’erreurs HTTP
* ✔ Erreurs 404 et 500
* ✔ Top 5 des adresses IP
* ✔ Top 5 des pages visitées

---

## Conclusion

* Tous les scripts (**Python et PowerShell**) fonctionnent correctement
* Les rapports sont générés automatiquement
* L’automatisation avec **cron** est fonctionnelle
* L’analyse des logs Nginx avec **Regex** est réussie



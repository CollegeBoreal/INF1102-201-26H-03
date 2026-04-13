# TP : Analyse des logs Nginx avec Regex (PowerShell & Python)

## Informations

**Nom :** Léandre Manizan  
**Numéro étudiant :** 300141657  
**Cours :** INF1102-201-26H-03  
**Travail :** TP Regex Nginx

---
# TP : Analyse des logs Nginx avec Regex (PowerShell & Python)

**Léandre Manizan**  
**300141657**  
**INF1102-201-26H-03**

---

## Captures

### 1. Structure du dossier REGEX
![Structure du dossier REGEX](images/Image34.png)

### 2. Script PowerShell `analyse_nginx.ps1`
![Script PowerShell](images/Image35.png)

### 3. Script Python `analyse_nginx.py`
![Script Python](images/Image36.png)

### 4. Contenu du fichier `access.log`
![Fichier access.log](images/Image37.png)

### 5. Exécution du script PowerShell
![Execution PowerShell](images/Image38.png)

### 6. Rapport généré par PowerShell
![Rapport PowerShell](images/Image39.png)

### 7. Exécution du script Python
![Execution Python](images/Image40.png)

### 8. Vérification de la crontab
![Crontab](images/Image41.png)

### 9. Vérification des journaux cron
![Journaux cron](images/Image42.png)

---

## Objectif

Analyser le fichier :

```bash
/var/log/nginx/access.log


Le TP permet de :

lire les logs Nginx
utiliser des expressions régulières
extraire les codes HTTP
compter les erreurs HTTP
identifier les adresses IP
identifier les pages les plus demandées
générer des rapports automatiques
automatiser l’exécution avec cron

Structure du projet
300141657/
├── README.md
├── analyse_nginx.ps1
├── analyse_nginx.py
└── images/
    ├── Image34.png
    ├── Image35.png
    ├── Image36.png
    ├── Image37.png
    ├── Image38.png
    ├── Image39.png
    ├── Image40.png
    ├── Image41.png
    └── Image42.png
Entrée
/var/log/nginx/access.log

Exemple de ligne :

127.0.0.1 - - [12/Apr/2026:16:24:26 +0000] "GET /index.html HTTP/1.1" 200 612 "-" "curl/7.81.0"
Regex utilisées
IP            : (\d{1,3}\.){3}\d{1,3}
Code HTTP     : " (\d{3})
Pages GET     : "GET ([^ ]+)
Erreurs HTTP  : codes qui commencent par 4 ou 5
Script PowerShell

Fichier :

analyse_nginx.ps1

Rôle :

lire access.log
extraire les codes HTTP
compter les erreurs HTTP, 404 et 500
afficher le top 5 des IP
afficher le top 5 des pages
générer un rapport texte

Exécution :

pwsh ~/REGEX/analyse_nginx.ps1
Script Python

Fichier :

analyse_nginx.py

Rôle :

lire access.log
utiliser re.findall()
extraire les codes HTTP
compter les erreurs HTTP
extraire les IP
extraire les pages GET
générer un rapport texte

Exécution :

python3 ~/REGEX/analyse_nginx.py
Automatisation

Éditer la crontab :

crontab -e

Ligne ajoutée :

0 2 * * * /usr/bin/pwsh /home/ubuntu/REGEX/analyse_nginx.ps1

Vérification :

crontab -l

Logs cron :

grep CRON /var/log/syslog | tail -n 20
Résultat

Les scripts génèrent automatiquement :

rapport_nginx_ps1_YYYY-MM-DD.txt
rapport_nginx_py_YYYY-MM-DD.txt

Ils permettent d’obtenir :

le total des requêtes
le nombre d’erreurs HTTP
le nombre d’erreurs 404
le nombre d’erreurs 500
le top 5 des adresses IP
le top 5 des pages demandées
Conclusion

Ce TP m’a permis de pratiquer l’analyse de logs Nginx avec PowerShell et Python.

J’ai pu :

lire un fichier de logs web
utiliser des expressions régulières
extraire des informations utiles
générer des rapports automatiques
automatiser l’exécution avec cron
vérifier les résultats dans les journaux système

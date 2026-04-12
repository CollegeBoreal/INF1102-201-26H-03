# 🧪 TP : Analyse des logs Nginx avec Regex (PowerShell & Python)

## 👤 Informations de l’étudiant

- **Nom :** Léandre Manizan  
- **Numéro étudiant :** 300141657  
- **Cours :** INF1102-201-26H-03  
- **Travail :** TP Regex Nginx

---

## 🎯 Objectif

Ce TP a pour objectif de créer deux scripts, un en **PowerShell** et un en **Python**, afin d’analyser le fichier de logs Nginx :

```bash
/var/log/nginx/access.log

Les scripts doivent permettre de :

lire le fichier de logs Nginx
utiliser des expressions régulières
extraire les codes HTTP
compter les erreurs HTTP
identifier les adresses IP
identifier les pages les plus demandées
générer automatiquement un rapport texte
automatiser l’exécution avec cron
📁 Structure du projet
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
📥 Entrée

Le fichier analysé est :

/var/log/nginx/access.log

Exemple de ligne de log :

192.168.1.10 - - [17/Mar/2026:14:32:10 +0000] "GET /index.html HTTP/1.1" 200 1024
📤 Sorties

Les scripts génèrent automatiquement les rapports suivants :

REGEX/rapport_nginx_ps1_YYYY-MM-DD.txt
REGEX/rapport_nginx_py_YYYY-MM-DD.txt
🧠 Expressions régulières utilisées

Les regex utilisées dans ce TP permettent d’extraire les informations importantes du log Nginx :

IP           : (\d{1,3}\.){3}\d{1,3}
Code HTTP    : " (\d{3})
Pages GET    : "GET ([^ ]+)
Erreurs HTTP : codes commençant par 4 ou 5
⚡ Script PowerShell : analyse_nginx.ps1

Ce script PowerShell analyse le fichier /var/log/nginx/access.log, extrait les codes HTTP, les erreurs, les adresses IP et les pages demandées, puis génère un rapport texte.

Fonctionnalités du script
lecture du fichier de logs
extraction des codes HTTP
calcul du nombre d’erreurs HTTP
calcul du nombre d’erreurs 404
calcul du nombre d’erreurs 500
extraction des adresses IP
extraction des pages GET
génération du rapport PowerShell
Commande d’exécution
pwsh ~/REGEX/analyse_nginx.ps1
🐍 Script Python : analyse_nginx.py

Ce script Python réalise la même analyse à l’aide du module re et des compteurs Python.

Fonctionnalités du script
lecture du fichier de logs
utilisation de re.findall()
extraction des codes HTTP
calcul des erreurs HTTP
extraction des IP
extraction des pages GET
génération du rapport Python
Commande d’exécution
python3 ~/REGEX/analyse_nginx.py
⏰ Automatisation avec cron

Afin d’automatiser l’exécution du script PowerShell, une tâche cron a été ajoutée.

Commande
crontab -e
Ligne ajoutée
0 2 * * * /usr/bin/pwsh /home/ubuntu/REGEX/analyse_nginx.ps1

Cette ligne permet d’exécuter automatiquement le script tous les jours à 2h00 du matin.

🔍 Vérification
Vérification de la tâche cron
crontab -l
Vérification dans les logs système
grep CRON /var/log/syslog | tail -n 20
🧯 Dépannage

Quelques problèmes possibles dans ce TP :

Accès refusé au fichier log
Solution : utiliser sudo
Script PowerShell ne lit pas le log
Solution : vérifier le chemin /var/log/nginx/access.log
Regex incorrecte
Solution : tester sur quelques lignes du fichier log
Cron ne fonctionne pas
Solution : utiliser le chemin absolu du script
✅ Compétences couvertes

Ce TP permet de pratiquer :

les expressions régulières
l’analyse de logs web
le traitement de texte
l’automatisation avec cron
le débogage de scripts
l’utilisation combinée de PowerShell et Python
📸 Captures d’écran
1. Structure du dossier REGEX
<p align="center"> <img src="images/Image34.png" alt="Structure du dossier REGEX" width="900"> </p>

Cette capture montre le contenu du dossier REGEX, avec les deux scripts et les deux rapports générés.

2. Contenu du script PowerShell analyse_nginx.ps1
<p align="center"> <img src="images/Image35.png" alt="Contenu du script analyse_nginx.ps1" width="900"> </p>

Cette capture présente le script PowerShell chargé d’analyser le fichier access.log et de produire un rapport.

3. Contenu du script Python analyse_nginx.py
<p align="center"> <img src="images/Image36.png" alt="Contenu du script analyse_nginx.py" width="900"> </p>

Cette capture montre le script Python utilisant des regex pour lire les logs Nginx et générer un rapport.

4. Contenu du fichier /var/log/nginx/access.log
<p align="center"> <img src="images/Image37.png" alt="Contenu du fichier access.log" width="900"> </p>

Cette capture montre les lignes présentes dans le fichier de logs Nginx qui servent d’entrée à l’analyse.

5. Exécution du script PowerShell
<p align="center"> <img src="images/Image38.png" alt="Execution du script PowerShell" width="900"> </p>

Cette capture confirme que le script PowerShell s’exécute correctement et génère le rapport rapport_nginx_ps1_YYYY-MM-DD.txt.

6. Rapport généré par PowerShell
<p align="center"> <img src="images/Image39.png" alt="Rapport genere par PowerShell" width="900"> </p>

Cette capture montre le contenu du rapport PowerShell avec :

le total des requêtes
le nombre d’erreurs HTTP
les erreurs 404
les erreurs 500
le top 5 des IP
le top 5 des pages
7. Exécution du script Python
<p align="center"> <img src="images/Image40.png" alt="Execution du script Python" width="900"> </p>

Cette capture confirme que le script Python s’exécute correctement et génère son propre rapport.

8. Vérification de la tâche cron
<p align="center"> <img src="images/Image41.png" alt="Verification de la crontab" width="900"> </p>

Cette capture montre que la tâche cron a bien été ajoutée pour automatiser l’exécution du script PowerShell.

9. Vérification des journaux cron
<p align="center"> <img src="images/Image42.png" alt="Verification des journaux cron" width="900"> </p>

Cette capture montre les entrées du service cron dans /var/log/syslog, ce qui permet de vérifier l’activité des tâches planifiées.

🏁 Conclusion

Ce TP m’a permis de mettre en pratique l’analyse de logs Nginx avec deux langages de script différents : PowerShell et Python.

J’ai pu :

lire un fichier de logs Nginx
utiliser des expressions régulières
extraire des informations utiles
générer des rapports automatiques
planifier l’exécution avec cron
vérifier le bon fonctionnement à l’aide des journaux système

Ce travail montre donc une bonne maîtrise du traitement de texte, de l’analyse de logs et de l’automatisation sous Linux.

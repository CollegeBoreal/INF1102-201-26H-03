\# TP Surveillance Nginx



\## Étudiant

300150195



\## Objectif

Surveiller le système en temps réel et analyser les pannes après coup.



\## Outils utilisés

\- top

\- htop

\- ps aux

\- uptime

\- free -h

\- df -h

\- journalctl

\- systemctl



\## Exercice Nginx

Le but est d'extraire les adresses IP des visiteurs depuis le fichier /var/log/nginx/access.log.



\## Commande principale

awk '{print $1}' /var/log/nginx/access.log | sort | uniq



\## Script

Le script scruter\_nginx.sh extrait les IP uniques et les enregistre dans un fichier.



\## Automatisation

Le script est automatisé avec cron pour s’exécuter toutes les heures.


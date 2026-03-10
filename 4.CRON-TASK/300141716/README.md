# CRON Task – Analyse des logs Nginx



\## Étudiante

Nabila Oulad-Bouih  

Boréal ID : 300141716  

Cours : INF1102 – Programmation système



---



\## Objectif



Analyser les logs du serveur web Nginx afin d'extraire les adresses IP des visiteurs et automatiser cette tâche avec cron.



---



\## Script utilisé



```bash

\#!/bin/bash



LOG\_FILE="/var/log/nginx/access.log"

OUTPUT\_FILE="/home/ubuntu/nginx\_ips.txt"



awk '{print $1}' $LOG\_FILE | sort | uniq > $OUTPUT\_FILE



echo "Script exécuté le $(date)" >> /home/ubuntu/nginx\_ips.log

Automatisation avec cron

0 \* \* \* \* /home/ubuntu/scruter\_nginx.sh



Le script s'exécute toutes les heures pour analyser les logs Nginx.



Résultat



Extraction automatique des IP visiteurs



Surveillance des logs Nginx



Automatisation avec cron


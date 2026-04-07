# Surveillance des logs Nginx avec Cron

## Objectif
Surveiller le système en temps réel et analyser les logs Nginx.

## Commandes utilisées

- top
- free -h
- df -h
- journalctl
- awk

## Extraction des IP

awk '{print $1}' /var/log/nginx/access.log | sort | uniq

## Script

Le script scruter_nginx.sh permet d’automatiser l’extraction des IP.

## Cron

0 * * * * /home/ubuntu/scruter_nginx.sh

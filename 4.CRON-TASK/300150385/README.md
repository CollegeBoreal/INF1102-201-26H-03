# TP CRON – Surveillance NGINX

## Informations du cours
- Cours : INF1102 (201) – Programmation de systèmes (Section 3)
- Étudiant : Medjkoune Belkacem
- ID Boréal : 300150385
- Machine virtuelle : 10.7.237.215

---

## 🎯 Objectif
Surveiller les accès au serveur NGINX et extraire les adresses IP des visiteurs automatiquement.

---

## 🔍 Analyse des logs

Fichier analysé : /var/log/nginx/access.log

Commande utilisée : awk '{print $1}' /var/log/nginx/access.log | sort | uniq

Résultat :
Extraction des IP uniques des visiteurs.

---

## ⚙️ Script automatisé

Fichier : scruter_nginx.sh

Fonction :
- Extraire les IP uniques
- Les stocker dans nginx_ips.txt
- Ajouter un log d’exécution avec timestamp

---

## 🕒 Automatisation CRON

Commande : crontab -e


Ligne ajoutée : 0 * * * * /home/ubuntu/scruter_nginx.sh


Le script s’exécute toutes les heures.

---

## ✅ Vérifications

- systemctl status cron
- crontab -l
- cat /home/ubuntu/nginx_ips.txt
- cat /home/ubuntu/nginx_execution.log

---

## 📌 Conclusion

Le serveur NGINX est surveillé automatiquement.
Les IP des visiteurs sont extraites et enregistrées chaque heure.

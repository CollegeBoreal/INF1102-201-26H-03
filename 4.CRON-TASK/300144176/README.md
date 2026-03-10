## 👤 Étudiant

- Identifiant : **300144176**
- Nom: awa
- Cours : Programmation système 
- Thème : **CRON-TASK**
- -----
## 🎯 Objectif
Surveiller les accès au serveur NGINX et extraire les adresses IP des visiteurs automatiquement.

---

## 🔍 Analyse des logs

Fichier analysé : /var/log/nginx/access.log

Commande utilisée : awk '{print $1}' /var/log/nginx/access.log | sort | uniq



Screenshot 4 .1 cron.png

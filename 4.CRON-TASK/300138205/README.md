## 👤 Étudiant

- Identifiant : **300138205**
- Nom: Taylor
- Cours : Programmation système 
- Thème : **CRON-TASK**
- -----
## 🎯 Objectif
Surveiller les accès au serveur NGINX et extraire les adresses IP des visiteurs automatiquement.

---

## 🔍 Analyse des logs

Fichier analysé : /var/log/nginx/access.log

Commande utilisée : awk '{print $1}' /var/log/nginx/access.log | sort | uniq
<img width="975" height="65" alt="image" src="https://github.com/user-attachments/assets/90d7423d-a174-4e87-81ae-3fdc9ef08038" />


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
<img width="1919" height="729" alt="image" src="https://github.com/user-attachments/assets/a9527b86-40c7-431a-92e7-baf81560c8f9" />



Le script s’exécute toutes les heures.

---

## ✅ Vérifications

- systemctl status cron
- crontab -l
  <img width="1439" height="522" alt="image" src="https://github.com/user-attachments/assets/74c51a3d-b88c-43e0-8e54-0a0ce58734d2" />

- cat /home/ubuntu/nginx_ips.txt
- cat /home/ubuntu/nginx_execution.log
<img width="845" height="618" alt="Capture d’écran 2026-02-10 185654" src="https://github.com/user-attachments/assets/6f440734-fd54-4484-b4a3-09d29bb215f6" />
<img width="832" height="621" alt="Capture d’écran 2026-02-10 185705" src="https://github.com/user-attachments/assets/2cee83a3-4703-4f7a-b0f7-d635fd350f7d" />

<img width="709" height="135" alt="image" src="https://github.com/user-attachments/assets/a053d7ce-6e13-44a4-84e6-5e8907596f67" />



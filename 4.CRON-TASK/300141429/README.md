```powershell
#Extraction des adresses IP dans Nginx
awk '{print $1}' /var/log/nginx/access.log 
```
<img width="479" height="85" alt="image" src="https://github.com/user-attachments/assets/f1289106-4209-4da2-b9dd-2c26eac9cdb5" />

Ceci affiche toutes les adresses IP uniques qui ont visité le serveur.

 ```powershell
 cat /var/log/nginx/access.log
```
<img width="947" height="155" alt="image" src="https://github.com/user-attachments/assets/b411524e-d8c5-45f8-a12a-2e2a2d6284be" />

Il affiche toutes les visites enregistrées par Nginx dans son fichier de log.

 ```powershell
crontab -e
```
<img width="526" height="354" alt="image" src="https://github.com/user-attachments/assets/9b763250-057a-4454-879c-2d0b9b997ff5" />

La derniere ligne dit à Cron d’exécuter le script /home/ubuntu/scruter_nginx.sh automatiquement à chaque heure.

#Verification que cron est actif 
```powershell
systemctl status cron
```
<img width="542" height="244" alt="image" src="https://github.com/user-attachments/assets/efff83e8-39f2-456a-95ab-bd7425f49e4c" />


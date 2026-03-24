```powershell
#Extraction des adresses IP dans Nginx
awk '{print $1}' /var/log/nginx/access.log 
```
<img width="872" height="72" alt="image" src="https://github.com/user-attachments/assets/acbabab2-d466-47c0-8fe2-747a89eec526" />


Ceci affiche toutes les adresses IP uniques qui ont visité le serveur.

 ```powershell
 cat /var/log/nginx/access.log
```
<img width="1897" height="118" alt="image" src="https://github.com/user-attachments/assets/2e121454-3ef4-417a-a524-c353f6ae2549" />


Il affiche toutes les visites enregistrées par Nginx dans son fichier de log.

 ```powershell
crontab -e
```
<img width="1880" height="950" alt="image" src="https://github.com/user-attachments/assets/3210219d-6065-4d63-8bc9-847711a61b76" />


La derniere ligne dit à Cron d’exécuter le script /home/ubuntu/scruter_nginx.sh automatiquement à chaque heure.

#Verification que cron est actif 
```powershell
systemctl status cron
```
<img width="1918" height="723" alt="image" src="https://github.com/user-attachments/assets/539da1a2-cd24-47db-ad49-1049ad1d783d" />



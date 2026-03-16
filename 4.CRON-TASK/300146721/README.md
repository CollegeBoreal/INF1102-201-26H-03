
# Analyse des logs Nginx

## 1. Vérification du service Nginx
```bash
systemctl status nginx
```

<img src='images/1 systemctl status nginx.PNG'/>

---

## 2. Extraction des adresses IP
```bash
awk '{print $1}' /var/log/nginx/access.log
```

![logs](images/3.PNG)

---

## 3. Création du script shel
```bash
nano scruter_nginx.sh
```
![script](images/4.PNG)

---

## 4. Automatisation avec cron
```bash
crontab -e
```
<img src='images/6.PNG'/>
<img src='images/site 192.PNG'/>


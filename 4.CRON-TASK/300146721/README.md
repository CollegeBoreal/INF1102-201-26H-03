## Vérification du service Nginx

Commande utilisée :
```bash
systemctl status nginx
```
![nginx](photos/1 systemctl status nginx.PNG)

# Analyse des logs Nginx

## 1. Vérification du service Nginx
```bash
systemctl status nginx
```

![nginx](photos/nginx-status.png)

---

## 2. Extraction des adresses IP
```bash
awk '{print $1}' /var/log/nginx/access.log
```

![logs](photos/3.PNG)

---

## 3. Création du script shel
```bash
nano scruter_nginx.sh
```
![script](photos/4.PNG)

---

## 4. Automatisation avec cron
```bash
crontab -e
```
![cron](photos/6.PNG)


![cron](photos/site 192.PNG)

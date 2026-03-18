# Surveillance des logs Nginx avec Cron

## 👤 Auteur

Zakaria Djellouli
Id : 300150433

---

## 🎯 Objectif

Analyser les logs du serveur Nginx pour :

* Extraire les adresses IP des visiteurs
* Identifier les visiteurs les plus fréquents
* Automatiser l’analyse avec cron

---

## 📂 Fichier analysé

/var/log/nginx/access.log

---

## ⚙️ Script utilisé

Le script `scruter_nginx.sh` permet de :

* Extraire les IP
* Supprimer les doublons
* Compter les visites
* Sauvegarder les résultats
* Ajouter un log d’exécution

---

## 📄 Fichiers générés

* nginx_ips.txt
* nginx_ips_freq.txt
* nginx_ips.log

---

## 🔁 Automatisation avec Cron

```
0 * * * * /home/ubuntu/scruter_nginx.sh
```

---

## 🧪 Résumé des étapes et commandes

### 1. Vérifier Nginx

```
systemctl status nginx
```

### 2. Consulter les logs

```
cat /var/log/nginx/access.log
```

### 3. Extraire les IP

```
awk '{print $1}' /var/log/nginx/access.log
```

### 4. Supprimer les doublons

```
awk '{print $1}' /var/log/nginx/access.log | sort | uniq
```

### 5. Sauvegarder les IP

```
awk '{print $1}' /var/log/nginx/access.log | sort | uniq > nginx_ips.txt
```

### 6. Compter les visites

```
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr
```

### 7. Créer le script

```
nano /home/ubuntu/scruter_nginx.sh
chmod +x /home/ubuntu/scruter_nginx.sh
```

### 8. Tester le script

```
/home/ubuntu/scruter_nginx.sh
```

### 9. Configurer cron

```
crontab -e
```

Ajouter :

```
0 * * * * /home/ubuntu/scruter_nginx.sh
```

### 10. Vérifier cron

```
crontab -l
```

---

## 📸 Captures d’écran

### Nginx en fonctionnement

<img width="496" height="83" alt="capture nginx" src="https://github.com/user-attachments/assets/92ba20b2-4e26-48e0-959b-0bb7d7ed7a0f" />

### Script exécuté

<img width="1034" height="416" alt="capture scruter_nginx" src="https://github.com/user-attachments/assets/0ad5f7d6-8c7d-4b77-9c9e-1076ee9ccdfd" />


### Configuration Cron

<img width="863" height="538" alt="capture crontab" src="https://github.com/user-attachments/assets/7cc97ae1-8a1d-4520-8de2-e4d3f9bdcf78" />


---

## ✅ Conclusion

Ce projet permet de surveiller efficacement un serveur web en combinant :

* Analyse des logs
* Scripts Bash
* Automatisation avec cron

Il s’agit d’une compétence essentielle en administration système.

---


# Surveillance des logs Nginx avec Cron

## 👤 Auteur

amira sadouni
Id : 300150558

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


### Script exécuté


### Configuration Cron


---

## ✅ Conclusion

Ce projet permet de surveiller efficacement un serveur web en combinant :

* Analyse des logs
* Scripts Bash
* Automatisation avec cron

Il s’agit d’une compétence essentielle en administration système.

---


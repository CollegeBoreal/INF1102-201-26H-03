
# 📘 README – Analyse des logs Nginx et automatisation sous Linux

## 🧾 1. Objectif du projet

Ce travail vise à analyser les journaux d’un serveur web Nginx afin d’extraire les adresses IP des visiteurs, puis à automatiser ce traitement à l’aide d’un script Bash et du planificateur CRON.

Les objectifs sont :

* Lire et comprendre les logs Nginx
* Extraire les adresses IP
* Supprimer les doublons
* Automatiser le traitement
* Générer des fichiers d’analyse

---

## 🖥 2. Environnement utilisé

* Système : Ubuntu Server
* Terminal Linux (Bash)
* Service web : Nginx
* Outils : awk, sort, uniq, cron

---

## 📁 3. Fichiers utilisés

| Fichier                         | Description              |
| ------------------------------- | ------------------------ |
| `/var/log/nginx/access.log`     | Journal des requêtes web |
| `/home/ubuntu/nginx_ips.txt`    | Liste des IP uniques     |
| `/home/ubuntu/nginx_ips.log`    | Journal d’exécution      |
| `/home/ubuntu/scruter_nginx.sh` | Script automatisé        |

---

## 🔍 4. Analyse du fichier access.log

Exemple de ligne :

```id="6j9g32"
192.168.1.15 - - [05/Feb/2026:15:20:11 +0000] "GET /index.html HTTP/1.1" 200 1024
```

* Colonne 1 → adresse IP du visiteur
* Autres infos → date, requête, statut HTTP

---

## ⚙️ 5. Extraction des adresses IP

### ✔ Commande de base

```bash id="a1n3os"
awk '{print $1}' /var/log/nginx/access.log
```

### ✔ Suppression des doublons

```bash id="c9o8wz"
awk '{print $1}' /var/log/nginx/access.log | sort | uniq
```

### ✔ Enregistrement dans un fichier

```bash id="l3p7kd"
awk '{print $1}' /var/log/nginx/access.log | sort | uniq > /home/ubuntu/nginx_ips.txt
```

---

## 🧠 6. Script Bash

Création du script :

```bash id="q0x2lm"
nano /home/ubuntu/scruter_nginx.sh
```

### 📄 Contenu du script

```bash id="8i3kqp"
#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/home/ubuntu/nginx_ips.txt"
EXEC_LOG="/home/ubuntu/nginx_ips.log"

if [ -f "$LOG_FILE" ]; then
    awk '{print $1}' "$LOG_FILE" | sort | uniq > "$OUTPUT_FILE"
    echo "Script exécuté le $(date)" >> "$EXEC_LOG"
else
    echo "Erreur : fichier introuvable $(date)" >> "$EXEC_LOG"
fi
```

---

## ▶️ 7. Exécution du script

Rendre exécutable :

```bash id="2bz8hf"
chmod +x /home/ubuntu/scruter_nginx.sh
```

Exécuter :

```bash id="w4v3ne"
/home/ubuntu/scruter_nginx.sh
```

Vérifier :

```bash id="h2r8af"
cat /home/ubuntu/nginx_ips.txt
```

---

## ⏰ 8. Automatisation avec CRON

Modifier le crontab :

```bash id="n9s6we"
crontab -e
```

Ajouter :

```bash id="m1k5zo"
0 * * * * /home/ubuntu/scruter_nginx.sh
```

➡ Exécution automatique toutes les heures

---

## 🔎 9. Vérification du service CRON

```bash id="f6r3bn"
systemctl status cron
```

Logs :

```bash id="z7x9pt"
journalctl -u cron
```

---

## 📊 10. Analyse avancée (Bonus)

Détection des IP les plus actives :

```bash id="t2v8qa"
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr > /home/ubuntu/nginx_ips_freq.txt
```

---

## ⚠️ 11. Dépannage

| Problème               | Cause              | Solution                    |
| ---------------------- | ------------------ | --------------------------- |
| access.log introuvable | Nginx non installé | installer ou démarrer Nginx |
| fichier vide           | pas de trafic      | générer des requêtes        |
| permission denied      | accès refusé       | utiliser sudo               |
| cron ne fonctionne pas | service arrêté     | systemctl start cron        |

---

## 🚀 12. Conclusion

Ce projet démontre :

* l’analyse des journaux système Linux
* l’utilisation d’outils de traitement de texte (awk, sort, uniq)
* l’automatisation avec Bash
* la planification avec cron

Il permet de comprendre comment surveiller l’activité d’un serveur web et détecter les visiteurs.

---

## 📚 13. Références

Documentation Linux
Man pages : awk, cron, journalctl
Documentation Nginx

---

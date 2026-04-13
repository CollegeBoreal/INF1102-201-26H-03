# ⏰ Automatisation CRON — LAB 4 CRON TASK

> Projet étudiant réalisé dans le cadre du cours **INF1102** — Collège Boréal  
> Dossier : `4.CRON-TASK/300150485`

![Session](https://img.shields.io/badge/Session-Hiver%202026-blue?style=flat)
![Statut](https://img.shields.io/badge/Statut-Complété-success?style=flat)
![Bash](https://img.shields.io/badge/Bash-Automatisation-green?style=flat&logo=gnubash)

---

## 📋 Description

Ce laboratoire consiste à analyser les logs du serveur web **Nginx**, extraire les adresses IP des visiteurs, créer un script Bash automatisé et planifier son exécution périodique avec **CRON**. C'est une introduction concrète à l'automatisation des tâches d'administration système sous Linux.

---

## 🎯 Objectifs

- Analyser le fichier de logs Nginx (`access.log`)
- Extraire et compter les adresses IP avec `awk`, `sort`, `uniq`
- Créer un script Bash réutilisable
- Automatiser l'exécution du script avec `cron`
- Générer un fichier de sortie avec les résultats

---

## 🛠️ Technologies utilisées

| Technologie | Rôle |
|-------------|------|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white) | Scripting et automatisation |
| ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black) | Environnement d'exécution (VM Ubuntu) |
| CRON | Planificateur de tâches Linux |
| Nginx | Serveur web dont on analyse les logs |
| ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) | Versionnement du projet |

---

## 📁 Structure du projet

```
4.CRON-TASK/300150485/
├── 🔧 scruter_nginx.sh      # Script Bash d'analyse des logs
├── 📝 nginx_ips.txt         # Fichier de sortie avec les IPs extraites
├── 🖼️ images/              # Captures d'écran des résultats
└── 📖 README.md             # Documentation du projet
```

---

## 📂 Fichier analysé

```
/var/log/nginx/access.log
```

---

## 🔎 Commandes utilisées

### Extraire les adresses IP

```bash
awk '{print $1}' access.log
```

### Supprimer les doublons

```bash
awk '{print $1}' access.log | sort | uniq
```

### Compter la fréquence et trier

```bash
awk '{print $1}' access.log | sort | uniq -c | sort -nr
```

### Exemple de résultat

```
     45 192.168.1.1
     32 192.168.1.2
     18 10.0.0.5
      7 172.16.0.3
```

---

## 📝 Script Bash — `scruter_nginx.sh`

```bash
#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/home/$USER/nginx_ips.txt"
LOG_EXEC="/home/$USER/nginx_execution.log"

# Extraire les IPs uniques et les sauvegarder
awk '{print $1}' $LOG_FILE | sort | uniq > $OUTPUT_FILE

# Journaliser l'exécution
echo "Script execute le $(date)" >> $LOG_EXEC

echo "Analyse terminee. Resultats dans $OUTPUT_FILE"
```

### Rendre le script exécutable

```bash
chmod +x scruter_nginx.sh
```

### Lancer manuellement

```bash
bash scruter_nginx.sh
```

---

## ⏰ Automatisation avec CRON

### Ouvrir le crontab

```bash
crontab -e
```

### Ajouter la tâche planifiée

```bash
# Exécuter toutes les heures
0 * * * * /home/ubuntu/scruter_nginx.sh

# Exécuter tous les jours à minuit
0 0 * * * /home/ubuntu/scruter_nginx.sh

# Exécuter toutes les 5 minutes (pour tester)
*/5 * * * * /home/ubuntu/scruter_nginx.sh
```

### Syntaxe CRON

```
*  *  *  *  *   commande
│  │  │  │  │
│  │  │  │  └── Jour de la semaine (0-7)
│  │  │  └───── Mois (1-12)
│  │  └──────── Jour du mois (1-31)
│  └─────────── Heure (0-23)
└────────────── Minute (0-59)
```

### Vérifier les tâches CRON actives

```bash
crontab -l
```

---

## 📊 Résultats attendus

| Fichier généré | Contenu |
|----------------|---------|
| `nginx_ips.txt` | Liste des adresses IP uniques extraites |
| `nginx_execution.log` | Journal d'exécution avec horodatage |

---

## 💡 Concepts clés

| Concept | Explication |
|---------|-------------|
| `awk` | Outil de traitement de texte ligne par ligne |
| `sort` | Trie les lignes alphabétiquement ou numériquement |
| `uniq` | Supprime les lignes dupliquées consécutives |
| `cron` | Démon Linux pour planifier des tâches |
| `crontab` | Fichier de configuration des tâches CRON |

---

## 👤 Auteur

**Nadir Fetis**  
Étudiant en Techniques de l'informatique — Collège Boréal

---

## 🏫 Contexte académique

| Champ | Détail |
|-------|--------|
| Établissement | Collège Boréal |
| Cours | INF1102 — Introduction au DevOps |
| LAB | 4 — Automatisation CRON TASK |
| Session | Hiver 2026 |
| Dossier | `4.CRON-TASK/300150485` |

---

<div align="center">
  <sub>Fait avec ❤️ par Nadir Fetis — Collège Boréal</sub>
</div>

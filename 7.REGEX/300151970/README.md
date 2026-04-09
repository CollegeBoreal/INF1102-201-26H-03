**TP 7 — Analyse des logs Nginx (Regex)**


## 👤 Étudiant

**Nom et Prénoms** : Babatundé Adissa Fadolle Arouna

**Numéro étudiant** : 300151970

**Programme** : Techniques des systèmes informatiques

**Cours** : INF 1102-201 – Programmation de systèmes

**Session** : Hiver 2026

**Professeur** : Brice Robert

**Date de remise** : 09/04/2026


## Objectif
Créer un script qui :

Analyse /var/log/nginx/access.log
Utilise des expressions régulières
Génère un rapport automatique
Peut être automatisé (cron / tâche planifiée)

 ## 1. Fichiers

    REGEX/
├── analyse_nginx.ps1           # Script PowerShell complet à exécuter
├── analyse_nginx.py            # Script Python complet à exécuter
├── rapport_nginx_ps1_YYYY-MM-DD.txt
└── rapport_nginx_py_YYYY-MM-DD.txt


##  Connexion au serveur (réussie)

```bash
ssh -i ~/.ssh/ma_cle.pk -o StrictHostKeyChecking=no -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty ubuntu@10.7.237.223
```

<img width="1491" height="715" alt="1" src="https://github.com/user-attachments/assets/c22e00c4-c717-493c-b95e-aae142d0ae38" />

<img width="1491" height="98" alt="1 1" src="https://github.com/user-attachments/assets/d6a2b245-43d1-494d-ab9f-7fe58be2eb5c" />


###  Résultat obtenu

* Connexion SSH établie avec succès
* Accès au serveur Ubuntu confirmé

### Commentaire

* La connexion distante fonctionne correctement
* L’environnement Linux est accessible pour exécuter les scripts

---

## PARTIE 1 — Script PowerShell

```bash
nano analyse_nginx.ps1
```

<img width="767" height="69" alt="2" src="https://github.com/user-attachments/assets/6c83749d-9c30-4593-bfbc-d69df346f9c5" />


## Dans l'éditeur nano, j'ai collé ceci:

<img width="1477" height="755" alt="ps1" src="https://github.com/user-attachments/assets/cf6706a0-4139-4d36-bf38-7d58ff227b88" />


## Exécution du script Python

```bash
python3 REGEX/analyse_nginx.py
```

### ✔ Résultat obtenu

```bash
✅ Rapport généré : REGEX/rapport_nginx_py_2026-04-09.txt
```

###  Commentaire

* Le script Python fonctionne correctement
* Le rapport est généré automatiquement dans le dossier **REGEX**
* Les expressions régulières permettent d’extraire :

  * les codes HTTP
  * les adresses IP
  * les pages visitées

---

##  Exécution du script PowerShell

```bash
pwsh REGEX/analyse_nginx.ps1
```

### ✔ Résultat obtenu

```bash
✅ Rapport généré : REGEX/rapport_nginx_ps1_2026-04-09.txt
```

### Commentaire

* Le script PowerShell s’exécute correctement avec **pwsh**
* Le fichier de rapport est généré sans erreur
* L’analyse des logs Nginx est réalisée avec succès

---

##  Automatisation (cron)

```bash
crontab -e
```

### Résultat obtenu

```bash
crontab: installing new crontab
```

### Commentaire

* La tâche planifiée a été enregistrée correctement
* Le système peut exécuter automatiquement les scripts

---

## Vérification des tâches cron

```bash
grep CRON /var/log/syslog
```

### ✔ Résultat obtenu

* Présence de plusieurs lignes CRON dans le fichier syslog
* Exécution régulière du script :

```bash
(ubuntu) CMD (/home/ubuntu/scruter_nginx.sh)
```

### Commentaire

* Le service cron fonctionne correctement
* Les tâches planifiées sont bien exécutées automatiquement
* Le système enregistre les exécutions dans les logs

---

## Résultats attendus dans les rapports

Les fichiers générés contiennent :

* ✔ Total des requêtes
* ✔ Nombre d’erreurs HTTP
* ✔ Erreurs 404 et 500
* ✔ Top 5 des adresses IP
* ✔ Top 5 des pages visitées

---

## Conclusion

* Tous les scripts (**Python et PowerShell**) fonctionnent correctement
* Les rapports sont générés automatiquement
* L’automatisation avec **cron** est fonctionnelle
* L’analyse des logs Nginx avec **Regex** est réussie



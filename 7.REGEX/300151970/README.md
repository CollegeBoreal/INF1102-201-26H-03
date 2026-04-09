**TP 7 — Analyse des logs Nginx (Regex)**


## 👤 Étudiant**

**Nom et Prénoms** : Babatundé Adissa Fadolle Arouna

**Numéro étudiant** : 300151970

**Programme** : Techniques des systèmes informatiques

**Cours** : INF 1102-201 – Programmation de systèmes

**Session** : Hiver 2026

**Professeur** : Brice Robert

**Date de remise** : 01/04/2026



## ✅ Connexion au serveur (réussie)

```bash
ssh -i ~/.ssh/ma_cle.pk -o StrictHostKeyChecking=no -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty ubuntu@10.7.237.223
```

###  Résultat obtenu

* Connexion SSH établie avec succès
* Accès au serveur Ubuntu confirmé

### Commentaire

* La connexion distante fonctionne correctement
* L’environnement Linux est accessible pour exécuter les scripts

---

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



#  TP : Analyse des logs Nginx avec Regex (PowerShell & Python)

##  Aperçu

Ce laboratoire consiste à analyser automatiquement les logs dun serveur 
Nginx en utilisant des scripts.

Le but est de :
- Compter le nombre total de requêtes
- Identifier les erreurs HTTP
- Extraire les IP les plus actives
- Générer un rapport automatiquement

Deux technologies ont été utilisées :
- PowerShell (pwsh)
- Python

---

##  Objectifs

À la fin de ce TP, jai été capable de :

- Analyser un fichier de logs Nginx
- Utiliser des expressions régulières (Regex)
- Écrire un script PowerShell sous Linux
- Écrire un script Python pour traiter des données
- Générer des rapports automatiquement
- Corriger des erreurs dans un script (debug)

---

##  Structure du projet


REGEX/
 analyse_nginx.ps1
 analyse_nginx.py
 rapport_nginx_ps1_YYYY-MM-DD.txt
 rapport_nginx_py_YYYY-MM-DD.txt
 nginx_ips.log


---

##  Préparation

Au début, le fichier `/var/log/nginx/access.log` était vide.

Jai donc généré du trafic avec :

```bash
for i in {1..50}; do curl -s http://localhost > /dev/null; done

Ensuite, jai extrait les IP :

cat /var/log/nginx/access.log | awk '{print $1}' > nginx_ips.log
 Exécution
 Script PowerShell
pwsh ./analyse_nginx.ps1
 Script Python
python3 ./analyse_nginx.py
 Résultats
Script PowerShell

Script Python

Rapport PowerShell

Rapport Python

 Exemple de sortie
Total requêtes : 55

Top 5 IP :
55 127.0.0.1
 Problèmes rencontrés
Le fichier access.log était vide
 Solution : générer du trafic avec curl
Le fichier nginx_ips.log contenait du texte incorrect
 Solution : le recréer avec awk
Erreur Python (lines not defined)
 Correction du script
Commande PowerShell non compatible sous Linux
 Remplacée par une commande équivalente
 Compétences développées
Expressions régulières (Regex)
Analyse de logs serveur
Scripting PowerShell et Python
Manipulation de fichiers Linux
Debugging

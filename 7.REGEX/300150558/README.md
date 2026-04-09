# TP Regex – Analyse des logs Nginx

Nom : Amira Sadouni  
ID : 300150558  

## Objectif

Ce travail consiste à analyser les logs du serveur web Nginx à l’aide d’expressions régulières (Regex) afin de générer automatiquement un rapport contenant :

- le nombre total de requêtes
- les erreurs HTTP (404, 500…)
- les adresses IP les plus actives
- les pages les plus demandées

Le projet utilise PowerShell, Python et l’automatisation avec cron.

---

## Structure du projet

7.REGEX/300150558/

analyse_nginx.ps1  
analyse_nginx.py  
README.md  

---

## Étapes réalisées

1. Connexion à la machine virtuelle avec SSH.
2. Création du dossier de travail pour le TP Regex.
3. Vérification du fichier log Nginx :

/var/log/nginx/access.log

4. Création des deux scripts :
- analyse_nginx.ps1 (PowerShell)
- analyse_nginx.py (Python)

5. Exécution des scripts pour générer les rapports.
6. Automatisation de l’exécution avec cron.

---

## Fonctionnement des scripts

Script PowerShell :

- lit le fichier access.log
- utilise Regex pour extraire les informations
- identifie les codes HTTP
- compte les erreurs
- détecte les IP les plus actives
- génère un rapport texte.

Script Python :

- utilise le module re
- analyse les logs Nginx
- compte les occurrences
- génère un rapport similaire au script PowerShell.

---

## Résultats obtenus

- scripts PowerShell et Python fonctionnels
- génération automatique de rapports
- utilisation des expressions régulières pour analyser les logs
- automatisation avec cron
- intégration du projet avec Git et GitHub

---

## Conclusion

Ce TP m’a permis de comprendre l’utilisation des expressions régulières, d’analyser des logs systèmes et d’automatiser des tâches sous Linux. Il m’a également permis d’utiliser PowerShell et Python dans un même projet et de gérer un projet avec Git et GitHub.

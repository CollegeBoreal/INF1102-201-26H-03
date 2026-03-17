# Script de gestion Linux (Batch)

## Objectif
Mettre en place un script automatisé permettant de sauvegarder des données, tester la connectivité réseau, créer un utilisateur temporaire, générer un fichier journal et planifier une exécution automatique.

## Environnement
Système Linux (type Ubuntu Server), accès administrateur (sudo), terminal et service cron actif.
<img width="961" height="388" alt="5_partie1" src="https://github.com/user-attachments/assets/1555c416-33ce-427e-bcec-bfe36b41a32a" />


## Description du projet
Le projet repose sur un script Bash exécutant plusieurs tâches essentielles :
- Vérification de la connectivité réseau
- Sauvegarde des fichiers de l’entreprise
- Création d’un utilisateur temporaire si inexistant
- Compression des données sauvegardées
- Génération d’un fichier log pour le suivi des opérations

## Exécution
Le script peut être exécuté manuellement pour des tests, puis automatisé via une tâche planifiée (cron) pour une exécution quotidienne.
<img width="940" height="621" alt="5_partie4" src="https://github.com/user-attachments/assets/348ad8e3-6d34-4284-bd8c-576ce83a67a4" />


## Vérification
Après exécution, il est possible de vérifier :
- La présence des fichiers sauvegardés et des archives
- La création de l’utilisateur temporaire
- Le contenu du fichier log pour suivre le déroulement
- Le bon fonctionnement du service cron et l’historique des exécutions
<img width="883" height="341" alt="5_partie5" src="https://github.com/user-attachments/assets/2420b1dc-dd46-4cac-bc36-08c616fd447f" />

## Résultat attendu
Une solution automatisée fiable permettant d’assurer la sauvegarde, la supervision et la traçabilité des opérations système dans un environnement Linux.
<img width="942" height="807" alt="5_partie6" src="https://github.com/user-attachments/assets/f8bb3bf5-e8ab-4158-82ec-34807622ae12" />

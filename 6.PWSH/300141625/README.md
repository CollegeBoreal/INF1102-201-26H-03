# TP DevOps PowerShell – Ubuntu 22.04

**Auteur** : Fatou Dione  
**ID** : 300141625  
**Date** : 17 mars 2026  

## Objectifs
- Installer PowerShell sur Ubuntu 22.04.
- Créer un script de vérification système (CPU, mémoire, disque, SSH).
- Générer des rapports texte et JSON.
- Automatiser une tâche DevOps.

## Installation de PowerShell
Les commandes exécutées :

```bash
sudo apt update
sudo apt install -y wget apt-transport-https software-properties-common
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
Vérification de la version installée :

bash
pwsh --version
(images/1.png)
Capture 1 : affichage de pwsh --version.

Script devops_batch.ps1
Le script se trouve dans /devops-batch/devops_batch.ps1. Il effectue :

Informations générales (date, utilisateur, machine)

Top 5 processus par CPU

Top 5 processus par mémoire (en Mo)

Espace disque avec df -h

Test de connectivité SSH sur 127.0.0.1

Génération de rapport.txt et rapport.json

Pour l’exécuter :

bash
chmod +x /devops-batch/devops_batch.ps1
/devops-batch/devops_batch.ps1
Les captures ci-dessous montrent l’exécution du script :

https://images/2.png
Capture 2 : début de l’exécution avec les top processus.

https://images/3.png
Capture 3 : fin de l’exécution avec la confirmation de génération des rapports.

Résultats obtenus
Rapport texte (rapport.txt)
Le contenu du rapport texte est visible ici :

https://images/4.png
Capture 4 : affichage de rapport.txt.

Rapport JSON (rapport.json)
Le rapport JSON structuré :

https://images/5.png
Capture 5 : début du fichier JSON.

https://images/6.png
Capture 6 : suite et fin du fichier JSON.

On y retrouve toutes les informations collectées : date, utilisateur, machine, top CPU, top mémoire, espace disque et test SSH réussi.

Conclusion
Ce TP a permis de maîtriser PowerShell sous Linux et d’automatiser des tâches d’administration système. Tous les objectifs sont atteints, avec la production de rapports exploitables en texte et JSON.


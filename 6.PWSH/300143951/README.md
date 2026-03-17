# Batch DevOps PowerShell (Linux)

## Objectif
Mettre en place un script PowerShell sous Linux permettant de superviser l’état du système (CPU, mémoire, disque), tester la connectivité SSH et générer des rapports automatisés.

## Environnement
- Ubuntu 22.04 (Jammy)
- PowerShell (pwsh)
- Accès sudo

## Étapes réalisées
- Installation de PowerShell via le dépôt Microsoft
- Création du dossier de travail `/devops-batch`
- Création du script `devops_batch.ps1`
- Exécution du script avec PowerShell
- Génération des fichiers `rapport.txt` et `rapport.json`

## Vérifications
- Analyse CPU et mémoire
- Vérification de l’espace disque
- Test de connectivité SSH
- Génération des rapports

## Captures d’écran

### Installation de PowerShell

<img width="952" height="867" alt="install_powershell" src="https://github.com/user-attachments/assets/471eb911-fdf4-4f17-9ea0-c438762b1942" />

### Exécution du script

<img width="1387" height="803" alt="script operationnel" src="https://github.com/user-attachments/assets/f4fda199-aa7d-4fdc-948f-3945bc8b8795" />

### Structure des fichiers

<img width="607" height="137" alt="les fichiers existent" src="https://github.com/user-attachments/assets/ce33b193-9c35-4ce2-a7af-d33915c670b0" />

## Résultat
Le script fonctionne correctement et permet d’automatiser la collecte d’informations système ainsi que la génération de rapports, conformément aux objectifs du laboratoire DevOps.

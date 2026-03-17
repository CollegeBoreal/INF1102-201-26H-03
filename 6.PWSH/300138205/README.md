# Laboratoire — Créer un batch DevOps PowerShell
---
## 👤 Étudiant

- Identifiant : **300138205**
- Nom: Taylor
- Cours : Programmation système
-Durée : 90 à 120 minutes
-Environnement : Ubuntu 22.04 (Jammy)
# -Shell : PowerShell (pwsh)
---
# 🎯 Objectifs

À la fin de ce laboratoire, l’étudiant sera capable de :

- Créer un script batch PowerShell pour Linux.

- Vérifier l’état du système (CPU, mémoire, disque).

- Vérifier la connectivité réseau (SSH).

- Générer un rapport texte et JSON.

- Automatiser des tâches administratives et DevOps.

- Comprendre le pipeline PowerShell orienté objets.

# 🔹 Partie 1 — Préparation de l’environnement
nous avons installer le powershell dans la VM300138205

<img width="522" height="169" alt="image" src="https://github.com/user-attachments/assets/6ccc96a4-047a-4a44-82ec-1094f7e715fd" />




Créons le dossier du TP :
```bash
sudo mkdir /devops-batch
```
<img width="545" height="106" alt="image" src="https://github.com/user-attachments/assets/5f9507ce-3d0d-4edd-9878-dc7d51f3e130" />

🔹 Partie 2 — Créer le script principal

Créons le fichier devops_batch.ps1 :
```bash
sudo nano /devops-batch/devops_batch.ps1
```
<img width="994" height="169" alt="image" src="https://github.com/user-attachments/assets/6b6d655d-196d-4ed6-ac2b-472e77ad59ee" />



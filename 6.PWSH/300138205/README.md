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
<img width="1058" height="702" alt="image" src="https://github.com/user-attachments/assets/863ef253-0003-433e-8f72-f8be40a97750" />

🔹 Partie 4 — Exécutons le batch

Exécuter le script :
```bash
sudo pwsh /devops-batch/devops_batch.ps1
```
<img width="983" height="783" alt="image" src="https://github.com/user-attachments/assets/dc62d1e1-0321-4ce9-9bc4-74e6e1423334" />

----
# 🥠 Avantages de PowerShell sous Linux

✈️Automatisation multi-plateforme: Fonctionne sur Windows, Linux et macOS.

🫀Pipeline orienté objets :Permet filtrage (Where-Object), sélection (Select-Object) et export JSON ou CSV facilement.

🥑 Intégration avec API et services :Automatisation DevOps avec Moodle API, Azure, AWS, etc.

🐤 Gestion de systèmes complexe: Accès aux processus, services, utilisateurs, SSH, disque, réseau.

⛹️Scripts robustes et maintenables: Variables typées, fonctions, modules → scripts DevOps plus fiables.

🚑Interopérabilité avec Windows: Adaptation facile des scripts Windows vers Linux sans tout réécrire.

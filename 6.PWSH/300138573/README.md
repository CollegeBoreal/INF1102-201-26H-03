# Lab 6 – Script DevOps PowerShell

## 👤 Étudiante
- Nom : Nour Miri  
- Numéro : 300138573  

---

## 🎯 Objectif
Créer un script PowerShell permettant de générer automatiquement un rapport DevOps avec des informations système.

---

## ⚙️ Description du script

Le script `devops_batch.ps1` permet de :

- Afficher la date, l’utilisateur et la machine
- Afficher le top 5 des processus par CPU
- Afficher le top 5 des processus par mémoire
- Vérifier l’espace disque (`df -h`)
- Tester la connexion SSH
- Générer deux fichiers :
  - `/devops-batch/rapport.txt`
  - `/devops-batch/rapport.json`

---

## 🔧 Problèmes rencontrés et solutions

### ❌ Dossier /devops-batch introuvable
✔ Solution :
```bash
sudo mkdir -p /devops-batch
sudo chown $USER:$USER /devops-batch

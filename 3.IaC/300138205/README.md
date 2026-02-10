# Infrastructure as Code (IaC) – Exercices OpenTofu & Proxmox

## 👤 Étudiant

- Identifiant : **300138205**
- Nom: Taylor
- Cours : Programmation système 
- Thème : **Infrastructure as Code (IaC)**


* terraform.tfvars

```lua
pm_vm_name      = "vm300138205"   
pm_ipconfig0    = "ip=10.7.237.196/23,gw=10.7.237.1"
pm_nameserver   = "10.7.237.3"    
pm_url          = "https://10.7.237.16:8006/api2/json"
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "4fa24fc3-bd8c-4916-ba6e-09a8aecc3b00"
sshkeys = [
  file("~/.ssh/taylor.pub"),
  file("~/.ssh/b300098957@ramena.pub")
]
```

# Infrastructure as Code (IaC)
# 📌 Introduction

Traditionnellement, l’administration système reposait sur des actions manuelles : installations à la main, configurations via interface graphique, documentation incomplète et environnements difficiles à reproduire.
Résultat classique :

👉 L’Infrastructure as Code (IaC) apporte une solution moderne à ces problèmes.

# 🧩 Définition

L’Infrastructure as Code (IaC) est une approche qui consiste à décrire, déployer et gérer une infrastructure informatique à l’aide de code plutôt que par des manipulations manuelles.

## ⚙️ Rôle de l’IaC

L’IaC se situe entre le système et les applications :

elle ne programme pas le noyau

elle pilote l’infrastructure via des API, services système, hyperviseurs ou clouds

elle transforme l’infrastructure en programme

## Déploiement

Commandes utilisées :

```text
tofu init
tofu plan
tofu apply

```



<img width="1917" height="635" alt="image" src="https://github.com/user-attachments/assets/d7f395e0-632d-42c7-8200-a2d64ab0cf24" />


## 🔍 Vérification

Connexion à la VM via SSH :

```powershell

ssh -i ~/.ssh/taylor.pk `
  -o StrictHostKeyChecking=no `
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty `
  ubuntu@10.7.237.196

```
ou
```powershell
ssh -i C:\Users\Utilisateur\.ssh\taylor.pk ubuntu@10.7.237.196

```
<img width="774" height="377" alt="image" src="https://github.com/user-attachments/assets/94e0bca1-7bd5-4999-8709-72de7aee70b1" />

<img width="1521" height="450" alt="image" src="https://github.com/user-attachments/assets/1010ab0c-2a14-448e-a4d9-b9fec33bbc7e" />


## Accès web

Depuis un navigateur, saisir l’adresse IP de la VM étant dans le reseau:

http://10.7.237.196

<img width="1568" height="639" alt="Capture d’écran 2026-02-03 184650" src="https://github.com/user-attachments/assets/1d729d3a-f722-4dbe-8071-e1af54f3cad5" />


## site web personnalisé

<img width="1919" height="801" alt="Capture d’écran 2026-02-03 190219" src="https://github.com/user-attachments/assets/810f0b45-e86e-49e8-9daa-3f0be9223022" />













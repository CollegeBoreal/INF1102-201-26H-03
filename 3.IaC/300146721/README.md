# 🏗️ TP "Infrastructure as Code (IaC)" – OpenTofu & Proxmox

## 👤 Étudiant
- ID Boréal : "300146721" (Smail)

---

## 1) Introduction
Traditionnellement, l'administration des systèmes se faisait manuellement :
- installation à la main
- configurations faites "à la souris"
- documentation incomplète
- environnements difficiles à reproduire

👉 Problème majeur : "Ça marche sur ce serveur, mais pas sur l'autre."

Solution moderne : **Infrastructure as Code (IaC)**  
L'IaC consiste à décrire, déployer et gérer une infrastructure informatique à l'aide de "code" plutôt que par des actions manuelles.

---

## 2) Définition
**Infrastructure as Code (IaC)** est une approche de "programmation système" qui permet de gérer des ressources (serveurs, réseaux, services, utilisateurs, stockage) à l’aide de fichiers de configuration versionnés et exécutables automatiquement.

---

## 3) Où se situe l'IaC dans la pile ?
### Position (stack)
Applications  
──────────────  
Services (Web, DB, DNS, AD, Containers)  
──────────────  
Infrastructure as Code (IaC)  
──────────────  
Shell / API OS / Hyperviseur / Cloud  
──────────────  
Noyau (Linux / Windows)  
──────────────  
Matériel  

👉 L'IaC :
- ne programme pas le noyau ("kernel")
- programme le système et son infrastructure
- agit via des API, des services système et des hyperviseurs

---

## 4) Pourquoi utiliser l'IaC ?
### Problèmes sans IaC
- erreurs humaines
- incohérences entre serveurs
- déploiements lents
- documentation non fiable

### Avantages de l'IaC
- Reproductibilité : même infrastructure partout (dev / test / prod)
- Automatisation : déploiement sans intervention manuelle
- Versionnement : Git = historique + restauration
- Fiabilité : moins d'erreurs humaines
- Rapidité : déploiement en minutes
- Auditabilité : tout est traçable ("who did what?")

---

## 5) IaC vs scripts système classiques
### Scripts (bash / PowerShell) = impératif
Exemple :
```bash
apt update
```
```bash
apt install nginx
```
```bash
systemctl start nginx
```
## 6) Approches de l'IaC
###6.1 Déclaratif ("voici l'état voulu")

Terraform / OpenTofu

CloudFormation

YAML Kubernetes
✔ recommandé ✔ reproductible ✔ idempotent

### 6.2 Impératif ("fais ceci, puis cela")

scripts shell

Ansible (mixte)
✔ flexible ✖ plus complexe à maintenir

##7) Ce qu'on peut gérer avec l'IaC

Machines virtuelles (VM)

Réseaux (VLAN, ponts, pare-feu)

Stockage

Utilisateurs et permissions

Services (web, base de données, DNS)

Conteneurs

Infrastructure cloud

Plateformes (Proxmox, VMware)

👉 L'infrastructure devient un "programme".

##8) Outils IaC courants
Outils d'orchestration

Terraform / OpenTofu

CloudFormation

Pulumi

Outils de configuration

Ansible

Chef ("Cuisinier")

Puppet ("Fantoche")

Plateformes ciblées

Proxmox

AWS / Azure / GCP

Kubernetes

##9) Exemple simple (conceptuel)

Objectif : créer automatiquement une VM Linux avec un serveur web.

Étapes :

définir la VM (CPU/RAM)

créer le réseau

installer le service web

exposer le port (80)

👉 Une seule commande : tofu apply

##10) Bonnes pratiques

Infrastructure versionnée (Git)

Pas de modification manuelle en production

Séparation dev / test / prod

Variables et secrets sécurisés

Documentation = code ("docs as code")

##11) IaC et DevOps

L'IaC est un pilier du DevOps :

CI/CD

déploiement continu

évolutivité

résilience / SRE

👉 Sans IaC, le DevOps n'est pas viable à grande échelle.

#🧪 Partie TP (OpenTofu + Proxmox)
##12) Structure du projet

###Dans le dossier "3.IaC/300146721" :

provider.tf

main.tf

variables.tf

terraform.tfvars (ne pas versionner)

README.md

##13) provider.tf (code)
```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.0"
    }
  }
}

provider "proxmox" {
  pm_api_url           = var.pm_url
  pm_api_token_id      = var.pm_token_id
  pm_api_token_secret  = var.pm_token_secret
  pm_tls_insecure      = true
}
```
##main.tf (code)
```hcl
resource "proxmox_vm_qemu" "vm1" {
  name        = var.pm_vm_name
  target_node = "labinfo"
  clone       = "ubuntu-jammy-template"
  full_clone  = false

  cores   = 2
  sockets = 1
  memory  = 2048

  scsihw = "virtio-scsi-pci"

  disk {
    size    = "10G"
    type    = "scsi"
    storage = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  os_type = "cloud-init"

  ipconfig0  = var.pm_ipconfig0
  nameserver = var.pm_nameserver

  ciuser  = "ubuntu"
  sshkeys = <<EOF
${file("~/.ssh/id_ed25519.pub")}
${file("~/.ssh/cle_publique_du_prof.pub")}
EOF
}
```
##15) variables.tf (code)
```hcl
variable "pm_vm_name" { type = string }
variable "pm_ipconfig0" { type = string }
variable "pm_nameserver" { type = string }
variable "pm_url" { type = string }
variable "pm_token_id" { type = string }

variable "pm_token_secret" {
  type      = string
  sensitive = true
}
```
##16) terraform.tfvars (exemple) 
```hcl
pm_vm_name      = "vm300146721"
pm_ipconfig0    = "ip=10.7.237.211/23,gw=10.7.237.1"
pm_nameserver   = "10.7.237.3"
pm_url          = "https://10.7.237.13:8006/api2/json"
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "********-****-****-****-************"
```
##18) Résultat (preuves)
VM créée : "vm300146721" (ID = 106)

IP : "10.7.237.211"

Connexion SSH : OK

## SSH (connexion)
```bash
ssh ubuntu@10.7.237.211
```
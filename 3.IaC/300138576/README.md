# Infrastructure as Code (IaC) – TP

## 👤 Informations

* **Nom** : Hajar Jabre 
* **ID Boréal** : 300138576
* **Cours** : INF1102 – Programmation système
* **Sujet** : Infrastructure as Code avec OpenTofu

---

## 1. Introduction

L’administration traditionnelle des systèmes se fait souvent manuellement, ce qui entraîne des erreurs et des incohérences.
L’Infrastructure as Code (IaC) permet d’automatiser la gestion des infrastructures avec du code.

---

## 2. Objectif du TP

* Comprendre l’IaC
* Utiliser OpenTofu
* Automatiser une tâche
* Utiliser Git pour versionner

---

 ## Structure du projet
 
🆔/ 300138576

├── provider.tf

├── main.tf

├── variables.tf

├── terraform.tfvars   (non versionné)

└── README.md
 
## 3. Installation et vérification

###  Commande :

```bash
tofu version
```

<img width="625" height="64" alt="1" src="https://github.com/user-attachments/assets/794ffa08-4729-49fa-a61f-7a05c24687f0" />

###  Résultat attendu :

* Version affichée : OpenTofu v1.11.4

---

##  4. Création du projet

### Commandes :

```bash
mkdir 300138576
cd 300138576
nano provider.tf, main.tf, variables.tf, terraform.tfvars -ItemType File
```

### Résultat attendu :

* Les fichiers sont créés dans le dossier

<img width="613" height="196" alt="2" src="https://github.com/user-attachments/assets/a70bbda1-3971-471a-bcfe-f8fbe704071c" />

---

## 5. Configuration OpenTofu

### nano provider.tf

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
  pm_api_url      = var.pm_url
  pm_api_token_id = var.pm_token_id
  pm_api_token_secret = var.pm_token_secret
  pm_tls_insecure = true
}
```

###  nano `main.tf` :

```hcl
resource "proxmox_vm_qemu" "vm1" {
  name        = var.pm_vm_name
  target_node = "labinfo"
  clone       = "ubuntu-jammy-template"

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

  ipconfig0 = var.pm_ipconfig0
  nameserver = var.pm_nameserver

  ciuser  = "ubuntu"
  sshkeys = <<EOF
   ${file("~/.ssh/ma_cle.pub")}
   ${file("~/.ssh/cle_publique_du_prof.pub")}
  EOF
}
```

## nano variables.tf

```hcl
variable "pm_vm_name" {
  type = string
}

variable "pm_ipconfig0" {
  type = string
}

variable "pm_nameserver" {
  type = string
}

variable "pm_url" {
  type = string
}

variable "pm_token_id" {
  type = string
}

variable "pm_token_secret" {
  type      = string
  sensitive = true
}
```

## 6. Initialisation

### Commande :

```bash
tofu init
```

### Résultat attendu :

* Message : *OpenTofu has been successfully initialized*

<img width="620" height="242" alt="3" src="https://github.com/user-attachments/assets/1ed775ac-d845-4034-b946-6bfa1981dcb7" />


---

## 7. Planification

### Commande :

```bash
tofu plan
```

###  Résultat attendu :

Affichage des ressources à créer

<img width="686" height="455" alt="4" src="https://github.com/user-attachments/assets/ed11854f-2911-4dbf-a8f4-88b63c113e10" />

  

## 8. Test local (preuve de fonctionnement)

### 🔹 Commande :

```bash
tofu apply
```
<img width="614" height="486" alt="5" src="https://github.com/user-attachments/assets/10592ea4-83e9-4235-bb5d-e32ba7fc98be" />

---

## 9. Git et envoi sur GitHub

### Commandes :

```bash
git add .
git commit -m "TP IaC"
git pull origin main --rebase
git push
```

## 10. Résultat final

* OpenTofu fonctionne ✔
* Projet créé ✔
* Git fonctionnel ✔
* Problème réseau identifié ✔

---

## 11. Conclusion

L’IaC permet d’automatiser la gestion des infrastructures de manière fiable et reproductible.
Même en présence d’un problème réseau, il est possible d’analyser et comprendre les erreurs.

---

##  12. Remarque finale

Ce TP démontre :

* la compréhension de l’IaC
* l’utilisation d’un outil professionnel
* la capacité à résoudre un problème technique

---

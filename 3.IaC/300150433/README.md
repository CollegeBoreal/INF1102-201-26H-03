# Infrastructure as Code (IaC) – OpenTofu & Proxmox

## 👤 Étudiant
- Nom : Djellouli Zakaria  
- Identifiant Boréal : 300150433  
- Thème : Infrastructure as Code (IaC)
- web : http://10.7.237.217:80


## 📌 Objectif du laboratoire
L’objectif de ce laboratoire est de mettre en pratique le concept d’**Infrastructure as Code (IaC)** en utilisant **OpenTofu** avec **Proxmox VE 7** afin de déployer automatiquement une **machine virtuelle Linux** via une configuration déclarative.  

Ce travail permet de :  
- Comprendre la différence entre configuration manuelle et IaC  
- Décrire une infrastructure sous forme de code  
- Automatiser la création d’une VM  
- Utiliser un provider OpenTofu réel (Proxmox)  
- Déployer un service web accessible depuis un navigateur  

## 🧠 Concepts abordés
- Infrastructure as Code (IaC)  
- Approche déclarative  
- Providers OpenTofu  
- Virtualisation avec Proxmox VE  
- Cloud-Init  
- Installation automatisée de services (NGINX)  
- Gestion des variables et des secrets  
- Automatisation et reproductibilité  
- Vérification fonctionnelle via navigateur  

## 🛠️ Outils utilisés
- OpenTofu (compatible Terraform)  
- Proxmox VE 7  
- Provider Telmate Proxmox  
- Git & GitHub  
- SSH  
- Ubuntu Server (Cloud Image)  
- NGINX (serveur web)  

## 📁 Structure du projet
```

300150433/
├── provider.tf
├── main.tf
├── variables.tf
├── terraform.tfvars   
├── README.md
└── images/
    └── .gitkeep


````

### Contenu des fichiers

#### 1️⃣ `provider.tf`
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
````

#### 2️⃣ `main.tf` (VM Cloud-Init)

```hcl
resource "proxmox_vm_qemu" "vm1" {
  name        = var.pm_vm_name
  target_node = "labinfo"
  clone       = "ubuntu-jammy-template"
  full_clone  = false

  cores   = 2
  sockets = 1
  memory  = 2048
  scsihw  = "virtio-scsi-pci"

  disk {
    size    = "10G"
    type    = "scsi"
    storage = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  os_type   = "cloud-init"
  ipconfig0 = var.pm_ipconfig0
  nameserver = var.pm_nameserver

  ciuser  = "ubuntu"
  sshkeys = <<EOF
   ${file("~/.ssh/ma_cle.pub")}
   ${file("~/.ssh/cle_publique_du_prof.pub")}
  EOF
}
```

#### 3️⃣ `variables.tf`

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

#### 4️⃣ `terraform.tfvars` 

```hcl
pm_vm_name      = "vm300150433"
pm_ipconfig0    = "ip=10.7.237.xxx/23,gw=10.7.237.1"
pm_nameserver   = "10.7.237.3"
pm_url          = "https://10.7.237.xx:8006/api2/json"
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "4fa24fc3-bd8c-4916-ba6e-09xxxxxxx3b00"
```

## 🚀 Déploiement

### 1. Initialisation

```bash
tofu init
tofu plan
tofu apply
```

* Tapez `yes` pour appliquer.

### 2. Vérification web

* Depuis un navigateur, accéder à :

```
http://10.7.237.217:80
```
<img width="1239" height="681" alt="Capture d’écran 2026-02-10 182440" src="https://github.com/user-attachments/assets/3cb46b82-70c8-46ef-9970-6644ee4ce6ae" />
---

## 🌐 Test et personnalisation du serveur web NGINX

Une fois la machine virtuelle déployée automatiquement à l’aide d’OpenTofu et Proxmox, un serveur web NGINX a été utilisé afin de valider le bon fonctionnement de l’infrastructure.

### Étapes effectuées

1. Connexion à la machine virtuelle via SSH.
2. Accès au fichier HTML par défaut de NGINX :
```
/var/www/html/index.nginx-debian.html
````
3. Ouverture et modification du fichier avec l’éditeur nano :
```bash
sudo nano /var/www/html/index.nginx-debian.html
````
4. Suppression du contenu existant et ajout d’une interface web personnalisée.
5. Sauvegarde du fichier et fermeture de l’éditeur.
6. Redémarrage du service NGINX pour appliquer les changements :

   ```bash
   sudo systemctl restart nginx
   ```

## ✅ Résultats attendus

* VM Ubuntu automatiquement déployée
* Infrastructure reproductible et déclarative
* Aucune configuration manuelle sur Proxmox
* Déploiement rapide et fiable
* Infrastructure entièrement décrite par du code


```

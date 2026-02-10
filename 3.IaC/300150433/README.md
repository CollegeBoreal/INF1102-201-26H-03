---



```markdown

\# Infrastructure as Code (IaC) – OpenTofu \& Proxmox



\## 👤 Étudiant

\- Nom : Djellouli Zakaria  

\- Identifiant Boréal : 300150433  

\- Thème : Infrastructure as Code (IaC)



\## 📌 Objectif du laboratoire

L’objectif de ce laboratoire est de mettre en pratique le concept d’\*\*Infrastructure as Code (IaC)\*\* en utilisant \*\*OpenTofu\*\* avec \*\*Proxmox VE 7\*\* afin de déployer automatiquement une \*\*machine virtuelle Linux\*\* via une configuration déclarative.  



Ce travail permet de :  

\- Comprendre la différence entre configuration manuelle et IaC  

\- Décrire une infrastructure sous forme de code  

\- Automatiser la création d’une VM  

\- Utiliser un provider OpenTofu réel (Proxmox)  

\- Déployer un service web accessible depuis un navigateur  



\## 🧠 Concepts abordés

\- Infrastructure as Code (IaC)  

\- Approche déclarative  

\- Providers OpenTofu  

\- Virtualisation avec Proxmox VE  

\- Cloud-Init  

\- Installation automatisée de services (NGINX)  

\- Gestion des variables et des secrets  

\- Automatisation et reproductibilité  

\- Vérification fonctionnelle via navigateur  



\## 🛠️ Outils utilisés

\- OpenTofu (compatible Terraform)  

\- Proxmox VE 7  

\- Provider Telmate Proxmox  

\- Git \& GitHub  

\- SSH  

\- Ubuntu Server (Cloud Image)  

\- NGINX (serveur web)  



\## 📁 Structure du projet

```



300150433/

├── provider.tf

├── main.tf

├── variables.tf

├── terraform.tfvars   (non versionné, secrets)

└── README.md





````



\### Contenu des fichiers



\#### 1️⃣ `provider.tf`

```hcl

terraform {

&nbsp; required\_providers {

&nbsp;   proxmox = {

&nbsp;     source  = "telmate/proxmox"

&nbsp;     version = ">= 2.9.0"

&nbsp;   }

&nbsp; }

}



provider "proxmox" {

&nbsp; pm\_api\_url      = var.pm\_url

&nbsp; pm\_api\_token\_id = var.pm\_token\_id

&nbsp; pm\_api\_token\_secret = var.pm\_token\_secret

&nbsp; pm\_tls\_insecure = true

}

````



\#### 2️⃣ `main.tf` (VM Cloud-Init)



```hcl

resource "proxmox\_vm\_qemu" "vm1" {

&nbsp; name        = var.pm\_vm\_name

&nbsp; target\_node = "labinfo"

&nbsp; clone       = "ubuntu-jammy-template"

&nbsp; full\_clone  = false



&nbsp; cores   = 2

&nbsp; sockets = 1

&nbsp; memory  = 2048

&nbsp; scsihw  = "virtio-scsi-pci"



&nbsp; disk {

&nbsp;   size    = "10G"

&nbsp;   type    = "scsi"

&nbsp;   storage = "local-lvm"

&nbsp; }



&nbsp; network {

&nbsp;   model  = "virtio"

&nbsp;   bridge = "vmbr0"

&nbsp; }



&nbsp; os\_type   = "cloud-init"

&nbsp; ipconfig0 = var.pm\_ipconfig0

&nbsp; nameserver = var.pm\_nameserver



&nbsp; ciuser  = "ubuntu"

&nbsp; sshkeys = <<EOF

&nbsp;  ${file("~/.ssh/ma\_cle.pub")}

&nbsp;  ${file("~/.ssh/cle\_publique\_du\_prof.pub")}

&nbsp; EOF

}

```



\#### 3️⃣ `variables.tf`



```hcl

variable "pm\_vm\_name" {

&nbsp; type = string

}



variable "pm\_ipconfig0" {

&nbsp; type = string

}



variable "pm\_nameserver" {

&nbsp; type = string

}



variable "pm\_url" {

&nbsp; type = string

}



variable "pm\_token\_id" {

&nbsp; type = string

}



variable "pm\_token\_secret" {

&nbsp; type      = string

&nbsp; sensitive = true

}

```



\#### 4️⃣ `terraform.tfvars` (\*\*ne pas versionner\*\*)



```hcl

pm\_vm\_name      = "vm300150433"

pm\_ipconfig0    = "ip=10.7.237.xxx/23,gw=10.7.237.1"

pm\_nameserver   = "10.7.237.3"

pm\_url          = "https://10.7.237.xx:8006/api2/json"

pm\_token\_id     = "tofu@pve!opentofu"

pm\_token\_secret = "4fa24fc3-bd8c-4916-ba6e-09xxxxxxx3b00"

```



\## 🚀 Déploiement



\### 1. Initialisation



```bash

tofu init

tofu plan

tofu apply

```



\* Tapez `yes` pour appliquer.



\### 2. Connexion à la VM



\* Depuis un navigateur, accéder à :



```

http://10.7.237.217:80

```







\## ✅ Résultats attendus



\* VM Ubuntu automatiquement déployée

\* Infrastructure reproductible et déclarative

\* Aucune configuration manuelle sur Proxmox

\* Déploiement rapide et fiable

\* Infrastructure entièrement décrite par du code



\## 📚 Références



\* Clé publique du professeur : `~/.ssh/cle\_publique\_du\_prof.pub`

\* Documentation OpenTofu : \[https://opentofu.io](https://opentofu.io)

\* Provider Proxmox : \[https://registry.opentofu.org/telmate/proxmox](https://registry.opentofu.org/telmate/proxmox)



```



---




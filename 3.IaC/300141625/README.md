\# Infrastructure as Code (IaC) – Exercices OpenTofu \& Proxmox



👤 \*\*Étudiante\*\*  

Nom : Fatou Dione  

Identifiant Boréal : 300141625  

Cours : Programmation système / DevOps  

Thème : Infrastructure as Code (IaC)



\## 📌 Objectif du laboratoire



L’objectif de ce laboratoire est de mettre en pratique le concept d’Infrastructure as Code (IaC) en utilisant OpenTofu avec Proxmox VE 7 afin de déployer automatiquement une machine virtuelle Linux à l’aide d’une configuration déclarative.



Ce laboratoire permet de :

\- Comprendre la différence entre une configuration manuelle et l’IaC

\- Décrire une infrastructure sous forme de code

\- Automatiser la création d’une machine virtuelle

\- Utiliser un provider OpenTofu réel (Proxmox)

\- Déployer un service web accessible via un navigateur



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



.

├── provider.tf

├── main.tf

├── variables.tf

├── terraform.tfvars   (non versionné)

└── README.md



\## 🔐 Contenu de terraform.tfvars



⚠️ Ce fichier contient des informations sensibles et n’est pas versionné sur GitHub.



pm\_vm\_name      = "vm300141625"  

pm\_ipconfig0    = "ip=10.7.237.201/23,gw=10.7.237.1"  

pm\_nameserver   = "10.7.237.3"  

pm\_url          = "https://10.7.237.16:8006/api2/json"  

pm\_token\_id     = "tofu@pve!opentofu"  

pm\_token\_secret = "\*\*\*\*\*\*\*\*-\*\*\*\*-\*\*\*\*-\*\*\*\*-\*\*\*\*\*\*\*\*\*\*\*\*"



\## 🚀 Déploiement



Commandes utilisées :



tofu init  

tofu plan  

tofu apply  



\## 🔐 Connexion à Proxmox



La gestion de l’infrastructure est réalisée via l’interface web de Proxmox VE.



\## 🔍 Vérification



Connexion à la VM via SSH :



ssh -i ~/.ssh/ma\_cle.pub \\

-o StrictHostKeyChecking=no \\

-o UserKnownHostsFile=/tmp/ssh\_known\_hosts\_empty \\

ubuntu@10.7.237.201



Accès au service web :



http://10.7.237.201:80



L’affichage de la page par défaut NGINX confirme le bon déploiement du serveur web.



\## ✅ Résultats obtenus



\- Machine virtuelle Ubuntu déployée automatiquement

\- Infrastructure reproductible

\- Aucune configuration manuelle sur Proxmox

\- Déploiement rapide et fiable

\- Infrastructure entièrement décrite par du code



\## 🔒 Sécurité



Le fichier terraform.tfvars est exclu du versionnement via le fichier .gitignore afin de protéger les informations sensibles.




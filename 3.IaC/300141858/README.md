\# Infrastructure as Code avec OpenTofu



\## Informations



\- \*\*Nom\*\* : Abdou Karim NIANG

\- \*\*ID\*\* : 300141858

\- \*\*Cours\*\* : INF1102-201-26H-03

\- \*\*VM\*\* : vm300141858

\- \*\*IP\*\* : 10.7.237.204



\---



\## Objectif



Ce laboratoire a pour objectif de déployer automatiquement une machine virtuelle Ubuntu dans Proxmox en utilisant OpenTofu, selon le principe de l’Infrastructure as Code (IaC).



\---



\## Étape 1 — Création du projet



Création du dossier `300141858` et des fichiers nécessaires :



\- `provider.tf`

\- `main.tf`

\- `variables.tf`

\- `terraform.tfvars`



\### Capture

!\[Création du projet](images/01-creation-dossier-fichiers.png)



\---



\## Étape 2 — Configuration SSH



Vérification des clés SSH :



\- `ma\_cle.pub`

\- `cle\_publique\_du\_prof.pub`



Vérification aussi de l’installation de OpenTofu avec `tofu version`.



\### Capture

!\[Clés SSH et OpenTofu](images/02-verification-cle-ssh-tofu.png)



\---



\## Étape 3 — Configuration Terraform



Configuration des fichiers nécessaires au déploiement de la VM sur Proxmox :



\- `provider.tf`

\- `main.tf`

\- `variables.tf`

\- `terraform.tfvars`



> Le secret n’est pas affiché dans le README pour des raisons de sécurité.



\### Capture

!\[Fichiers Terraform](images/03-contenu-fichiers-terraform.png)



\---



\## Étape 4 — Initialisation et planification



Commandes utilisées :



```bash

tofu init

tofu plan

🖥️ Étape 5 — VM dans Proxmox



La machine virtuelle est créée et en état running.



📸 Capture



🔗 Étape 6 — Connexion SSH



Connexion à la VM :



ssh -i \~/.ssh/ma\_cle.pk ubuntu@10.7.237.204

📸 Capture



🌐 Étape 7 — Installation NGINX

sudo apt update

sudo apt install nginx -y

📸 Capture



🌍 Étape 8 — Accès Web



Accès via navigateur :



http://10.7.237.204



📸 Capture



✅ Résultat

VM déployée automatiquement

SSH fonctionnel

Serveur web opérationnel

🧠 Conclusion



Ce projet m’a permis de comprendre concrètement le fonctionnement de l’Infrastructure as Code avec OpenTofu et Proxmox, ainsi que la gestion des machines virtuelles, du réseau et de la sécurité avec SSH.


# Infrastructure as Code (IaC) – Exercices OpenTofu & Proxmox

## 👤 Étudiant

- Identifiant Boréal : **300138205**
- Cours : Programmation système 
- Thème : **Infrastructure as Code (IaC)**


* terraform.tfvars

```lua
pm_vm_name      = "vm138205"   
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

Infrastructure as Code (IaC)
📌 Introduction

Traditionnellement, l’administration système reposait sur des actions manuelles : installations à la main, configurations via interface graphique, documentation incomplète et environnements difficiles à reproduire.
Résultat classique :

« Ça marche sur ce serveur, mais pas sur l’autre. »

👉 L’Infrastructure as Code (IaC) apporte une solution moderne à ces problèmes.

🧩 Définition

L’Infrastructure as Code (IaC) est une approche qui consiste à décrire, déployer et gérer une infrastructure informatique à l’aide de code plutôt que par des manipulations manuelles.

Les ressources (serveurs, réseaux, services, utilisateurs, stockage) sont définies dans des fichiers versionnés, reproductibles et automatisables.

⚙️ Rôle de l’IaC

L’IaC se situe entre le système et les applications :

elle ne programme pas le noyau

elle pilote l’infrastructure via des API, services système, hyperviseurs ou clouds

elle transforme l’infrastructure en programme

✅ Pourquoi utiliser l’IaC ?

Sans IaC

erreurs humaines

incohérences entre serveurs

déploiements lents

documentation peu fiable

Avec IaC

🔁 reproductibilité

🤖 automatisation

📦 versionnement (Git)

🛡️ fiabilité

⚡ rapidité

🔍 auditabilité

🆚 IaC vs scripts système

Scripts classiques (bash / PowerShell)

impératifs

dépendants de l’ordre d’exécution

difficiles à maintenir

IaC (déclaratif)

décrit l’état final souhaité

l’outil décide comment l’atteindre

idempotent et reproductible

🧠 Approches IaC

Déclarative : Terraform, OpenTofu, CloudFormation, Kubernetes YAML (recommandée)

Impérative / mixte : scripts shell, Ansible

🛠️ Ce que l’IaC permet de gérer

machines virtuelles

réseaux et sécurité

stockage

utilisateurs et permissions

services (web, base de données, DNS)

containers et clusters

infrastructures cloud ou locales






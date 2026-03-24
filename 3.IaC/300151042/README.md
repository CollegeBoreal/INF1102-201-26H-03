
# 📘 README – Introduction à l’Infrastructure as Code (IaC) avec OpenTofu et Proxmox

## 🧾 1. Objectif du projet

Ce travail vise à introduire le concept d’Infrastructure as Code (IaC) et à mettre en pratique le déploiement automatisé d’une machine virtuelle à l’aide d’OpenTofu et Proxmox.

Les objectifs principaux sont :

* Comprendre le concept d’IaC
* Différencier approche impérative et déclarative
* Déployer une infrastructure automatiquement
* Utiliser un outil moderne (OpenTofu)
* Intégrer l’infrastructure dans un workflow Git

---

## 🧠 2. Définition de l’IaC

L’Infrastructure as Code (IaC) est une approche qui consiste à gérer et déployer l’infrastructure informatique à l’aide de fichiers de configuration versionnés et exécutables automatiquement, au lieu de manipulations manuelles. 

---

## 🏗 3. Position de l’IaC dans le système

L’IaC se situe entre :

* les services (web, bases de données, réseaux)
* et les couches système (OS, hyperviseur, cloud)

Elle agit via des API et permet d’automatiser entièrement l’infrastructure. 

---

## ⚖️ 4. IaC vs Scripts traditionnels

| Critère          | Scripts Bash / PowerShell | IaC        |
| ---------------- | ------------------------- | ---------- |
| Type             | Impératif                 | Déclaratif |
| Logique          | Étapes à exécuter         | État final |
| Maintenance      | Difficile                 | Facile     |
| Reproductibilité | Faible                    | Élevée     |

👉 L’IaC décrit ce que l’on veut, et l’outil décide comment y arriver.

---

## 🚀 5. Avantages de l’IaC

* Reproductibilité des environnements
* Automatisation complète
* Versionnement avec Git
* Réduction des erreurs humaines
* Déploiement rapide
* Traçabilité (audit)

---

## 🧰 6. Outils utilisés

### Outils d’orchestration

* OpenTofu (équivalent Terraform)
* CloudFormation

### Outils de configuration

* Ansible
* Puppet

### Plateformes

* Proxmox
* Cloud (AWS, Azure, GCP)

---

## 🏗 7. Mise en place du projet

### 📁 Structure des fichiers

```id="t7k39x"
3.IaC/
│
├── provider.tf
├── main.tf
├── variables.tf
├── terraform.tfvars
└── README.md
```

---

## ⚙️ 8. Configuration du provider

```hcl id="z2l4fm"
provider "proxmox" {
  pm_api_url      = var.pm_url
  pm_api_token_id = var.pm_token_id
  pm_api_token_secret = var.pm_token_secret
  pm_tls_insecure = true
}
```

---

## 🖥 9. Déploiement d’une machine virtuelle

Le fichier `main.tf` permet de définir une VM :

* CPU et RAM
* stockage
* réseau
* utilisateur cloud-init
* clés SSH

👉 Une seule commande permet de créer toute l’infrastructure :

```bash id="p7d2xn"
tofu apply
```

---

## 🔐 10. Gestion des variables

Les variables sont définies dans :

```id="j4g8nb"
variables.tf
```

Les valeurs sensibles sont stockées dans :

```id="k9m2ds"
terraform.tfvars
```

⚠️ Ce fichier ne doit jamais être envoyé sur GitHub.

---

## ▶️ 11. Exécution du projet

```bash id="y3n8ka"
tofu init
tofu plan
tofu apply
```

---

## 🔄 12. Intégration avec Git

Le projet est versionné avec Git :

```bash id="f4p2la"
git add .
git commit -m "Ajout projet IaC"
git push
```

---

## 🧪 13. Test de la machine virtuelle

Connexion SSH :

```bash id="d8k3rt"
ssh -i ~/.ssh/ma_cle.pk ubuntu@IP_VM
```

---

## 🧠 14. Bonnes pratiques

* Ne jamais modifier l’infrastructure manuellement
* Versionner tout le code
* Séparer dev / test / production
* Protéger les secrets
* Documenter le projet

---

## 🔗 15. IaC et DevOps

L’IaC est un élément central du DevOps :

* Déploiement continu (CI/CD)
* Scalabilité
* Fiabilité
* Automatisation complète

---

## 🎯 16. Conclusion

Ce projet démontre que l’Infrastructure as Code permet de transformer l’administration système en un processus automatisé, reproductible et fiable.

Elle constitue aujourd’hui un pilier fondamental des environnements modernes et du DevOps. 

---

## 📚 17. Références

Documentation OpenTofu
Documentation Proxmox
Cours INF1102 – Infrastructure as Code

---

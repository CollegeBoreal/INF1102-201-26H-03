# 🏗️ Infrastructure as Code (IaC)

| #️⃣ | Groupes |
|-|-|
| 🥇 | [:tada: Participation](.scripts/Participation-group1.md) |
| 🥈 | [:tada: Participation](.scripts/Participation-group2.md) |
| 🥉 | [:tada: Participation](.scripts/Participation-group3.md) |


## 1. Introduction

Traditionnellement, l’administration des systèmes se faisait **manuellement** :

* installation à la main
* configurations faites “à la souris”
* documentation incomplète
* environnements difficiles à reproduire

👉 **Problème majeur** :

> *“Ça marche sur ce serveur, mais pas sur l’autre.”*

### Solution moderne : Infrastructure as Code (IaC)

L’**Infrastructure as Code** consiste à **décrire, déployer et gérer une infrastructure informatique à l’aide de code**, plutôt que par des actions manuelles.

---

## 2. Définition

> **Infrastructure as Code (IaC)** est une approche de programmation système qui permet de gérer les ressources informatiques (serveurs, réseaux, services, utilisateurs, stockage) à l’aide de fichiers de configuration versionnés et exécutables automatiquement.

---

## 3. Où se situe l’IaC en programmation système ?

### Position dans la pile système

```
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
```

👉 L’IaC :

* **ne programme pas le noyau**
* **programme le système et son infrastructure**
* agit via des **API, des services système et des hyperviseurs**

---

## 4. Pourquoi utiliser l’IaC ?

### Problèmes sans IaC

* erreurs humaines
* incohérences entre serveurs
* déploiements lents
* documentation non fiable

### Avantages de l’IaC

| Avantage         | Description                            |
| ---------------- | -------------------------------------- |
| Reproductibilité | Même infrastructure, partout           |
| Automatisation   | Déploiement sans intervention manuelle |
| Versionnement    | Git = historique, rollback             |
| Fiabilité        | Moins d’erreurs humaines               |
| Rapidité         | Déploiement en minutes                 |
| Auditabilité     | Tout est traçable                      |

---

## 5. IaC vs scripts système classiques

### Scripts système (bash / PowerShell)

```bash
apt update
apt install nginx
systemctl start nginx
```

* impératif
* dépend de l’ordre
* difficile à maintenir

### IaC (déclaratif)

```hcl
resource "nginx_server" {
  version = "1.24"
  port    = 80
}
```

* déclaratif
* décrit **l’état final**
* l’outil décide *comment* y arriver

---

## 6. Approches de l’IaC

### 6.1 IaC déclaratif

> *Voici l’état voulu*

* Terraform / OpenTofu
* CloudFormation
* Kubernetes YAML

✔ recommandé
✔ reproductible
✔ idempotent

---

### 6.2 IaC impératif

> *Fais ceci, puis cela*

* Scripts shell
* Ansible (mixte)

✔ flexible
✖ plus complexe à maintenir

---

## 7. Que peut-on gérer avec l’IaC ?

* Machines virtuelles
* Réseaux (VLAN, bridges, firewall)
* Stockage
* Utilisateurs et permissions
* Services (web, DB, DNS)
* Containers
* Clusters
* Infrastructure cloud
* Infrastructure locale (Proxmox, VMware)

👉 **L’infrastructure devient un programme.**

---

## 8. Outils IaC courants

### Outils d’orchestration

* **Terraform / OpenTofu**
* CloudFormation
* Pulumi

### Outils de configuration

* Ansible
* Puppet
* Chef

### Plateformes ciblées

* Proxmox
* AWS / Azure / GCP
* Kubernetes

---

## 9. Exemple simple (conceptuel)

### Objectif

> Créer automatiquement une VM Linux avec un serveur web.

### Étapes IaC

1. Définir la VM
2. Allouer CPU / RAM
3. Créer le réseau
4. Installer le service web
5. Exposer le port

👉 **Une seule commande** :

```bash
tofu apply
```

---

## 10. IaC et bonnes pratiques

* Infrastructure versionnée (Git)
* Pas de modification manuelle en production
* Séparation dev / test / prod
* Variables et secrets sécurisés
* Documentation = code

---

## 11. IaC et DevOps

L’IaC est un **pilier du DevOps** :

* CI/CD
* déploiement continu
* scalabilité
* résilience
* SRE

👉 Sans IaC, **le DevOps n’est pas viable à grande échelle**.

---

## 12. Place de l’IaC dans le cours

### Prérequis recommandés

* Linux / Windows
* Bash / PowerShell
* Réseaux
* Virtualisation

### Position idéale dans la session

1. Scripts système
2. Services et démons
3. Virtualisation
4. **Infrastructure as Code**
5. Orchestration avancée

---

## 13. Objectifs pédagogiques

À la fin de cette leçon, l’étudiant(e) sera capable de :

* expliquer le concept d’IaC
* distinguer script système et IaC
* décrire une infrastructure de manière déclarative
* utiliser un outil IaC de base
* automatiser un déploiement système

---

## 14. Phrase de conclusion

> **L’Infrastructure as Code transforme l’administration système en une discipline de programmation structurée, reproductible et industrielle.**

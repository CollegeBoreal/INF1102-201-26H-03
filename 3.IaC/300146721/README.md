# 🏗️ Infrastructure as Code (IaC)

## 1. Introduction
Traditionnellement, l'administration des systèmes se faisait manuellement :
- installation à la main
- configurations « à la souris »
- documentation incomplète
- environnements difficiles à reproduire

👉 Problème majeur :  
**« Ça marche sur ce serveur, mais pas sur l'autre. »**

✅ Solution moderne : **Infrastructure as Code (IaC)**  
L’IaC consiste à **décrire, déployer et gérer une infrastructure** à l’aide de **code**, plutôt que par des actions manuelles.

---

## 2. Définition
**Infrastructure as Code (IaC)** est une approche qui permet de gérer des ressources informatiques
(serveurs, réseaux, services, utilisateurs, stockage) via des **fichiers de configuration versionnés**
et exécutables automatiquement.

---

## 3. Où se situe l’IaC dans la pile système ?
Applications  
──────────────  
Services (Web, DB, DNS, AD, Containers)  
──────────────  
**Infrastructure as Code (IaC)**  
──────────────  
Shell / API OS / Hyperviseur / Cloud  
──────────────  
Noyau (Linux / Windows)  
──────────────  
Matériel  

👉 L’IaC :
- ne programme pas le noyau
- automatise l’infrastructure via API/services/hyperviseurs
- rend l’administration **reproductible** et **traçable**

---

## 4. Pourquoi utiliser l’IaC ?
### Problèmes sans IaC
- erreurs humaines
- incohérences entre serveurs
- déploiements lents
- documentation non fiable

### Avantages de l’IaC
| Avantage | Description |
|---|---|
| Reproductibilité | Même infrastructure partout |
| Automatisation | Déploiement sans intervention manuelle |
| Versionnement | Git = historique + restauration |
| Fiabilité | Moins d’erreurs humaines |
| Rapidité | Déploiement en minutes |
| Auditabilité | Tout est traçable |

---

## 5. IaC vs scripts système classiques
### Scripts (bash / PowerShell) = impératif
Exemple :
```bash
apt update
apt install nginx
systemctl start nginx
```
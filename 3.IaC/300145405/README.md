
## 👤 Étudiant

- Identifiant : **300145405**
- Nom: Sadou Barry
- Cours : Programmation système 
- Thème : **Infrastructure as Code (IaC)**

--------

<img width="1755" height="672" alt="image" src="https://github.com/user-attachments/assets/eff59c62-c273-41bc-9733-0a5e75331a3d" />

# Infrastructure as Code (IaC)
# 📌 Introduction

Traditionnellement, l’administration système reposait sur des actions manuelles : installations à la main, configurations via interface graphique, documentation incomplète et environnements difficiles à reproduire.
Résultat classique :

👉 L’Infrastructure as Code (IaC) apporte une solution moderne à ces problèmes.

# 🧩 Définition

L’Infrastructure as Code (IaC) est une approche qui consiste à décrire, déployer et gérer une infrastructure informatique à l’aide de code plutôt que par des manipulations manuelles.

## ⚙️ Rôle de l’IaC

L’IaC se situe entre le système et les applications :

elle ne programme pas le noyau

elle pilote l’infrastructure via des API, services système, hyperviseurs ou clouds

elle transforme l’infrastructure en programme

## Déploiement

Commandes utilisées :

```text
tofu init
tofu plan
tofu apply

```
## 🔍 Vérification

Connexion à la VM via SSH :

```powershell

ssh -i ~/.ssh/ma_cle.pk \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
  ubuntu@10.7.237.208
```
<img width="1095" height="529" alt="image" src="https://github.com/user-attachments/assets/7d10e071-d2b2-4ce2-b501-799236bf6e08" />

<img width="771" height="460" alt="image" src="https://github.com/user-attachments/assets/891699e8-b4c2-4c9a-b267-b5113a42dedf" />



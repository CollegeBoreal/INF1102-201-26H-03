# Participation IaC – Groupe 3

## Étudiant
- Identifiant Boréal : **300150385**

---

## Objectif

Ce travail de participation a pour but de démontrer la compréhension du concept
**Infrastructure as Code (IaC)** vu en cours.

L’IaC permet de gérer et déployer des infrastructures (machines virtuelles,
réseaux, services) à l’aide de fichiers de configuration plutôt que par des actions manuelles.

---

## Structure du projet

- `fournisseur.tf` : configuration du provider Proxmox
- `variables.tf` : définition des variables utilisées
- `main.tf` : description de la machine virtuelle à déployer
- `images/` : dossier réservé aux captures
- `README.md` : documentation du travail

---

## Exemple d’infrastructure

Ce projet décrit une VM Ubuntu clonée à partir du template :

- Nom : `ubuntu-jammy-template`
- Ressources : 2 CPU / 2 GB RAM
- Réseau : bridge `vmbr0`
- Adresse IP prévue : **10.7.237.215**

---

## Sécurité

Les secrets (API token) ne doivent pas être publiés sur GitHub.
Ils doivent être stockés dans un fichier local `terraform.tfvars`
non versionné.

---

## Conclusion

Ce travail montre comment OpenTofu permet d’automatiser la création
d’une infrastructure de manière reproductible et fiable, ce qui est
au cœur des pratiques DevOps modernes.

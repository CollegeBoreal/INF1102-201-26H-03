\# Infrastructure as Code – OpenTofu \& Proxmox



\## Étudiant

ID Boréal : 300150485



\## Objectif

Déployer automatiquement une machine virtuelle Ubuntu sur Proxmox

en utilisant Infrastructure as Code (OpenTofu) et Cloud-Init.



\## Technologies utilisées

\- Proxmox VE 7

\- OpenTofu

\- Provider Telmate Proxmox

\- Cloud-Init

\- SSH (authentification par clé)

\- Git / GitHub



\## Description

L’infrastructure est décrite de manière déclarative à l’aide d’OpenTofu.

La VM est clonée depuis un template Ubuntu Cloud-Init, configurée avec

une adresse IP statique et sécurisée par authentification SSH chiffrée.



\## Sécurité

\- Authentification SSH par clé (pas de mot de passe)

\- La clé publique est stockée dans `authorized\_keys`

\- La clé privée reste sur le poste client

\- Les secrets sont exclus du dépôt via `.gitignore`



\## Commandes principales

```bash

tofu init

tofu plan

tofu apply




Etudiante: Miri Nour
ID:300138573

# Infrastructure as Code – OpenTofu \& Proxmox


## Objectif

Déployer automatiquement une machine virtuelle Linux sur Proxmox VE 7

en utilisant Infrastructure as Code avec OpenTofu.



\## Outils utilisés

\- OpenTofu

\- Proxmox VE 7

\- Provider Telmate Proxmox

\- Cloud-init

\- SSH



\## Description

Ce projet utilise une approche déclarative pour définir et déployer

une VM Ubuntu à partir d’un template cloud-init sur Proxmox.



\## Commandes principales

```bash
tofu init
```


tofu plan

tofu apply



<img width="1482" height="496" alt="Iac 2" src="https://github.com/user-attachments/assets/ebdf4bc5-b7e2-4df1-8b59-727751da6ccf" />



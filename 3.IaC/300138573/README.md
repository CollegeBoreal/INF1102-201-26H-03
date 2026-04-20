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



## Commandes principales

```bash
tofu init
```
 
```bash
tofu plan
```

```bash
tofu apply
```

## Vérification

## Connexion à la VM via SSH :

```bash
ssh -i ~/.ssh/williamkey.pk `
  -o StrictHostKeyChecking=no `
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty `
  ubuntu@10.7.237.197
```
<img width="1482" height="762" alt="image0" src="https://github.com/user-attachments/assets/ca130ef7-8235-45b7-8766-2ab52731c693" />

<img width="1482" height="496" alt="Iac 2" src="https://github.com/user-attachments/assets/ebdf4bc5-b7e2-4df1-8b59-727751da6ccf" />

  
## Accès web
Depuis un navigateur, saisir l’adresse IP de la VM :

http://10.7.237.197:80

Deploiement du serveur web

<img width="1920" height="1020" alt="iac3" src="https://github.com/user-attachments/assets/589306d2-dd7e-4cdf-9e8e-638e8f25830e" />

## Résultats obtenus

VM Ubuntu déployée automatiquement

Infrastructure reproductible

Aucune configuration manuelle sur Proxmox

Déploiement rapide et fiable

Infrastructure entièrement décrite par du code





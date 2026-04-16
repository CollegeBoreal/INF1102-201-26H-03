# Lab Ansible – Déploiement automatisé Nginx
**INF1102 | Collège Boréal | Identifiant : 300143951**

---

## Objectif

Déployer automatiquement un serveur web Nginx avec une page HTML personnalisée en utilisant Ansible (IaC – Infrastructure as Code), depuis une machine physique Windows (via WSL/Ubuntu) vers une VM Hyper-V distante.

---

## Architecture

```
Machine physique (Windows 11 + WSL/Ubuntu)
        │
        │  SSH (clé ED25519)
        ▼
VM Proxmox – ubuntu@vm300143951 (10.7.237.206)
        └── nginx → /var/www/html/index.nginx-debian.html
```

---

## Structure du projet

```
300143951/
├── inventory.ini       # Hôtes cibles Ansible
├── playbook.yml        # Tâches de déploiement + handler
└── files/
    └── index.html      # Page web déployée
```

---

## Exécution

```bash
# 1. Tester la connectivité
ansible -i inventory.ini web -m ping

# 2. Lancer le déploiement
ansible-playbook -i inventory.ini playbook.yml

# 3. Vérifier
curl http://10.7.237.206
```
**Ansible Instalee**
<img width="1463" height="488" alt="ansible instalee" src="https://github.com/user-attachments/assets/b74a5efb-3d7d-455d-aa0b-e3123d39e378" />
**test ping reussi**
<img width="1557" height="582" alt="ping true" src="https://github.com/user-attachments/assets/53ffc828-9a3e-4e63-bf47-4be5c24f2896" />

---


## Résultats

**Premier déploiement** — `ok=5 | changed=2`
Le handler `restart nginx` s'est déclenché automatiquement suite à la copie du fichier HTML.


<img width="1689" height="954" alt="Screenshot 2026-04-08 075810" src="https://github.com/user-attachments/assets/e892c717-f393-453b-a8f9-cc5cd38fffe0" />


**Test d'idempotence** (2e exécution) — `ok=4 | changed=0`
Aucune modification appliquée : preuve que le playbook est idempotent.

<img width="1915" height="929" alt="Screenshot 2026-04-08 075913" src="https://github.com/user-attachments/assets/2292fb33-c636-4b92-8fb8-30195776436e" />



**Page déployée dans le navigateur**

<img width="1916" height="971" alt="mapopp" src="https://github.com/user-attachments/assets/453d9e23-eabb-4498-9b07-b400647e1071" />

---

## Difficultés rencontrées et résolues

**1. Environnement d'exécution — WSL vs PowerShell**
`sudo` et `apt` ne fonctionnent pas dans PowerShell. Il faut lancer Ubuntu via `wsl` avant d'exécuter les commandes Ansible.

**2. Clé SSH introuvable dans WSL**
La clé `id_ed25519` existait dans le profil Windows (`C:\Users\franc\.ssh\`) mais pas dans l'environnement Linux WSL. Solution : copie de la clé dans `~/.ssh/` de WSL.

```bash
cp /mnt/c/Users/franc/.ssh/id_ed25519 ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
```

**3. Permissions trop ouvertes sur la clé (erreur 0777)**
Les fichiers Windows montés dans WSL héritent de permissions `0777`, ce qu'OpenSSH refuse pour une clé privée. Le `chmod 600` corrige le problème.

**4. Chemin de clé incorrect dans `inventory.ini`**
La syntaxe Windows (`$HOME\.ssh\`) ne fonctionne pas dans WSL. Utiliser le chemin Linux absolu :
```ini
ansible_ssh_private_key_file=/home/franc/.ssh/id_ed25519
```

---

## Réponses aux questions théoriques

**Pourquoi Ansible est-il idempotent ?**
Ansible décrit un *état final* souhaité, pas une suite d'étapes. Si l'état est déjà atteint, aucune action n'est exécutée — comme prouvé par le `changed=0` au second lancement.

**Différence entre `present` et `started`**
`present` s'applique aux *paquets* (installé ou non) ; `started` s'applique aux *services* (en cours d'exécution ou non). Ce sont deux états dans deux domaines distincts.

**Pourquoi `become: yes` ?**
L'installation de paquets et la gestion de services nécessitent les droits root. `become: yes` équivaut à `sudo` pour toutes les tâches du play.

---

## Références

- [Documentation Ansible](https://docs.ansible.com)
- Leçon INF1102 — Gestion de configuration avec Ansible (IaC)

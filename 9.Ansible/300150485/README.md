# ⚙️ Déploiement Nginx avec Ansible — TP 9

> Projet étudiant réalisé dans le cadre du cours **INF1102** — Collège Boréal
> Dossier : `9.Ansible/300150485`

![Session](https://img.shields.io/badge/Session-Hiver%202026-blue?style=flat)
![Statut](https://img.shields.io/badge/Statut-Complété-success?style=flat)
![Ansible](https://img.shields.io/badge/Ansible-IaC-red?style=flat&logo=ansible)

---

## 📋 Description

Déploiement automatisé du serveur web **Nginx** avec une page HTML personnalisée via un **playbook Ansible**. Ce projet illustre le concept d'Infrastructure as Code (IaC) en décrivant l'état désiré du système de manière déclarative.

---

## 🎯 Objectifs

- Comprendre le concept d'Infrastructure as Code (IaC)
- Écrire un playbook Ansible en YAML
- Déployer automatiquement Nginx sur une VM Ubuntu
- Déployer une page HTML personnalisée
- Vérifier le déploiement avec `curl`

---

## 🛠️ Technologies utilisées

| Technologie | Rôle |
|-------------|------|
| ![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=flat&logo=ansible&logoColor=white) | Outil IaC de gestion de configuration |
| ![Nginx](https://img.shields.io/badge/Nginx-009639?style=flat&logo=nginx&logoColor=white) | Serveur web déployé |
| ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black) | Environnement cible (VM Ubuntu) |
| ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) | Versionnement du projet |
| YAML | Format du playbook Ansible |

---

## 📁 Structure du projet
9.Ansible/300150485/
├── 📄 inventory.ini       # Liste des machines cibles
├── 📄 playbook.yml        # Instructions de déploiement
├── 🖼️ images/            # Captures d'écran
└── 📂 files/
└── 🌐 index.html      # Page web déployée sur Nginx

---

## 📄 Explication des fichiers

### `inventory.ini`
Définit la machine cible (VM Ubuntu) et les paramètres de connexion SSH.

### `playbook.yml`
Contient 3 tâches principales :
1. **Installer Nginx** via `apt`
2. **Copier la page HTML** vers `/var/www/html/`
3. **Démarrer et activer** le service Nginx

---

## ▶️ Instructions d'exécution

### Prérequis
- Ansible installé (`ansible --version`)
- Accès SSH à la VM cible
- Fichier `inventory.ini` configuré avec la bonne IP

### Lancer le playbook

```bash
ansible-playbook -i inventory.ini playbook.yml
```

### Résultat attendu
PLAY [Installer et configurer nginx] ***
TASK [Gathering Facts] ok
TASK [Installer nginx] changed
TASK [Copier la page HTML] changed
TASK [Démarrer nginx] ok
PLAY RECAP ok=4 changed=2 failed=0

---

## 🧪 Vérification

```bash
curl http://10.7.237.218
```

Ou ouvrir dans le navigateur : `http://10.7.237.218`

---

## 💡 Concepts clés

| Concept | Explication |
|---------|-------------|
| **IaC** | On décrit l'infrastructure avec du code |
| **Déclaratif** | On dit *quoi* faire, pas *comment* |
| **Idempotence** | Exécuter 2 fois = même résultat |
| **Playbook** | Fichier YAML avec les tâches Ansible |
| **Inventory** | Liste des machines cibles |

---

## 👤 Auteur

**Nadir Fetis**
Étudiant en Techniques de l'informatique — Collège Boréal

---

## 🏫 Contexte académique

| Champ | Détail |
|-------|--------|
| Établissement | Collège Boréal |
| Cours | INF1102 — Introduction au DevOps |
| TP | 9 — Déploiement Nginx avec Ansible |
| Session | Hiver 2026 |
| Dossier | `9.Ansible/300150485` |

---

<div align="center">
  <sub>Fait avec ❤️ par Nadir Fetis — Collège Boréal</sub>
</div>

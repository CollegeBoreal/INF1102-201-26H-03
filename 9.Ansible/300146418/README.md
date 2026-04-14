# 🚀 TP Ansible – Déploiement automatique d’un serveur web

## 👩‍💻 Informations

* **Nom** : Ikram Sidhoum
* **ID** : 300146418
* **Cours** : INF1102 – Administration systèmes
* **Année** : 2026

---

## 🎯 Objectif du TP

Ce TP consiste à automatiser l’installation et la configuration d’un serveur web **NGINX** à l’aide d’**Ansible**.

L’objectif est de :

* Installer nginx automatiquement
* Déployer une page web HTML
* Démarrer le service nginx
* Vérifier l’accès au site via une adresse IP

---

## 🏗️ Structure du projet

```
300146418/
├── inventory.ini        # Fichier inventaire Ansible
├── playbook.yml         # Playbook principal
├── README.md            # Documentation
└── files/
    └── index.html       # Page web déployée
```

---

## ⚙️ Configuration

### 📄 inventory.ini

Contient la machine cible :

```
[web]
10.7.237.210 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_ed25519
```

---

### 📄 playbook.yml

Permet de :

* Installer nginx
* Copier la page HTML
* Démarrer le service

---

## 🚀 Exécution

### 🔹 Tester la connexion

```
ansible -i inventory.ini web -m ping
```

### 🔹 Lancer le playbook

```
ansible-playbook -i inventory.ini playbook.yml
```

---

## 🌐 Vérification

### 🔹 Terminal

```
curl http://10.7.237.210
```

### 🔹 Navigateur

```
http://10.7.237.210
```

👉 Le site doit afficher :
**“Déploiement réussi avec Ansible”**

---

## 📸 Captures d’écran

* Exécution du playbook
* Vérification avec curl
* Affichage du site web
* Contenu des fichiers

---

## 🧠 Concepts importants

### ✔ Idempotence

Ansible n’applique que les changements nécessaires.

### ✔ present vs started

* `present` → paquet installé
* `started` → service en marche

### ✔ become: yes

Permet d’exécuter avec les droits administrateur (sudo)

---

## ⚠️ Problèmes rencontrés

| Problème              | Solution                |
| --------------------- | ----------------------- |
| Permission denied SSH | Correction des clés SSH |
| Encodage HTML         | Ajout UTF-8             |
| Ansible unreachable   | Vérification inventory  |

---

## 🧠 Compétences développées

* Automatisation avec Ansible
* Administration Linux
* Gestion SSH
* Déploiement web
* Résolution de problèmes

---

## 🏁 Conclusion

Ce TP m’a permis de comprendre comment automatiser le déploiement d’un serveur web avec Ansible.

L’utilisation de playbooks facilite la gestion des infrastructures et permet de gagner du temps tout en réduisant les erreurs humaines.

---

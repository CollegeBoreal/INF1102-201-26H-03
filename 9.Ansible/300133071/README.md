# 🧪 TP : Déploiement automatisé Nginx

## 🎯 Objectif
Ce TP a pour but de créer un système automatisé qui :

- Installe **Nginx** sur un serveur distant
- Déploie une **page web personnalisée**
- Active le **service Nginx**

L’objectif est de se familiariser avec **Ansible** et le concept d’**Infrastructure as Code (IaC)**.

---

## 📋 Travail demandé

### 1️⃣ Créer la structure des fichiers
```bash
<ID>/
├── inventory.ini
├── playbook.yml
└── files/index.html
```

mkdir -p <ID>/files

le package ansible n’existe pas (ou plus) directement sur Chocolatey. Et même quand il existait, Ansible n’est pas conçu pour tourner nativement sur Windows.

Solution recommandée (la vraie bonne méthode)

Ansible fonctionne sur Linux. Sur Windows, tu dois passer par :

🔹option 1 — WSL (recommandé)
Installe WSL :

wsl --install

Redémarre ton PC
Ouvre Ubuntu (installé automatiquement)
Installe Ansible :

wsl

sudo apt update
sudo apt install ansible-core -y

commande utile
wsl -u root       # lancer WSL en mode root
wsl -l -v         # lister les distributions installées

🔹 Option 2 — Installer via Python (moins recommandé)

pip install ansible

⚠️ Mais :

Certaines fonctionnalités ne marcheront pas bien
Ce n’est pas officiellement supporté sur Windows

🔹Option 3 — Utiliser Docker

## ✅ Conclusion et apprentissages

### Conclusion
Le TP montre qu’**Ansible permet de déployer et configurer des services de manière automatisée et fiable**. Grâce à l’approche déclarative, l’état des serveurs peut être géré facilement, reproductible et sécurisé.

### Choses apprises
- Comprendre le fonctionnement d’**Ansible et son idempotence**
- Installer et utiliser Ansible sur **WSL ou Linux**
- Créer un **playbook pour installer Nginx**, déployer une page web et gérer les services
- Utiliser des **handlers** pour redémarrer automatiquement les services
- Gérer la **structure des fichiers** et l’**inventory**
- Notions importantes : `become: yes`, `present`, `started`, idempotence

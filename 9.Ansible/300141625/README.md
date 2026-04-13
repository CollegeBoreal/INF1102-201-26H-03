# Lab 9 – Déploiement automatisé Nginx avec Ansible

## 🎯 Objectif
Déployer automatiquement Nginx avec Ansible sur une VM Ubuntu.

## 📂 Structure
300141625/
├── inventory.ini
├── playbook.yml
└── files/
└── index.html
## 📸 Étapes effectuées sur Ubuntu

### 1. Version Ansible
![Version](images/0001.png)

### 2. Exécution du playbook
![Playbook](images/0002.png)

### 3. Vérification curl
![Curl](images/0003.png)

### 4. Structure des fichiers
![Structure](images/0004.png)

## ▶️ Exécution
```bash
ansible-playbook -i inventory.ini playbook.yml
```

## 🧪 Vérification
```bash
curl http://localhost
```

## ✅ Conclusion
Ansible permet de déployer automatiquement Nginx de façon déclarative et idempotente.

## 👤 Auteur
- Nom : Fatou
- ID Boréal : 300141625

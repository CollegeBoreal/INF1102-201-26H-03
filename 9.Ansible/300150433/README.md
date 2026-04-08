# 👨‍💻 Djellouli Zakaria  
**🆔 : 300150433**  
**📚 Cours : Programmation de systèmes**

---

# 🧪 TP : Déploiement automatisé Nginx avec Ansible

## 🎯 Objectif

Ce TP a pour but de créer un système automatisé permettant de :

- Installer Nginx sur un serveur distant  
- Déployer une page web personnalisée  
- Démarrer et activer le service Nginx  

L’objectif est de se familiariser avec Ansible et le concept d’Infrastructure as Code (IaC).

---

## 📁 Structure du projet


300150433/
├── files/
│ └── index.html
├── inventory.ini
└── playbook.yml


---

## ⚙️ Étapes réalisées

### 1️⃣ Création de la structure

```bash
mkdir -p files
touch inventory.ini playbook.yml
touch files/index.html
```

👉 Cette étape permet de créer les fichiers nécessaires au projet.
---
### 2️⃣ Création de la page web

Une page HTML personnalisée a été créée contenant :

Nom : Djellouli Zakaria
ID : 300150433
Cours : Programmation de systèmes
### 3️⃣ Configuration de l’inventory
[web]
10.7.237.217 ansible_user=ubuntu

👉 Permet de définir le serveur cible pour Ansible.
---
### 4️⃣ Création du playbook

Le playbook permet d’automatiser :

Installation de Nginx
Déploiement de la page web
Démarrage du service
- name: Déploiement Nginx
  hosts: web
  become: yes

  tasks:
    - name: Installer Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Copier la page web
      copy:
        src: files/index.html
        dest: /var/www/html/index.html

    - name: Démarrer Nginx
      service:
        name: nginx
        state: started
        enabled: yes
---
### 5️⃣ Exécution du playbook
ansible-playbook -i inventory.ini playbook.yml

👉 Cette commande exécute toutes les tâches automatiquement.
---
### 6️⃣ Vérification du résultat

Accès via navigateur :

http://10.7.237.217

👉 La page web personnalisée s’affiche correctement.

---
### 🧠 Concepts importants
✔️ Idempotence

Exécuter plusieurs fois le playbook ne change rien si tout est déjà configuré.

✔️ become: yes

Permet d’exécuter les tâches avec les privilèges administrateur.

✔️ state: present

Assure que le package est installé.

✔️ state: started

Assure que le service est en cours d’exécution.

---
### ✅ Conclusion

Ce TP montre que Ansible permet d’automatiser le déploiement de services de manière simple, rapide et fiable.

Grâce à l’approche IaC, les configurations sont reproductibles et faciles à maintenir.

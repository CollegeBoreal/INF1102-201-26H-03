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

```
300150433/
├── images
├── inventory.ini
├── playbook.yml
└── files/index.html
```

---

## ⚙️ Étapes réalisées

### 1️⃣ Création de la structure

```bash
mkdir -p files
touch inventory.ini playbook.yml
touch files/index.html
```

👉 Cette étape permet de créer les fichiers nécessaires au projet
<img width="704" height="43" alt="cree les fichiers " src="https://github.com/user-attachments/assets/1595762f-bf2e-4d06-b1b6-e3234d1e6e4f" />


---
### 2️⃣ Création de la page web

Une page HTML personnalisée a été créée 
<img width="764" height="24" alt="cree le site web" src="https://github.com/user-attachments/assets/0ff4763f-c308-429e-a85c-31ed8670095f" />

### 3️⃣ Configuration de l’inventory
<img width="366" height="109" alt="scripts inventory" src="https://github.com/user-attachments/assets/9331ffd0-5454-4a2e-8508-5219c419a032" />

👉 Permet de définir le serveur cible pour Ansible

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

👉 Cette commande exécute toutes les tâches automatiquement
<img width="1358" height="304" alt="lance le playbook" src="https://github.com/user-attachments/assets/2dc5dbc9-a8a1-4e08-84eb-0b22ff89211f" />

---
### 6️⃣ Vérification du résultat

Accès via navigateur :

http://10.7.237.217

👉 La page web personnalisée s’affiche correctement
<img width="1365" height="710" alt="site web" src="https://github.com/user-attachments/assets/86fe8aac-158e-4e3d-9ea8-2eb7f33eb93c" />


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

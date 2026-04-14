
# 👨‍💻 hamdi hicham
**🆔 : 300151042**  
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
300151042/
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



---
### 2️⃣ Création de la page web

Une page HTML personnalisée a été créée 


### 3️⃣ Configuration de l’inventory

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
<img width="843" height="263" alt="ansible 1" src="https://github.com/user-attachments/assets/f84515dd-f8c6-4728-a182-5aaf29fe29e4" />


---
### 6️⃣ Vérification du résultat

Accès via navigateur :

http://10.7.237.220

👉 La page web personnalisée s’affiche correctement

<img width="723" height="147" alt="ansible 2" src="https://github.com/user-attachments/assets/32ca0ab4-46ed-4c35-b31c-0168dcf0cd31" />


<img width="991" height="246" alt="ansible 3" src="https://github.com/user-attachments/assets/95fc6809-15c7-4510-9f32-e2ef0dd0fa53" />




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

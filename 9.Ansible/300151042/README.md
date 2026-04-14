# 🧪 TP Ansible – Déploiement automatisé de Nginx

<<<<<<< HEAD
## 👤 Informations
Nom : Ton Nom
Identifiant : 300151042
Cours : INF1102 – Automatisation / DevOps

---

## 🎯 Objectif

Ce projet permet de :
- Comprendre la gestion de configuration
- Utiliser Ansible (Infrastructure as Code)
- Automatiser le déploiement d’un serveur web
- Installer et configurer Nginx
- Déployer une page HTML

---

## 🧱 Structure du projet

300151042/
├── inventory.ini
├── playbook.yml
└── files/
    └── index.html

---

## ⚙️ Configuration

### Inventory (inventory.ini)

```ini
[web]
localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3

Playbook (playbook.yml)

- name: Installer et configurer nginx
=======
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
>>>>>>> 0a5bd8dca293245135dd5fc184cc77a1e919d23e
  hosts: web
  become: yes

  tasks:
<<<<<<< HEAD
    - name: Installer nginx
=======
    - name: Installer Nginx
>>>>>>> 0a5bd8dca293245135dd5fc184cc77a1e919d23e
      apt:
        name: nginx
        state: present
        update_cache: yes

<<<<<<< HEAD
    - name: Copier la page HTML
      copy:
        src: files/index.html
        dest: /var/www/html/index.nginx-debian.html

    - name: Démarrer nginx
=======
    - name: Copier la page web
      copy:
        src: files/index.html
        dest: /var/www/html/index.html

    - name: Démarrer Nginx
>>>>>>> 0a5bd8dca293245135dd5fc184cc77a1e919d23e
      service:
        name: nginx
        state: started
        enabled: yes
<<<<<<< HEAD

Page HTML (files/index.html)

<!DOCTYPE html>
<html>
<head>
    <title>300151042</title>
</head>
<body>
    <h1>Déploiement réussi avec Ansible</h1>
</body>
</html>

## ▶️ Exécution

Tester la connexion :
ansible web -i inventory.ini -m ping

Lancer le playbook :
ansible-playbook -i inventory.ini playbook.yml

🧪 Vérification

curl http://127.0.0.1

🧠 Concepts importants

Idempotence :
Ansible ne refait pas une action déjà effectuée correctement

present vs started :
present installe le package
started démarre le service

become yes :
permet d’exécuter les commandes avec privilèges administrateur

🚀 Conclusion

Ce TP démontre comment automatiser :

l’installation de logiciels
la configuration système
le déploiement d’une application web

Ansible permet une gestion simple, rapide et fiable des infrastructures

📌 Auteur

Travail réalisé par : 300151042
=======
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
>>>>>>> 0a5bd8dca293245135dd5fc184cc77a1e919d23e

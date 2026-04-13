# 🚀 TP : Déploiement automatisé avec Ansible

## 👤 Informations

- **Étudiant** : Medjkoune Belkacem  
- **ID Boréal** : 300150385  
- **Cours** : INF1102 – Programmation de systèmes  
- **Machine virtuelle** : 10.7.237.215  

---

## 📌 Objectif du projet

Ce projet consiste à utiliser **Ansible** pour automatiser le déploiement d’un serveur web.  
Le but est d’installer **Nginx**, de configurer automatiquement une page HTML et de rendre le site accessible via une adresse IP.

---

## ⚙️ Technologies utilisées

- 🐧 Linux (Ubuntu)
- ⚙️ Ansible
- 🌐 Nginx
- 💻 HTML / CSS / JavaScript

---

## 📁 Structure du projet
300150385/
│── playbook.yml
│── inventory.ini
│── README.md
│── files/
│ └── index.html
│── images/


---

## 🛠️ Étapes réalisées

### 🔹 1. Connexion à la machine virtuelle

ssh -i ~/.ssh/ma_cle.pk ubuntu@10.7.237.215

![wait](https://github.com/user-attachments/assets/d63a1e86-6a3a-4014-b321-083ca92a9eea)


🔹 2. Installation d’Ansible
sudo apt update
sudo apt install ansible-core -y

![wait](https://github.com/user-attachments/assets/ebd34d6c-d3ae-447f-859e-806ee42fb005)



🔹 3. Création du playbook

Le playbook permet :

Installer nginx
Copier la page HTML
Démarrer le service

🔹 4. Exécution du playbook
ansible-playbook -i inventory.ini playbook.yml

![wait](https://github.com/user-attachments/assets/cee0919c-7e1a-401f-a4d5-10ec46489a2a)


🔐 Connexion SSH

📂 Structure du projet

⚙️ Version Ansible

🚀 Exécution du playbook

🌐 Site web final

🌐 Résultat

Le serveur web est entièrement configuré automatiquement.
Le site est accessible via :

👉 http://10.7.237.215

![wait](https://github.com/user-attachments/assets/ebaa8a44-01b3-4821-ba0c-bd3e916cf8e1)


🧠 Conclusion

Ce projet m’a permis de :

Comprendre le fonctionnement d’Ansible
Automatiser le déploiement d’un serveur
Appliquer le concept d’Infrastructure as Code
✅ Résultat final

✔ Déploiement automatisé
✔ Serveur fonctionnel
✔ Site web interactif
✔ Projet structuré et reproductible


---


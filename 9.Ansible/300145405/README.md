# Laboratoire Gestion de configuration avec Ansible (IaC)
---
## 👤 Étudiant

- Identifiant : **300145405**
- Nom: Sadou barry
- Cours : Programmation système
- Environnement : Ubuntu 22.04 (Jammy)
- Shell : PowerShell (pwsh)

---
## 🎯 Objectifs

* Comprendre la **gestion de configuration**
* Expliquer le concept de **Infrastructure as Code (IaC)**
* Différencier **script impératif vs approche déclarative**
* Écrire un **playbook Ansible en YAML**
* Déployer automatiquement **Nginx + page HTML**
-------------------
##🧠 Concepts clés
🔧 Gestion de configuration
Maintenir un système dans un état :
•	Cohérent
•	Reproductible
•	Automatisé
--------------
☁️ Infrastructure as Code (IaC)
L’infrastructure est définie à l’aide de code plutôt que manuellement.
👉 Avantages :
•	Automatisation
•	Réduction des erreurs
•	Reproductibilité
--------------------

🧱 Structure du projet
ID/
├── inventory.ini
├── playbook.yml
└── files/
    └── index.html
-------------------------
📄 1. Inventory
Fichier : inventory.ini
[web]
IP_VM ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ma_cle.pk
👉 Remplacer IP_VM par l’adresse IP de votre machine virtuelle.
-----------------------------
⚙️ 2. Playbook Ansible
Fichier : playbook.yml
- name: Installer et configurer nginx
  hosts: web
  become: yes

  tasks:

    - name: Installer nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Copier la page HTML
      copy:
        src: files/index.html
        dest: /var/www/html/index.nginx-debian.html

    - name: Démarrer nginx
      service:
        name: nginx
        state: started
        enabled: yes
---------------------------------
🌐 3. Page HTML
Fichier : files/index.html
<!DOCTYPE html>
<html>
<head>
    <title>🆔 : 300145405</title>
</head>
<body>
    <h1>🚀 Déploiement réussi avec Ansible</h1>
</body>
</html>
------------------------------
✅ Vérification
Ouvrir dans un navigateur :
http://10.7.237.208
Ou utiliser :
curl http:// 10.7.237.208






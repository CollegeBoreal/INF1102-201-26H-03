🚀 Déploiement automatisé de Nginx avec Ansible
📌 Objectif du projet
Ce projet a pour but de mettre en pratique les concepts de gestion de configuration et d’Infrastructure as Code (IaC) en utilisant Ansible.
L’objectif est de créer un système automatisé capable de :
•	Installer Nginx
•	Déployer une page HTML personnalisée
•	Démarrer et activer le service web
________________________________________
🧠 Concepts clés
🔧 Gestion de configuration
Maintenir un système dans un état :
•	Cohérent
•	Reproductible
•	Automatisé
________________________________________
☁️ Infrastructure as Code (IaC)
L’infrastructure est définie à l’aide de code plutôt que manuellement.
👉 Avantages :
•	Automatisation
•	Réduction des erreurs
•	Reproductibilité
________________________________________
⚖️ Impératif vs Déclaratif
Approche	Description
Impératif	Décrit les étapes (ex: script bash)
Déclaratif	Décrit l’état final souhaité (Ansible)
👉 Ansible utilise une approche déclarative
________________________________________

🧱 Structure du projet
ID/
├── inventory.ini
├── playbook.yml
└── files/
    └── index.html
________________________________________
📄 1. Inventory
Fichier : inventory.ini
[web]
IP_VM ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ma_cle.pk
👉 Remplacer IP_VM par l’adresse IP de votre machine virtuelle.
________________________________________
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
________________________________________
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
________________________________________
▶️ Exécution du projet
Lancer le playbook avec la commande :
ansible-playbook -i inventory.ini playbook.yml
________________________________________
✅ Vérification
Ouvrir dans un navigateur :
http://10.7.237.208
Ou utiliser :
curl http:// 10.7.237.208






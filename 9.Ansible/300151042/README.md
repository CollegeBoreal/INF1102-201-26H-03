# 🧪 TP Ansible – Déploiement automatisé de Nginx

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

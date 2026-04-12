# ⚙️ Déploiement Nginx avec Ansible — TP 9

> Cours INF1102 — Collège Boréal | Dossier : `9.Ansible/300150485`

## 📋 Description
Déploiement automatisé de Nginx avec une page HTML personnalisée via un playbook Ansible.

## 📁 Structure
300150485/
├── inventory.ini
├── playbook.yml
└── files/
└── index.html 
## ▶️ Exécution
```bash
ansible-playbook -i inventory.ini playbook.yml
```

## 🧪 Vérification
```bash
curl http://10.7.237.218
```

## 👤 Auteur
**Nadir Fetis** — Collège Boréal

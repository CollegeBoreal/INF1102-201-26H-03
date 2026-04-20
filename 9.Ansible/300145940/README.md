# 🧪 LAB 9 — Déploiement NGINX avec Ansible

## 👩‍💻 Étudiante
Tasnim Marzougui  
INF1102 — Automatisation & DevOps  

---

## 🎯 Objectif du laboratoire

L’objectif de ce laboratoire est d’automatiser l’installation et la configuration d’un serveur web NGINX à l’aide d’Ansible, puis de déployer une page HTML personnalisée.

---

## ⚙️ Étapes réalisées

### 1. Création de l’inventaire

Fichier `inventory.ini` :

```ini
[web]
127.0.0.1 ansible_connection=local
2. Création du playbook

Fichier playbook.yml permettant de :

Installer nginx
Copier une page HTML vers /var/www/html/
Démarrer et activer le service nginx
3. Création de la page HTML

Une page HTML personnalisée a été créée dans :

files/index.html
4. Exécution du playbook

Commande utilisée :

ansible-playbook -i inventory.ini playbook.yml

Résultat :

ok = 4
changed = 1
failed = 0
unreachable = 0

Le playbook s’est exécuté avec succès.

5. Vérification

Commande :

curl http://127.0.0.1

Le résultat confirme que la page HTML est bien servie par nginx.

📸 Captures d’écran
🔹 Exécution du playbook

🔹 Vérification du serveur web

⚠️ Problème rencontré

Erreur rencontrée :

ERR_CONNECTION_REFUSED
Cause

Utilisation de 127.0.0.1 depuis le navigateur local au lieu de l’adresse IP de la machine virtuelle.

Solution

Utilisation de l’adresse IP de la VM :

http://10.7.237.209
✅ Conclusion

Ce laboratoire a permis de comprendre :

L’utilisation d’Ansible pour automatiser des tâches système
L’installation et la gestion du service nginx
Le déploiement d’une page web automatisé
La différence entre localhost et une machine distante

Le déploiement a été effectué avec succès et validé par des tests.

🚀 Lab réussi avec succès


---

# ✅ IMPORTANT (before push)

Make sure your repo contains:


9.Ansible/300145940/
├── inventory.ini
├── playbook.yml
├── files/
│ └── index.html
├── README.md
└── images/
├── 1.png

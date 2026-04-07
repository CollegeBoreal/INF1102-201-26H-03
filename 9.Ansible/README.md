# 🟢 Leçon : Gestion de configuration avec Ansible (IaC)

| #️⃣ | Participations | Vérifications |
|-|-|-| 
| 🥇 | [:tada: Participation](.scripts/Participation-group1.md) | [:checkered_flag: Vérification](.scripts/Check-group1.md) |
| 🥈 | [:tada: Participation](.scripts/Participation-group2.md) | [:checkered_flag: Vérification](.scripts/Check-group2.md) |
| 🥉 | [:tada: Participation](.scripts/Participation-group3.md) | [:checkered_flag: Vérification](.scripts/Check-group3.md) |


---

## 🎯 Objectifs

* Comprendre la **gestion de configuration**
* Expliquer le concept de **Infrastructure as Code (IaC)**
* Différencier **script impératif vs approche déclarative**
* Écrire un **playbook Ansible en YAML**
* Déployer automatiquement **Nginx + page HTML**

---

# 🧠 1. Qu’est-ce que la gestion de configuration ?

👉 La gestion de configuration consiste à :

> Maintenir un système dans un **état cohérent, reproductible et automatisé**

---

## 🔥 Exemple classique

### ❌ Méthode manuelle (script impératif)

```bash
apt update
apt install -y nginx
cp index.html /var/www/html/
systemctl start nginx
```

👉 Problèmes :

* Non reproductible facilement
* Risque d’erreurs
* Pas idempotent

---

## ✅ Avec Ansible

```yaml
name: nginx
state: present
```

👉 On décrit :

> **ce que l’on veut**, pas **comment le faire**

---

# ⚙️ 2. Ansible : c’est quoi exactement ?

👉 Ansible est un outil de :

> **Infrastructure as Code (IaC) orienté gestion de configuration**

---

## 🧩 Ce que ça signifie

- ✔ IaC → on décrit l’infrastructure avec du code
- ✔ Configuration → on agit **à l’intérieur des machines**

---

## 📌 Exemple d’actions

* Installer nginx
* Configurer un service
* Déployer des fichiers
* Gérer des utilisateurs

---

# ⚖️ 3. Ansible vs scripting classique

| Critère     | Bash / Python | Ansible    |
| ----------- | ------------- | ---------- |
| Type        | Impératif     | Déclaratif |
| Approche    | Étapes        | État final |
| Idempotence | ❌            | ✅         |
| Lisibilité  | Moyenne       | Élevée     |

---

## 🧠 À retenir

> 💡 **Ansible = scripting déclaratif pour l’administration système**

---

# ☁️ 4. Place d’Ansible dans le IaC

---

## 🔁 Pipeline typique

1. Provisioning → création des VM
2. Configuration → installation & setup

---

## ⚙️ Outils

| Étape         | Outil     |
| ------------- | --------- |
| Provisioning  | Terraform (tofu) |
| Configuration | Ansible  (puppet, chef) |

---

## 🎯 Phrase clé

> **Terraform construit l’infrastructure, Ansible la configure**

---

# 🧾 5. Introduction à YAML

---

## 📘 Qu’est-ce que YAML ?

Format lisible utilisé par :

* Ansible
* Docker
* Kubernetes

---

## ⚠️ Règle essentielle

👉 **Indentation obligatoire (2 espaces)**
👉 **Pas de tabulations**

---

## 🧱 Structures

### 🔹 Clé / valeur

```yaml
name: nginx
state: present
```

---

### 🔹 Liste

```yaml
packages:
  - nginx
  - git
```

---

### 🔹 Dictionnaire

```yaml
user:
  name: ubuntu
  uid: 1000
```

---

## ❌ Erreur fréquente

```yaml
- name: Installer nginx
apt:
  name: nginx
```

---

## ✅ Correct

```yaml
- name: Installer nginx
  apt:
    name: nginx
```

---

# 🧱 6. Architecture Ansible

---

## 🖥️ Machine de contrôle

* Lance Ansible

## 💻 Machines cibles

* Reçoivent la configuration via SSH

---

# :b: Expérimentation

### 🎛️ Créer un fichier dans ce répertoire `(9.Ansible)`:

:checkered_flag: Finalement,

- [ ] Créer un répertoire avec :id: (votre identifiant boreal)
   - [ ] `mkdir ` :id:
- [ ] dans votre répertoire ajouter le fichier `README.md`
  - [ ] `nano `README.md
- [ ] envoyer vers le serveur `github.com`
  - [ ] `cd ..`
  - [ ] `git add `:id: 
  - [ ] `git commit -m "mon fichier ..."`
  - [ ] `git push`

- [ ] Se diriger vers le répertoire avec :id: (votre identifiant boreal)
   - [ ] `cd ` :id:

- [ ] Continuer les 🔄 Exercices 

### 🔄 Exercices

La structure de fichiers attendus:

```bash
🆔/
├── inventory.ini
├── playbook.yml
└── files/
    └── index.html
```

---

# 📄 8. Inventory

Dans le fichier `inventory.ini`

```ini
[web]
IP_VM ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ma_cle.pk
```

- [ ] Remplace `IP_VM` par l'adresse IP de ta VM

---

# 📜 9. Playbook complet

Dans le fichier `playbook.yml`

```yaml
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
```

---

# 🌐 10. Page HTML

Dans le fichier `files/index.html`

```html
<!DOCTYPE html>
<html>
<head>
    <title>🆔 : 300999999</title>
</head>
<body>
    <h1>🚀 Déploiement réussi avec Ansible</h1>
</body>
</html>
```

💡: Utilise le fichier HTML de ton choix

---

# ▶️ 11. Exécution

```bash
ansible-playbook -i inventory.ini playbook.yml
```

---

# 🧪 TP : Déploiement automatisé Nginx

---

## 🎯 Objectif

Créer un système automatisé qui :

* Installe nginx
* Déploie une page web
* Active le service

---

## 📋 Travail demandé

### 1️⃣ Créer la structure

```bash
mkdir -p 🆔/files
```

---

### 2️⃣ Compléter :

* `inventory.ini`
* `playbook.yml`
* `files/index.html`

---

## 🧠 Questions

1. Pourquoi Ansible est-il idempotent ?
2. Différence entre :

   * `present`
   * `started`
3. Pourquoi utiliser `become: yes` ?

---

# ⭐ Bonus

---

## 🔁 Handler

```yaml
handlers:
  - name: restart nginx
    service:
      name: nginx
      state: restarted
```

---

## 🔔 Notification

```yaml
notify: restart nginx
```

---

# 🧾 Livrables

```bash
🆔/
├── inventory.ini
├── playbook.yml
└── files/index.html
```

---

# 🧪 Vérification

```bash
curl http://IP_VM
```

---

# 🔥 Conclusion

- ✔ Ansible = **IaC orienté configuration**
- ✔ Déclaratif → plus simple et fiable
- ✔ YAML → essentiel à maîtriser
- ✔ Complémentaire à Terraform (Tofu)

---

# :books: References

Pour installer Ansible, tu peux utiliser un gestionnaire de paquets selon ton système.

🪟 **Sur Windows**, la méthode la plus simple est via **Chocolatey** :

```bash
choco install ansible
```

🍎 **Sur macOS**, tu peux utiliser **Homebrew** :

```bash
brew install ansible
```

🚀 Ces outils permettent d’installer Ansible rapidement, avec toutes ses dépendances, et facilitent aussi les mises à jour grâce à une simple commande du gestionnaire de paquets.


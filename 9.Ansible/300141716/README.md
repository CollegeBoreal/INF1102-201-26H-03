# 🚀 TP : Déploiement automatisé Nginx avec Ansible

## 👩‍🎓 Étudiante

* Nom : Nabila Oulad-Bouih
* ID : 300141716
* Cours : INF1102 — Programmation système

---

## 🎯 Objectif

Ce TP a pour but de créer un système automatisé avec Ansible qui :

* installe nginx
* déploie une page web personnalisée
* démarre automatiquement le service nginx

L’objectif est de comprendre le concept d’Infrastructure as Code (IaC) et l’automatisation des tâches.

---

## 📂 Structure du projet

```text
300141716/
├── inventory.ini
├── playbook.yml
├── files/
│   └── index.html
└── images/
```

---

## ⚙️ Configuration

### 📌 inventory.ini

```ini
[web]
localhost ansible_connection=local
```

---

### 📌 playbook.yml

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

### 📌 files/index.html

```html
<!DOCTYPE html>
<html>
<head>
    <title>300141716</title>
</head>
<body>
    <h1>🚀 Déploiement réussi avec Ansible</h1>
    <p>Nabila Oulad-Bouih</p>
    <p>INF1102 - Ansible</p>
</body>
</html>
```

---

## ▶️ Exécution du projet

### 🔹 Test de connexion avec Ansible

```bash
ansible -i inventory.ini web -m ping
```

### ✔ Résultat :

```text
localhost | SUCCESS => {
    "ping": "pong"
}
```

---

### 🔹 Exécution du playbook

```bash
ansible-playbook -i inventory.ini playbook.yml
```

### ✔ Résultat :

```text
PLAY [Installer et configurer nginx]

TASK [Installer nginx] → ok
TASK [Copier la page HTML] → changed
TASK [Démarrer nginx] → ok

PLAY RECAP :
localhost : ok=4 changed=1 failed=0
```

---

### 🔹 Vérification du résultat

```bash
curl http://localhost
```

### ✔ Résultat :

```html
<h1>🚀 Déploiement réussi avec Ansible</h1>
<p>Nabila Oulad-Bouih</p>
```

---

## 📸 Captures d’écran

### 🔹 Test ping

![Ping](images/ping.png)

---

### 🔹 Exécution du playbook

![Playbook](images/playbook.png)

---

### 🔹 Résultat final (curl)

![Curl](images/curl.png)

---

## 🧠 Concepts importants

* **Idempotence** : Ansible peut être exécuté plusieurs fois sans changer le résultat
* **become: yes** : permet d'exécuter les tâches avec les droits administrateur
* **state: present** : garantit que le package est installé
* **state: started** : garantit que le service est actif

---

## ✅ Conclusion

Ce TP montre comment Ansible permet de déployer et configurer un service automatiquement.

Grâce à l’automatisation :

* le déploiement est rapide
* les erreurs sont réduites
* le système est reproductible

---

## 📚 Ce que j’ai appris

* utiliser Ansible sur Linux
* créer un playbook
* déployer une application web automatiquement
* gérer un service Linux (nginx)
* structurer un projet d’automatisation

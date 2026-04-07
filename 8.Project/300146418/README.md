# 🚀 TP IaC – OpenTofu & Proxmox

## 👩‍💻 Informations

* **Nom** : Ikram Sidhoum
* **Identifiant Boréal** : 300146418
* **Cours** : INF1102 – Administration systèmes
* **Année** : 2026

---

## 🎯 Objectif du projet

Ce projet consiste à **déployer automatiquement une machine virtuelle Ubuntu** à l’aide d’une approche **Infrastructure as Code (IaC)**, puis à configurer un **serveur web NGINX** accessible via une adresse IP.

---

## 🏗️ Technologies utilisées

* OpenTofu (IaC)
* Proxmox VE
* Ubuntu Server
* NGINX
* SSH
* HTML / CSS

---

## ⚙️ Fonctionnement du projet

Le projet suit les étapes suivantes :

1. Création d’une VM Ubuntu avec OpenTofu
2. Configuration réseau (IP statique)
3. Connexion via SSH
4. Installation de NGINX
5. Déploiement d’un site web portfolio
6. Accès via navigateur

---

## 🌐 Accès au site

Le site web est accessible via :

```
http://10.7.237.210
```

---

## 📂 Structure du projet

```
300146418/
├── README.md
├── index.html
├── images/
├── scripts/
├── main.tf
```

---

## 💻 Déploiement

### 1. Initialisation

```bash
tofu init
```

### 2. Planification

```bash
tofu plan
```

### 3. Déploiement

```bash
tofu apply
```

---

## 🔧 Configuration serveur

### Installation NGINX

```bash
sudo apt update
sudo apt install nginx -y
```

### Vérification

```bash
sudo systemctl status nginx
```

---

## 🌍 Vérification du site

### Depuis la VM :

```bash
curl http://localhost
```

### Depuis navigateur :

```
http://10.7.237.210
```

---

## 📸 Captures d’écran

Les captures sont disponibles dans le dossier :

```
images/
```

Elles montrent :

* Déploiement OpenTofu
* Connexion SSH
* Installation NGINX
* Site web en ligne
* Vérification

---

## 🧠 Compétences développées

* Infrastructure as Code
* Virtualisation
* Administration Linux
* Déploiement Web
* Automatisation

---

## 📊 Résultat

✔ Machine virtuelle fonctionnelle
✔ Serveur web NGINX actif
✔ Site web accessible via IP
✔ Déploiement automatisé réussi

---

## 🏁 Conclusion

Ce projet démontre la capacité à :

* Automatiser une infrastructure complète
* Déployer un serveur web
* Appliquer une approche moderne DevOps
* Créer un site web fonctionnel

---

## 📌 Auteur

**Ikram Sidhoum**
Collège Boréal – INF1102
2026

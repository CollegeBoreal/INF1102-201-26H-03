# 🚀 Déploiement d’une Infrastructure as Code – VM Proxmox avec Nginx

## 📌 Présentation du projet

Ce projet démontre le déploiement d’une machine virtuelle en utilisant le concept **Infrastructure as Code (IaC)** avec **OpenTofu (alternative à Terraform)** sur un **serveur Proxmox**.
La machine virtuelle déployée est configurée avec **Ubuntu Linux** et héberge un **site web moderne via Nginx**.

---

## 🧱 Technologies utilisées

* OpenTofu (Terraform)
* Proxmox Virtual Environment
* Ubuntu Server
* Nginx
* SSH (Secure Shell)
* Git & GitHub

---

## ⚙️ Processus de déploiement

### 1. Configuration de l’infrastructure (OpenTofu)

Création du fichier `terraform.tfvars` contenant :

* Nom de la VM
* Configuration réseau (IP, passerelle, DNS)
* URL de l’API Proxmox
* Token d’authentification

```hcl
pm_vm_name      = "vm300145940"
pm_ipconfig0    = "ip=10.7.237.209/23,gw=10.7.237.1"
pm_nameserver   = "10.7.237.3"

pm_url          = "https://10.7.237.19:8006/api2/json"
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "********"
```

---

### 2. Déploiement de la machine virtuelle

Initialisation et exécution du déploiement :

```bash
tofu init
tofu plan
tofu apply
```

✅ Résultat : La machine virtuelle est créée automatiquement sur le serveur Proxmox.

---

### 3. Vérification du réseau

Test de connectivité :

```bash
ping 10.7.237.209
```

---

### 4. Connexion SSH

Connexion sécurisée à la VM :

```bash
ssh -i ~/.ssh/ma_cle.pk ubuntu@10.7.237.209
```

---

### 5. Installation et configuration de Nginx

Dans la machine virtuelle :

```bash
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
```

✅ Résultat : Le serveur web Nginx est actif.

---

### 6. Déploiement du site web

Remplacement de la page par défaut de Nginx :

```bash
sudo nano /var/www/html/index.html
```

Ajout d’un site web moderne (thème cuisine tunisienne).

---

### 7. Ajout d’une image personnalisée

Copie de l’image locale dans le projet :

```powershell
copy "C:\Users\user\OneDrive - Collège Boréal\Bureau\tasnim123.png" .
```

Puis envoi sur GitHub :

```bash
git add .
git commit -m "ajout image"
git push
```

---

## 🌐 Résultat final

Le site web est accessible via :

```
http://10.7.237.209
```

---

## 🖼️ Aperçu

![Aperçu du site](tasnim123.png)

---

## 🎯 Compétences acquises

* Compréhension du concept Infrastructure as Code (IaC)
* Déploiement automatisé avec OpenTofu
* Utilisation de l’API Proxmox
* Configuration d’un serveur Linux
* Installation et gestion d’un serveur web (Nginx)
* Connexion sécurisée avec SSH
* Gestion de projet avec Git et GitHub

---

## 👩‍💻 Auteur

**Tasnim Marzougui**
Étudiante en Techniques des systèmes informatiques
Collège Boréal

---

## ✨ Conclusion

Ce projet illustre un processus complet allant du déploiement d’infrastructure jusqu’à la mise en ligne d’un site web.
Il met en évidence l’importance de l’automatisation et des pratiques modernes DevOps pour gérer efficacement des systèmes informatiques.
#300145940

# Portfolio DevOps

**Étudiant:** Frank Kadji | **ID:** 300143951 | **VM:** vm300143951

---

## 🚀 Déploiement rapide


**Accès:** http://10.7.237.206


---

## ⚙️ Infrastructure as Code


**terraform.tfvars**
```hcl
pm_vm_name      = "vm300143951"
pm_ipconfig0    = "ip=10.7.237.206/13,gw=10.7.237.1"
pm_nameserver   = "10.7.237.3"
pm_url          = "https://10.7.237.28:8006/api2/json"
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "f728d095-1506-490f-81b1-ecdafdfb8ef9"
```




### Déploiement

```bash
tofu init
tofu plan
tofu apply
```

---



---

## 📁 Structure

```
300143951/
├── images/
├── provider.tf
├── main.tf
├── variables.tf
├── terraform.tfvars
├── index.html
└── README.md
```

## 📸 Résultats

### VM créée (Proxmox)
# <p align="center"><img src="images//machine cree.png" alt="Images" width="450"/></p>

---

### VM opérationnelle
![VM fonctionnelle](images/fonctionnelle.png)

---

### SSH fonctionnel
apres avoir utiliser la commande 
```
ssh -i ~/.ssh/id_ed25519 `
  -o StrictHostKeyChecking=no `
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty `
  ubuntu@10.7.237.206
```
pour connecter se connecter au server via ssh.

# <p align="center"><img src="images//ssh fonctionne.png" alt="Images" width="450"/></p>

---
### Nginx actif

```
# Connexion à la VM
ssh -i ~/.ssh/id_ed25519 ubuntu@10.7.237.206

# Installation Nginx
sudo apt update && sudo apt install nginx -y
```
# <p align="center"><img src="images//nginx actif.png" alt="Images" width="450"/></p>
---
### Portfolio déployé
```
# Modification du fichier
sudo nano /var/www/html/index.nginx-debian.html
# placer le code HTML du portfolio dans ce fichier, puis Ctrl+X, Y, Entrée

# Recharger Nginx
sudo systemctl reload nginx --pour redemarer le site
```
# <p align="center"><img src="images//nouvelle.png" alt="Images" width="450"/></p>


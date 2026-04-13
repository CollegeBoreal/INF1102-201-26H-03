# Lab 3 – Infrastructure as Code (IaC) avec OpenTofu

## 🎯 Objectif
Déployer automatiquement une VM Ubuntu sur Proxmox avec OpenTofu (Terraform).

## 📂 Structure
300141625/
├── images/
├── .gitignore
├── README.md
├── main.tf
├── provider.tf
└── variables.tf
## 📸 Captures d'écran

### 1. VM déployée — Page Nginx
![Nginx](images/image_2026-02-03_191323281.png)

### 2. VM dans Proxmox
![Proxmox](images/image_2026-02-03_191417004.png)

### 3. Configuration Cloud-Init
![Cloud-Init](images/image_2026-02-10_172841571.png)

## ▶️ Exécution
```bash
tofu init
tofu plan
tofu apply
```

## 🧪 Vérification
```bash
curl http://10.7.237.201
```

## ✅ Conclusion
OpenTofu permet de déployer automatiquement une infrastructure complète sur Proxmox de façon déclarative et reproductible.

## 👤 Auteur
- Nom : Fatou
- ID Boréal : 300141625

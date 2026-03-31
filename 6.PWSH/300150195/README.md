# 300150195 — Amel Zourane

## 📚 TP — Batch DevOps PowerShell
### Cours : INF1102-201-26H-03

## 🖥️ Informations de la VM

| Élément | Valeur |
|---------|--------|
| Étudiant | Amel Zourane |
| Numéro | 300150195 |
| Machine | vm300150195 |
| IP | 10.7.237.214 |
| OS | Ubuntu 22.04 (Jammy) |
| Shell | PowerShell 7.6.0 |

## 📋 Description

Script batch DevOps en PowerShell sur Ubuntu 22.04.  
Il vérifie l'état du système (CPU, mémoire, disque) et la connectivité SSH,  
puis génère automatiquement un rapport texte et JSON.

## 📸 Résultat — PowerShell 7.6.0

![PowerShell version](PWSH.png)

## 📊 Résultat — Rapport DevOps

![Rapport DevOps](SUDO.png)

## 📁 Structure du projet

​```
300150195/
│
├── devops_batch.ps1       # Script principal PowerShell
├── README.md              # Ce fichier
└── images/
    ├── pwsh_version.png   # Version PowerShell installée
    └── rapport_devops.png # Résultat du script
​```

## 🔍 Fonctionnalités

| Fonctionnalité | Détail |
|----------------|--------|
| 🖥️ CPU | Top 5 processus par utilisation CPU |
| 🧠 Mémoire | Top 5 processus par mémoire (WS) |
| 💾 Disque | Espace disponible avec `df -h` |
| 🔌 SSH | Test de connectivité vers `127.0.0.1` |
| 📄 Rapport TXT | `/devops-batch/rapport.txt` |
| 🗂️ Rapport JSON | `/devops-batch/rapport.json` |

## ▶️ Exécution

​```bash
sudo pwsh /devops-batch/devops_batch.ps1
​```

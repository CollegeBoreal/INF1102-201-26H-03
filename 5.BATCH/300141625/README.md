# Lab 5 – Script Bash d'automatisation sous Linux

## 🎯 Objectif
Programmer un script Batch sous Linux permettant de :
- Sauvegarder un dossier d'entreprise
- Créer un utilisateur temporaire
- Tester la connectivité réseau
- Générer un fichier journal (log)
- Planifier l'exécution automatique avec cron

## 📂 Structure
300141625/
├── entreprise/
│   └── script_gestion.sh
├── images/
└── README.md
## 📸 Étapes effectuées sur Ubuntu

### 1. Sauvegarde et backup
![Backup](images/1.png)

### 2. Utilisateur temporaire créé
![Utilisateur](images/2.png)

### 3. Fichier log généré
![Log](images/3.png)

### 4. Planification cron
![Cron](images/4.png)

### 5. Vérification cron actif
![Cron status](images/5.png)

## ▶️ Exécution
```bash
sudo chmod +x /entreprise/script_gestion.sh
sudo /entreprise/script_gestion.sh
```

## ⏰ Planification
```bash
sudo crontab -e
# Ajouter :
0 2 * * * /entreprise/script_gestion.sh
```

## ✅ Conclusion
Ce script automatise la sauvegarde, la gestion des utilisateurs et la journalisation sur un système Linux Ubuntu.

## 👤 Auteur
- Nom : Fatou
- ID Boréal : 300141625

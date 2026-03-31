# Awa

- Identifiant : **300144176**
- Nom: awa
- Cours : Programmation système 

Ce projet consiste à développer un script Batch (Bash) permettant d’automatiser plusieurs tâches administratives sous Linux :

📁 Sauvegarde des données d’une entreprise

👤 Création d’un utilisateur temporaire

🌐 Test de la connectivité réseau

📝 Génération d’un fichier de logs

⏰ Planification automatique avec cron

🔍 Vérification et diagnostic des exécutions

-----
## 🖥 Environnement requis

Distribution Linux (ex : Ubuntu Server)

Accès sudo

Terminal

Service cron actif

## 📁 Structure du projet

Création des dossiers nécessaires :
```bash
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```

Création des fichiers test :

```bash
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```



<img width="909" height="802" alt="capture1bash" src="https://github.com/user-attachments/assets/f7b8a14e-bd39-4e0e-a9ca-4d379fae4ec9" />




<img width="793" height="982" alt="capture2bash" src="https://github.com/user-attachments/assets/c9eca5bc-8c42-414e-82e5-cd54ed12d93a" />




<img width="1088" height="423" alt="capture3bash" src="https://github.com/user-attachments/assets/e9284fa4-3242-4995-ad97-ecde9d3a1f4e" />


<img width="880" height="946" alt="capture 6bash" src="https://github.com/user-attachments/assets/421f1fb0-c4fc-4110-b8b5-ff539ebab651" />





✔ Logs détaillés disponibles

✔ Exécution automatique quotidienne fonctionnelle

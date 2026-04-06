# Rapport – Automatisation Script Bash

**Numéro : 300150385**

---

## 🎯 Objectif

Ce travail consiste à créer un script permettant d’automatiser plusieurs tâches sous Linux :

* Sauvegarde de fichiers
* Test de connectivité réseau
* Création d’un rapport système
* Exécution d’un script PowerShell sous Linux

---

## 🖥️ Étape 1 – Installation de PowerShell

PowerShell a été installé dans la machine virtuelle Ubuntu afin de permettre l’exécution de scripts avancés.

**Commande utilisée :**

```
sudo snap install powershell --classic
```

📸 Capture :

![wait](https://github.com/user-attachments/assets/e1a236e7-3658-45b3-8d11-448283140e3e)


---

## 📁 Étape 2 – Création du dossier de travail

Un dossier a été créé pour stocker les fichiers du projet.

**Commande :**

```
sudo mkdir /devops-batch
```

📸 Capture :

![wait](https://github.com/user-attachments/assets/a8b64131-82c0-4162-a4c0-19683a833e89)


---

## 📝 Étape 3 – Création du script PowerShell

Un script a été créé pour générer un rapport contenant :

* Date et heure
* Nom de la machine
* Utilisateur
* Utilisation CPU et RAM
* Informations disque

📸 Capture :

![wait](https://github.com/user-attachments/assets/b92e3b80-e3ae-4c7a-b464-562bd4e3d2b0)


---

## ▶️ Étape 4 – Exécution du script

Le script a été exécuté avec PowerShell dans Linux.

**Commande :**

```
sudo pwsh /devops-batch/devops_batch.ps1
```

Résultat :

* Affichage des informations système
* Génération d’un rapport
* Analyse des performances CPU, RAM et disque

📸 Capture :

![wait](https://github.com/user-attachments/assets/1853374d-baf6-440b-bbb6-07678f46057b)


---

## ✅ Conclusion

Ce TP m’a permis de :

* Utiliser Linux pour automatiser des tâches
* Exécuter PowerShell dans un environnement Linux
* Créer un script structuré
* Générer un rapport système automatiquement

---




# 🧪 TP 6 — PowerShell DevOps (PWSH)

## 📌 Description

Ce projet consiste à développer un script **PowerShell sous Linux (Ubuntu 22.04)** permettant d’automatiser des tâches d’administration système dans un contexte DevOps.

Le script collecte des informations système, vérifie la connectivité réseau (SSH) et génère des rapports exploitables.

---

## 🎯 Objectifs

* Créer un script PowerShell sous Linux
* Vérifier l’état du système :

  * CPU
  * Mémoire
  * Disque
* Tester la connectivité SSH
* Générer des rapports :

  * Format texte (`.txt`)
  * Format JSON (`.json`)
* Comprendre le pipeline orienté objets de PowerShell

---

## ⚙️ Environnement

* **OS** : Ubuntu 22.04
* **Shell** : PowerShell (`pwsh`)
* **Langage** : PowerShell

---

## 📁 Structure du projet

```bash
/devops-batch/
├── devops_batch.ps1
├── rapport.txt
└── rapport.json
```

---

## 🚀 Installation

### 1. Mettre à jour le système

```bash
sudo apt update
```

### 2. Installer les dépendances

```bash
sudo apt install -y wget apt-transport-https software-properties-common netcat
```

### 3. Installer PowerShell

```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
```

---

## ▶️ Exécution du script

```bash
sudo pwsh /devops-batch/devops_batch.ps1
```

---

## 📊 Fonctionnalités du script

### 🔹 Informations système

* Date et heure
* Utilisateur courant
* Nom de la machine

### 🔹 Analyse CPU

* Top 5 processus utilisant le plus de CPU

### 🔹 Analyse mémoire

* Top 5 processus utilisant le plus de RAM

### 🔹 Analyse disque

* Utilisation des partitions (`df -h`)

### 🔹 Test SSH

* Vérification du port 22 (SSH)
* Affichage :

  * `SSH actif` si disponible
  * `SSH inactif` sinon

### 🔹 Génération de rapports

#### 📄 rapport.txt

* Rapport lisible pour l’utilisateur
* Contient toutes les informations collectées

#### 📦 rapport.json

* Données structurées
* Utilisable pour automatisation ou API

---

## 🧠 Concepts utilisés

* Pipeline PowerShell (`|`)
* Objets (`PSCustomObject`)
* Tri et filtrage :

  * `Sort-Object`
  * `Select-Object`
* Boucles :

  * `ForEach-Object`
* Export JSON :

  * `ConvertTo-Json`
* Commandes Linux intégrées :

  * `df`
  * `nc` (netcat)

---

## ⚠️ Problèmes rencontrés

### 🔸 Erreur SSH (Permission denied)

Lors du test SSH avec `ssh`, une erreur d’authentification apparaissait :

```
Permission denied (publickey)
```

### ✅ Solution

Utilisation d’un test du **port 22** avec `netcat` au lieu d’une connexion SSH directe :

```bash
nc -z -w 2 127.0.0.1 22
```

Cela permet de vérifier si le service SSH est actif sans nécessiter d’authentification.

---

## ✅ Résultat

Le script permet de :

* Automatiser la collecte d’informations système
* Générer des rapports exploitables
* Vérifier l’état du service SSH
* Utiliser PowerShell dans un environnement Linux

---

## 🏁 Conclusion

Ce TP démontre la puissance de PowerShell en environnement Linux pour :

* l’automatisation
* l’administration système
* les tâches DevOps

Il permet également de comprendre la différence entre Bash et PowerShell, notamment grâce à l’utilisation d’objets.

---

## 👨‍💻 Auteur

* Étudiant : **300145405**




<img width="339" height="73" alt="image" src="https://github.com/user-attachments/assets/3b308418-21bd-4708-9a1d-dcf8a0ed82a3" />

<img width="660" height="325" alt="image" src="https://github.com/user-attachments/assets/3cb74be2-b658-48db-aac4-641f530e570b" />

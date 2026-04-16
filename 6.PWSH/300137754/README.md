
# TP PowerShell

**Nom :** Beni Mundhu
**ID :** 300137754

---

## 🎯 Objectif

Ce projet consiste à créer un script PowerShell sous Linux permettant d’automatiser des tâches d’administration système et de générer des rapports.

---

## ⚙️ Étapes réalisées

### 🔹 1. Installation de PowerShell

```bash
sudo apt update
sudo apt install -y wget apt-transport-https software-properties-common

wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt update
sudo apt install -y powershell
```

---

### 🔹 2. Lancement de PowerShell

```bash
pwsh
```

<img width="789" height="154" alt="pwsh" src="https://github.com/user-attachments/assets/1338ce5c-d488-4d66-b578-5555dfc4236b" />

---

### 🔹 3. Création du dossier du projet

```bash
sudo mkdir /devops-batch
cd /devops-batch
```
<img width="726" height="52" alt="Capture d&#39;écran 2026-04-14 233125" src="https://github.com/user-attachments/assets/1b1a91e9-2a78-4da5-bba9-290a48c2bcbe" />

---

### 🔹 4. Création du script

```bash
sudo nano devops_batch.ps1
```
<img width="1090" height="530" alt="Capture d&#39;écran 2026-04-14 233322" src="https://github.com/user-attachments/assets/d9372d2a-a21f-41d7-8d97-505a80c5a382" />


Ajout du script PowerShell pour :

* Vérifier CPU
* Vérifier mémoire
* Vérifier disque
* Tester SSH
* Générer rapport TXT et JSON

---

### 🔹 5. Exécution du script

```bash
sudo pwsh devops_batch.ps1
```
<img width="1088" height="540" alt="Capture d&#39;écran 2026-04-14 233412" src="https://github.com/user-attachments/assets/910b2627-ccac-4986-ba04-79a0b99415c3" />

---

## 📸 Captures d’écran

### 🖥️ Lancement de PowerShell

<img width="789" height="154" alt="pwsh" src="https://github.com/user-attachments/assets/1338ce5c-d488-4d66-b578-5555dfc4236b" />


---

### ⚙️ Exécution du script

<img width="859" height="366" alt="exécuter le batch" src="images/Execution.png" />


---

## 📁 Structure du projet

```
300137754/
├── README.md
└── devops-batch/
    ├── devops_batch.ps1
    ├── rapport.txt
    └── rapport.json
```

---

## 📊 Résultats

Après exécution du script :

* ✔️ Affichage des informations système
* ✔️ Vérification disque
* ✔️ Test SSH
* ✔️ Génération :

  * `rapport.txt`
  * `rapport.json`

---

## 💡 Technologies utilisées

* PowerShell (pwsh)
* Linux Ubuntu
* Git & GitHub

---

## 🧠 Conclusion

Ce TP m’a permis de comprendre :

* L’automatisation avec PowerShell sous Linux
* L’utilisation des scripts DevOps
* La génération de rapports exploitables



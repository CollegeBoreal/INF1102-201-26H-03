# 🚀 TP PowerShell — Automatisation DevOps

## 📌 Description du projet

Ce projet consiste à développer un script PowerShell permettant d’automatiser des tâches d’administration système sur une machine Linux (Ubuntu 22.04).

Le script effectue plusieurs vérifications système et génère des rapports en format texte et JSON.

---

## 👤 Informations étudiant

* **Nom :** Hachem Souyadi
* **ID :** 300150416
* **Cours :** INF1102 — Programmation système / DevOps

---

## ⚙️ Technologies utilisées

* `PowerShell 7`
* `Linux Ubuntu 22.04`
* `Bash`
* `SSH`
* `Git / GitHub`

---

## 📁 Structure du projet

```
6.PWSH/300150416/
│
├── devops_batch.ps1
├── rapport.txt
├── rapport.json
└── images/
```

---

## 🛠️ Installation de PowerShell

```bash
sudo apt update
sudo apt install -y wget apt-transport-https software-properties-common

wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt update
sudo apt install -y powershell
```

Vérification :

```powershell
$PSVersionTable
```

---

## 📜 Fonctionnement du script

Le script `devops_batch.ps1` réalise :

### 🔹 Informations système

* Date
* Utilisateur (`whoami`)
* Machine (`hostname`)

### 🔹 Analyse des processus

* Top 5 processus par CPU
* Top 5 processus par mémoire

### 🔹 Vérification disque

* Utilisation du disque avec `df -h`

### 🔹 Test SSH

* Test de connexion vers `127.0.0.1`

### 🔹 Génération des rapports

* `rapport.txt` (lecture humaine)
* `rapport.json` (format structuré)

---

## ▶️ Exécution du script

```bash
sudo pwsh /devops-batch/devops_batch.ps1
```

---

## 📊 Résultats

```bash
/devops-batch/
├── devops_batch.ps1
├── rapport.txt
└── rapport.json
```

---

## 📸 Captures d’écran

### ▶️ Exécution du script

![Execution](images/execution.png)

### 📄 Rapport texte

![TXT](images/log.png)

### 📊 Rapport JSON

![JSON](images/json.png)

### ⚙️ Processus système

![Process](images/process.png)

---

## ⚠️ Remarque

Le message :

```
Host key verification failed
```

peut apparaître lors du test SSH.
Cela n’affecte pas le bon fonctionnement global du script.

---

## 🎯 Conclusion

Ce TP démontre :

* l’automatisation avec PowerShell sous Linux
* la surveillance système
* la génération de rapports
* les bases du DevOps

---

## 👨‍💻 Auteur

**Hachem Souyadi**
ID : 300150416
Collège Boréal


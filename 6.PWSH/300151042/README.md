
# 📘 README – Batch DevOps PowerShell sous Ubuntu

## 🧾 1. Présentation du laboratoire

Ce laboratoire consiste à développer un script PowerShell exécuté sous Linux afin d’automatiser la collecte d’informations système et de générer des rapports exploitables.

L’objectif est de simuler un scénario DevOps réel où un administrateur doit surveiller l’état d’un serveur de manière automatisée. 

---

## 🎯 2. Objectifs pédagogiques

À la fin de ce laboratoire, l’étudiant sera capable de :

* Créer un script PowerShell sous Linux
* Utiliser le pipeline orienté objets
* Collecter des informations système (CPU, mémoire, disque)
* Tester la connectivité réseau (SSH)
* Générer des rapports texte et JSON
* Automatiser des tâches DevOps

---

## 🖥 3. Environnement technique

* OS : Ubuntu 22.04
* Shell : PowerShell (`pwsh`)
* Outils : SSH, df, Get-Process
* Dossier de travail :

```id="fw4e91"
/devops-batch/
```

---

## ⚙️ 4. Installation de PowerShell

```bash id="r9n3cx"
sudo apt update
sudo apt install -y wget apt-transport-https software-properties-common
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
```

Lancer PowerShell :

```bash id="g2q8ts"
pwsh
```

---

<img width="1366" height="768" alt="Capture4" src="https://github.com/user-attachments/assets/f000d8d4-2d11-4801-98c4-05902453e333" />

## 📁 5. Structure du projet

```id="w6k2p9"
/devops-batch/
│
├── devops_batch.ps1
├── rapport.txt
└── rapport.json
```

---

## 🧠 6. Description du script

Le script PowerShell réalise les actions suivantes :

### ✔ Informations système

* Nom de la machine
* Utilisateur
* Date

### ✔ Analyse des processus

* Top 5 CPU
* Top 5 mémoire

### ✔ Vérification disque

* Utilisation via `df -h`

### ✔ Test réseau

* Connexion SSH vers localhost

### ✔ Génération de rapports

* Format texte (`rapport.txt`)
* Format JSON (`rapport.json`)

---

## ▶️ 7. Exécution du script

```bash id="z3k8da"
sudo pwsh /devops-batch/devops_batch.ps1
```

Résultat attendu :

* Affichage des informations système
* Création de deux fichiers :

  * `rapport.txt`
  * `rapport.json`

---

## 📊 8. Exemple de pipeline PowerShell

```powershell id="y8f2lm"
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
```

👉 Contrairement à Bash, PowerShell manipule des objets et non du texte, ce qui simplifie le traitement des données. 

---

## 🔄 9. Comparaison Bash vs PowerShell

| Critère  | Bash     | PowerShell |
| -------- | -------- | ---------- |
| Données  | Texte    | Objets     |
| JSON     | complexe | natif      |
| Pipeline | texte    | objets     |
| DevOps   | limité   | avancé     |

---

## 🚀 10. Avantages de PowerShell sous Linux

* Multi-plateforme (Windows + Linux + macOS)
* Pipeline orienté objets
* Intégration API et JSON
* Scripts plus robustes
* Idéal pour DevOps

---

## ⚠️ 11. Problèmes rencontrés

| Problème           | Solution             |
| ------------------ | -------------------- |
| pwsh non reconnu   | installer PowerShell |
| script non exécuté | vérifier permissions |
| SSH échoue         | vérifier service ssh |
| rapport vide       | vérifier commandes   |

---

## 🧪 12. Résultat final

Après exécution :

```id="t2d9as"
/devops-batch/
│
├── devops_batch.ps1
├── rapport.txt
└── rapport.json
```

Les rapports contiennent :

* les processus les plus gourmands
* l’état du disque
* le test réseau
* les informations système

---
<img width="1011" height="730" alt="verification" src="https://github.com/user-attachments/assets/a3c70a91-1130-496c-bdfc-a84d485407bb" />


## 🧠 13. Conclusion

Ce laboratoire démontre l’intérêt d’utiliser PowerShell sous Linux dans un contexte DevOps.

Il permet :

* d’automatiser l’administration système
* de produire des rapports structurés
* d’améliorer la portabilité des scripts

PowerShell devient ainsi un outil puissant pour gérer des environnements hybrides modernes. 

---

## 📚 14. Références

Documentation PowerShell
Documentation Linux
Cours INF1102 – DevOps et scripting

---

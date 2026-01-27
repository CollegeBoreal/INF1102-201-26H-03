# 🐚 Shells

---

Ce cours est consacré à l'étude de la programmation avancée nécessaire à l'automatisation de diverses tâches reliées à l'administration de systèmes. Plus d'un système d'exploitation sera à l'étude.

---

Une **illustration concrète du cours**, avec des **thèmes**, des **outils** et des **exercices typiques**, comme on les verrait dans un cours de **programmation avancée pour l’administration de systèmes (INF1102)**.

---

## 1. Langages et environnements étudiés

Selon le système d’exploitation :

### Linux / Unix

* **Bash avancé**
* **Python** (scripts d’administration)
* Utilitaires : `systemd`, `cron`, `ssh`, `sed`, `awk`, `journalctl`

### Windows

* **PowerShell**
* WMI / CIM
* Gestion des services, utilisateurs, événements

---

## 2. Concepts clés abordés

### 🔹 Programmation avancée

* Fonctions et modules
* Gestion des erreurs et exceptions
* Journalisation (logs)
* Traitement de fichiers (texte, CSV, JSON)
* Programmation orientée tâche

### 🔹 Administration système automatisée

* Création et gestion des utilisateurs
* Gestion des permissions
* Surveillance des ressources (CPU, mémoire, disque)
* Déploiement et configuration de services
* Sauvegardes automatisées

### 🔹 Multi-OS

* Différences Linux vs Windows
* Scripts portables
* Détection du système d’exploitation
* Abstraction des commandes

---

## 3. Exemples d’exercices typiques

### 🧪 Exercice 1 – Gestion des utilisateurs

**Objectif :** Automatiser la création d’utilisateurs à partir d’un fichier.

* Entrée : `users.csv`
* Tâches :

  * Créer les comptes
  * Définir un mot de passe temporaire
  * Forcer le changement au premier login
  * Journaliser les actions

➡️ Version Bash (Linux) et PowerShell (Windows)

---

### 🧪 Exercice 2 – Surveillance système

**Objectif :** Détecter un problème et agir automatiquement.

* Vérifier :

  * Espace disque < 15 %
  * Mémoire utilisée > 80 %
* Actions :

  * Envoyer une alerte (log / mail)
  * Redémarrer un service si nécessaire

---

### 🧪 Exercice 3 – Sauvegarde automatisée

**Objectif :** Script de backup intelligent.

* Sauvegarde incrémentale
* Compression
* Rotation des sauvegardes
* Exécution planifiée (`cron` / Task Scheduler)

---

### 🧪 Exercice 4 – Script multi-plateforme

**Objectif :** Un seul script, plusieurs OS.

Exemples de tâches :

* Détecter l’OS
* Lister les services actifs
* Exporter le résultat en JSON

```pseudo
si Linux → systemctl
si Windows → Get-Service
```

---

## 4. Travaux pratiques (TP)

### TP typique

Créer un **outil d’administration complet** :

* Menu interactif
* Gestion des utilisateurs
* Surveillance système
* Logs
* Compatible Linux / Windows

---

## 5. Compétences développées

À la fin du cours, l’étudiant est capable de :

* Automatiser des tâches complexes
* Écrire des scripts robustes et maintenables
* Gérer plusieurs systèmes d’exploitation
* Appliquer de bonnes pratiques d’administration
* Comprendre les bases de l’**Infrastructure as Code**

---

## 6. Lien avec le monde réel

Ce cours prépare directement à :

* **Sysadmin / DevOps junior**
* **SRE**
* **Cloud & virtualisation**
* **Automatisation IT (Ansible, Terraform, etc.)**

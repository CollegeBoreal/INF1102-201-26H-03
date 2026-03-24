# Informations de l’étudiant

**Nom et Prénoms :** Babatundé Adissa Fadolle Arouna

**Numéro étudiant :** 300151970

**Programme :** Techniques des systèmes informatiques

**Cours :** INF 1102-201 – Programmation de systèmes

**Session :** Hiver 2026

**Professeur :** Brice Robert

**Date de remise :** 24/03/2026

---

# PWSH (PowerShell sous Linux)

Ce laboratoire consiste à installer PowerShell sur Ubuntu 22.04 et à créer un script DevOps permettant d’automatiser la collecte d’informations système.

---

# Objectifs

À la fin de ce laboratoire, je suis capable de :

* Installer PowerShell
* Créer et exécuter un script PowerShell
* Vérifier CPU, mémoire, disque
* Tester une connexion SSH
* Générer des rapports TXT et JSON

---

# PARTIE 1 – Installation de PowerShell

---

## Étape 1 : Mise à jour du système

```bash
sudo apt update
```

### Explication

Cette commande permet de mettre à jour la liste des paquets disponibles sur Ubuntu.

### 📸 Capture à ajouter

```markdown
![Update](images/update.png)
```

### Résultat attendu

* Liste des paquets mise à jour
* Aucune erreur

---

## Étape 2 : Installation des dépendances

```bash
sudo apt install -y wget apt-transport-https software-properties-common
```

### Explication

Installe les outils nécessaires pour télécharger et ajouter un dépôt externe.

### 📸 Capture

```markdown
![Dependances](images/dependances.png)
```

### Résultat attendu

* Installation complétée
* Message "done" ou "installed"

---

## Étape 3 : Ajouter le dépôt Microsoft

```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
```

### Explication

Télécharge et installe le dépôt Microsoft pour pouvoir installer PowerShell.

### 📸 Capture

```markdown
![Depot](images/repo.png)
```

### Résultat attendu

* Dépôt installé sans erreur

---

## Étape 4 : Mise à jour

```bash
sudo apt update
```

### Explication

Recharge les paquets en incluant PowerShell.

### ✅ Résultat attendu

* PowerShell apparaît dans les paquets disponibles

---

## Étape 5 : Installer PowerShell

```bash
sudo apt install -y powershell
```

### Explication

Installe PowerShell sur Ubuntu.

### 📸 Capture

```markdown
![Install](images/install_pwsh.png)
```

### Résultat attendu

* Installation réussie

---

## Étape 6 : Lancer PowerShell

```bash
pwsh
```

### Explication

Permet d’ouvrir PowerShell.

### 📸 Capture

```markdown
![Pwsh](images/pwsh.png)
```

### Résultat attendu

```
PS /home/user>
```

---

## Étape 7 : Vérifier la version

```powershell
$PSVersionTable
```

### Explication

Affiche les informations de version.

### 📸 Capture

```markdown
![Version](images/version.png)
```

### Résultat attendu

* Version affichée correctement

---

# PARTIE 2 – Script DevOps

---

## Étape 1 : Créer le dossier

```bash
sudo mkdir /devops-batch
```

### Explication

Créer un dossier pour stocker le script et les rapports.

### 📸 Capture

```markdown
![mkdir](images/mkdir.png)
```

### Résultat attendu

* Dossier créé sans erreur

---

## 🔹 Étape 2 : Créer le script

```bash
sudo nano /devops-batch/devops_batch.ps1
```

### Explication

Permet de créer le script PowerShell.

Ajouter :

```powershell
#!/usr/bin/env pwsh
```

### 📸 Capture

```markdown
![script](images/script.png)
```

### Résultat attendu

* Script créé

---

## 🔹 Étape 3 : Script complet

👉 (coller ton script ici)

### Explication

Le script permet de :

* récupérer les infos système
* analyser CPU et mémoire
* vérifier le disque
* tester SSH
* générer un rapport JSON

---

## 🔹 Étape 4 : Exécuter le script

```bash
sudo pwsh /devops-batch/devops_batch.ps1
```

### Explication

Exécute le script PowerShell.

### 📸 Capture

```markdown
![execution](images/run.png)
```

### Résultat attendu

* Messages affichés
* Aucune erreur

---

# PARTIE 3 – Résultats

---

## 🔹 Rapport TXT

### 📸 Capture

```markdown
![rapport txt](images/rapport_txt.png)
```

### Résultat attendu

* Informations système visibles
* CPU, mémoire, disque affichés

---

## 🔹 Rapport JSON

### 📸 Capture

```markdown
![rapport json](images/rapport_json.png)
```

### Résultat attendu

* Fichier JSON valide
* Données structurées

---

## Structure finale

```
/devops-batch/
├── devops_batch.ps1
├── rapport.txt
└── rapport.json
```

### Capture

```markdown
![structure](images/structure.png)
```

### Résultat attendu

* Tous les fichiers présents

---

# Conclusion

Ce laboratoire m’a permis d’apprendre à utiliser PowerShell sous Linux pour automatiser des tâches. J’ai compris comment analyser un système, tester un réseau et générer des rapports, ce qui est essentiel en DevOps.



---

Si tu veux, Babatundé 👇
Je peux te dire **exactement quoi capturer écran par écran** pour que ton prof n’ait rien à redire.

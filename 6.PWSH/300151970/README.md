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
Connexion au serveur Linux
Pour accéder au serveur Ubuntu, j’ai utilisé une connexion SSH avec une clé privée.

Commande utilisée

 ```bash
ssh -i ~/.ssh/ma_cle.pk \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
ubuntu@10.7.237.223
```

<img width="1557" height="706" alt="1" src="https://github.com/user-attachments/assets/5c2329d6-5d0a-4fd7-aea3-1a5eb9d5022b" />


# PARTIE 1 – Installation de PowerShell

### Étape 1 : Mise à jour du système

```bash
sudo apt update
```

<img width="1136" height="375" alt="2" src="https://github.com/user-attachments/assets/d7f5387f-7e08-4e98-9e93-51523d0f4b4f" />

**Explication :**
Met à jour la liste des paquets disponibles sur Ubuntu.

**Résultat attendu :**
Le système affiche la liste des dépôts et aucun message d’erreur.

---

### Étape 2 : Installer les dépendances

```bash
sudo apt install -y wget apt-transport-https software-properties-common
```

<img width="1155" height="187" alt="3" src="https://github.com/user-attachments/assets/40b84a76-db87-4c0b-bb96-1de66d6298b7" />

**Explication :**
Ces outils permettent de télécharger et d’ajouter des dépôts externes (ici, le dépôt Microsoft pour PowerShell).

**Résultat attendu :**
Les paquets sont installés sans erreur.

---

### 🔹 Étape 3 : Ajouter le dépôt Microsoft

```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
```

<img width="1397" height="402" alt="4" src="https://github.com/user-attachments/assets/8c1d3302-920c-4176-a6f3-31df2553d039" />


**Explication :**
Télécharge et installe le dépôt officiel Microsoft contenant PowerShell.

**Résultat attendu :**
Le dépôt Microsoft est ajouté correctement.

---

### Étape 4 : Mettre à jour les dépôts

```bash
sudo apt update
```
<img width="872" height="237" alt="5" src="https://github.com/user-attachments/assets/f3f3b5a2-b045-4079-8bc5-d99eeaa43e97" />

**Explication :**
Recharge les dépôts afin de reconnaître PowerShell comme paquet installable.

**Résultat attendu :**
Mise à jour réussie, PowerShell disponible.

---

### Étape 5 : Installer PowerShell

```bash
sudo apt install -y powershell
```
<img width="797" height="153" alt="6" src="https://github.com/user-attachments/assets/6321b814-2c49-4e19-98a4-00037c71f258" />

**Explication :**
Installe PowerShell sur Ubuntu.

**Résultat attendu :**
PowerShell 7.x installé.

---

### Étape 6 : Lancer PowerShell

```bash
pwsh
```
<img width="760" height="47" alt="7" src="https://github.com/user-attachments/assets/07fc04f0-aa96-478e-a5b5-13e4401ce910" />

**Explication :**
Ouvre le shell PowerShell.

**Résultat attendu :**
Prompt PowerShell affiché :

```
PS /home/user>
```

---

### Étape 7 : Vérifier la version

```powershell
$PSVersionTable
```

**Explication :**
Affiche la version exacte de PowerShell installée.

**Résultat attendu :**
Version 7.x confirmée.

---

# PARTIE 2 – Script DevOps PowerShell

### Étape 1 : Créer le dossier pour le TP

```bash
sudo mkdir /devops-batch
```

**Explication :**
Créer un dossier dédié pour organiser les fichiers du TP.

**Résultat attendu :**
Dossier `/devops-batch` créé (si existe déjà, message “File exists”).

---

### Étape 2 : Créer le script principal

```bash
sudo nano /devops-batch/devops_batch.ps1
```

Ajouter en première ligne :

```powershell
#!/usr/bin/env pwsh
```

**Explication :**
Le shebang permet d’exécuter le script directement sous Linux avec `pwsh`.

**Résultat attendu :**
Fichier créé prêt à recevoir le code PowerShell.

---

### Étape 3 : Script complet

```powershell
#!/usr/bin/env pwsh

# Variables pour les rapports
$rapportTxt = "/devops-batch/rapport.txt"
$rapportJson = "/devops-batch/rapport.json"
$hostname = hostname
$user = whoami
$date = Get-Date

# Création d'un rapport texte
Write-Output "===== RAPPORT DEVOPS =====" | Tee-Object $rapportTxt
Write-Output "Date : $date" | Tee-Object -Append $rapportTxt
Write-Output "Utilisateur : $user" | Tee-Object -Append $rapportTxt
Write-Output "Machine : $hostname" | Tee-Object -Append $rapportTxt

# CPU & Mémoire
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5

Write-Output "Top 5 processus par CPU :" | Tee-Object -Append $rapportTxt
foreach ($p in $topCPU) { Write-Output ("{0} - CPU: {1}" -f $p.ProcessName, $p.CPU) | Tee-Object -Append $rapportTxt }

Write-Output "Top 5 processus par Mémoire :" | Tee-Object -Append $rapportTxt
foreach ($p in $topMem) { Write-Output ("{0} - Mémoire: {1}" -f $p.ProcessName, $p.WorkingSet) | Tee-Object -Append $rapportTxt }

# Disque
$disk = df -h
Write-Output "Espace disque :" | Tee-Object -Append $rapportTxt
Write-Output $disk | Tee-Object -Append $rapportTxt

# Test SSH
$sshHost = "127.0.0.1"
try {
    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 $sshHost "echo OK" 2>&1
    Write-Output "Test SSH vers $sshHost : $result" | Tee-Object -Append $rapportTxt
} catch {
    Write-Output "SSH échoué vers $sshHost" | Tee-Object -Append $rapportTxt
}

# Génération JSON
$reportObj = [PSCustomObject]@{
    Date = $date
    Utilisateur = $user
    Machine = $hostname
    TopCPU = $topCPU | ForEach-Object { @{Process=$_.ProcessName; CPU=$_.CPU} }
    TopMemory = $topMem | ForEach-Object { @{Process=$_.ProcessName; Memory=$_.WorkingSet} }
    Disk = $disk
}

$reportObj | ConvertTo-Json -Depth 5 | Set-Content $rapportJson
Write-Output "Rapports générés : $rapportTxt et $rapportJson"
```

**Explication :**
Le script :

1. Crée un rapport texte et JSON
2. Affiche CPU, mémoire et disque
3. Test SSH vers localhost
4. Génère des fichiers prêts pour DevOps

**Résultat attendu :**

* Fichiers : `/devops-batch/rapport.txt` et `/devops-batch/rapport.json`
* Affichage console avec toutes les informations

---

### Étape 4 : Exécuter le script

```bash
sudo pwsh /devops-batch/devops_batch.ps1
```

**Explication :**
Exécute le script DevOps et crée les rapports.

**Résultat attendu :**

* Console affiche CPU, mémoire, disque et SSH
* Création des fichiers TXT et JSON

---

# PARTIE 3 – Résultats obtenus

### Informations générales

```
Date : 03/24/2026
Utilisateur : root
Machine : vm300151970
```

### CPU

```
Top 5 processus par CPU
```

### Mémoire

```
Top 5 processus par mémoire
```

### Disque

```
Utilisation disque : 29%
```

### SSH

```
Host key verification failed
```

*(La connexion fonctionne mais la clé SSH n’est pas enregistrée)*

### Fichiers générés

* `/devops-batch/rapport.txt`
* `/devops-batch/rapport.json`

### Structure finale

```
/devops-batch/
├── devops_batch.ps1
├── rapport.txt
└── rapport.json
```

# Conclusion

PowerShell sous Linux permet :

* Une **automatisation multi-plateforme**
* Un **pipeline orienté objets** facile à exploiter
* La génération de **rapports JSON et TXT** prêts pour DevOps
* Une **interopérabilité avec Windows** pour scripts existants





# Infrastructure as Code (IaC) – TP

## 👤 Informations

* **Nom** : Hajar Jabre
* **ID Boréal** : 300138576
* **Cours** : INF1102 – Programmation système
* **Sujet** : Infrastructure as Code avec OpenTofu

---

## 1. Introduction

L’administration traditionnelle des systèmes se fait souvent manuellement, ce qui entraîne des erreurs et des incohérences.
L’Infrastructure as Code (IaC) permet d’automatiser la gestion des infrastructures avec du code.

---

## 2. Objectif du TP

* Comprendre l’IaC
* Utiliser OpenTofu
* Automatiser une tâche
* Utiliser Git pour versionner

---

## 3. Installation et vérification

###  Commande :

```bash
tofu version
```

<img width="625" height="64" alt="1" src="https://github.com/user-attachments/assets/794ffa08-4729-49fa-a61f-7a05c24687f0" />

###  Résultat attendu :

* Version affichée : OpenTofu v1.11.4

---

##  4. Création du projet

### Commandes :

```bash
mkdir 300138576
cd 300138576
nano provider.tf, main.tf, variables.tf, terraform.tfvars -ItemType File
```

### Résultat attendu :

* Les fichiers sont créés dans le dossier

<img width="613" height="196" alt="2" src="https://github.com/user-attachments/assets/a70bbda1-3971-471a-bcfe-f8fbe704071c" />

---

## 5. Configuration OpenTofu

### Exemple dans `main.tf` :

```hcl
resource "local_file" "test" {
  filename = "preuve.txt"
  content  = "Test IaC réussi - Hajar Jabre"
}
```


## 6. Initialisation

### Commande :

```bash
tofu init
```

### Résultat attendu :

* Message : *OpenTofu has been successfully initialized*

<img width="620" height="242" alt="3" src="https://github.com/user-attachments/assets/1ed775ac-d845-4034-b946-6bfa1981dcb7" />


---

## 7. Planification

### Commande :

```bash
tofu plan
```

###  Résultat attendu :

Affichage des ressources à créer

<img width="686" height="455" alt="4" src="https://github.com/user-attachments/assets/ed11854f-2911-4dbf-a8f4-88b63c113e10" />

  

---

## ❗ 8. Problème rencontré (IMPORTANT)

### 🔹 Erreur :

Connexion refusée au serveur Proxmox :

```text
connectex: No connection could be made
```

### 🔹 Analyse :

* Le ping fonctionne ✔
* Le port 8006 est bloqué ❌

📸 **Captures à ajouter :**
👉 Résultat du `ping 10.7.237.198`
👉 Erreur complète de `tofu plan`

---

## 🧪 9. Test local (preuve de fonctionnement)

### 🔹 Commande :

```bash
tofu apply
```

### ✅ Résultat attendu :

* Création du fichier `preuve.txt`

📸 **Captures à ajouter :**
👉 Résultat de `tofu apply`
👉 Fichier `preuve.txt` dans le dossier

---

## 🧾 10. Git et envoi sur GitHub

### 🔹 Commandes :

```bash
git add .
git commit -m "TP IaC"
git pull origin main --rebase
git push
```

### ✅ Résultat attendu :

* Projet envoyé sur GitHub

📸 **Captures à ajouter :**
👉 Terminal avec `git push` réussi
👉 Repository GitHub (page web)

---

## ✅ 11. Résultat final

* OpenTofu fonctionne ✔
* Projet créé ✔
* Git fonctionnel ✔
* Problème réseau identifié ✔

---

## 🧠 12. Conclusion

L’IaC permet d’automatiser la gestion des infrastructures de manière fiable et reproductible.
Même en présence d’un problème réseau, il est possible d’analyser et comprendre les erreurs.

---

## 📌 13. Organisation des captures

👉 Place tes images dans un dossier :

```
images/
```

👉 Exemple dans README :

```md
![tofu version](images/version.png)
![tofu init](images/init.png)
![tofu plan](images/plan.png)
```

---

## 🎯 14. Remarque finale

Ce TP démontre :

* la compréhension de l’IaC
* l’utilisation d’un outil professionnel
* la capacité à résoudre un problème technique

---

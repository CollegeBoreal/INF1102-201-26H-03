# Etudiant
300145405
Elhadj Sadou Barry

# 📊 TP Regex – Analyse des logs Nginx

## 🎯 Objectif

Ce TP a pour but d’analyser un fichier de logs Nginx en utilisant des expressions régulières (Regex) avec PowerShell afin de générer un rapport automatique.

---

## 📁 Structure du projet

* analyse_nginx.ps1 → Script PowerShell
* access.log → Fichier de logs
* rapport_nginx_ps1_YYYY-MM-DD.txt → Rapport généré

---

## 📥 Fichier d’entrée

Le fichier `access.log` contient des lignes de logs comme :

192.168.1.10 - - [17/Mar/2026:14:32:10 +0000] "GET /index.html HTTP/1.1" 200 1024

---

## ⚙️ Fonctionnement du script

Le script permet de :

* Compter le nombre total de requêtes
* Extraire les codes HTTP avec Regex `(\d{3})`
* Identifier les erreurs (codes 4xx et 5xx)
* Extraire les adresses IP
* Extraire les pages visitées

---

## ▶️ Exécution

Commande utilisée :

.\analyse_nginx.ps1

---

## 📄 Résultat

Le script génère un fichier rapport contenant :

* Total des requêtes
* Nombre d’erreurs HTTP
* Nombre d’erreurs 404 et 500
* Top 5 des adresses IP
* Top 5 des pages

---

## 📸 Captures d’écran
<img width="938" height="74" alt="Capture d’écran 2026-04-04 152831 - Copie" src="https://github.com/user-attachments/assets/6e2d750e-6ae2-4dcd-8218-c0e0eca61354" />
-------
<img width="1094" height="444" alt="Capture d’écran 2026-04-04 152921" src="https://github.com/user-attachments/assets/2322a298-e2ff-44b5-bc16-a702ecd344a0" />
-----------
<img width="1750" height="823" alt="Capture d’écran 2026-04-04 153326 - Copie" src="https://github.com/user-attachments/assets/d6808367-7de1-4e70-b065-90b52283f23e" />




---

## 🧠 Conclusion

Ce TP m’a permis de comprendre l’utilisation des expressions régulières pour analyser des fichiers texte, extraire des informations importantes et automatiser la génération de rapports.

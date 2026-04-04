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

(ajoute ici tes captures)

---

## 🧠 Conclusion

Ce TP m’a permis de comprendre l’utilisation des expressions régulières pour analyser des fichiers texte, extraire des informations importantes et automatiser la génération de rapports.

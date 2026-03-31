\# 🖥️ TP PowerShell – DevOps Batch



\## 👨‍🎓 Étudiant



\* Nom : Abdou karim NIANG

\* ID : 300141858

\* Cours : INF1102 – Programmation de systèmes



\---



\## 🎯 Objectif



Ce laboratoire consiste à créer un script PowerShell permettant :



\* Vérification CPU

\* Vérification mémoire

\* Vérification disque

\* Test de connectivité SSH

\* Génération de rapports TXT et JSON



\---



\## 📂 Structure du projet



```

6.PWSH/300141858/

│

├── devops\_batch.ps1

├── rapport.txt

├── rapport.json

└── README.md

```



\---



\## ⚙️ Exécution



```powershell

pwsh .\\devops\_batch.ps1

```



\---



\## 📊 Résultats



\### ✔ Rapport texte



Contient :



\* Informations système

\* Top CPU

\* Top mémoire

\* Disque

\* Test SSH



\### ✔ Rapport JSON



Contient :



\* Données structurées

\* CPU / mémoire / disque



\---



\## 🧠 Explication technique



Le script utilise :



\* `Get-Process` → analyse CPU et RAM

\* `Get-PSDrive` → analyse disque

\* `ssh` → test réseau

\* `ConvertTo-Json` → génération JSON



\---



\## 📸 Preuve d’exécution



Ajoute ici une capture d’écran de ton terminal après exécution.



Exemple :



```

pwsh .\\devops\_batch.ps1

```



\---



\## ✅ Conclusion



Ce TP démontre l’utilisation de PowerShell pour :



\* Automatisation DevOps

\* Analyse système

\* Génération de rapports



PowerShell permet une gestion plus structurée grâce à son pipeline orienté objets.




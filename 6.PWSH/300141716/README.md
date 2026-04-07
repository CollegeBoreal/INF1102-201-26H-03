🧪 Laboratoire DevOps — Script PowerShell (Linux)

📌 Aperçu



Ce laboratoire consiste à créer un script PowerShell sous Linux (Ubuntu) permettant d’automatiser des vérifications système.

Le script collecte des informations sur le système (CPU, mémoire, disque), teste la connexion SSH et génère des rapports en format TXT et JSON.



🎯 Objectifs



À la fin de ce laboratoire, j’ai été capable de :



Créer un script PowerShell fonctionnel sous Linux

Automatiser des tâches système

Surveiller les ressources (CPU, mémoire, disque)

Tester la connectivité SSH

Générer des rapports en TXT et JSON

📁 Structure du projet

devops-batch/

│── devops\_batch.ps1

│── rapport.txt

│── rapport.json

│── images/

⚙️ Script PowerShell



📸 Script :



!\[Script](images/script.png)

▶️ Exécution du script

pwsh devops\_batch.ps1



📸 Exécution :



!\[Execution](images/run.png)

📄 Résultat TXT



📸 rapport.txt :



!\[TXT](images/result\_txt.png)

📄 Résultat JSON



📸 rapport.json :



!\[JSON](images/result\_json.png)

🚀 Résultat



Le script fonctionne correctement et permet :



d’automatiser la collecte d’informations système

de générer des rapports lisibles

de vérifier le service SSH

d’utiliser PowerShell dans un environnement Linux


Cette partie consiste à créer la structure de dossiers et les fichiers de test nécessaires afin de préparer l’environnement dans lequel le script pourra fonctionner correctement.

```powershell
sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```
![](images/image1.png)

```powershell
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```

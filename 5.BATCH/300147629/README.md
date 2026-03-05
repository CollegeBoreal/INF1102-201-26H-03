#Préparation de l’environnement

```powershel

sudo mkdir -p /entreprise/data
sudo mkdir -p /entreprise/backup
sudo mkdir -p /entreprise/logs
```
<img width="927" height="307" alt="Les premier scripts bash png" src="https://github.com/user-attachments/assets/409c330c-2a79-4560-ab57-bdef644d2895" />

#Creation  des fichiers test :

```
Powershell
echo "Fichier 1" | sudo tee /entreprise/data/fichier1.txt
echo "Fichier 2" | sudo tee /entreprise/data/fichier2.txt
```
<img width="941" height="140" alt="fichiers png" src="https://github.com/user-attachments/assets/b4f93738-27c1-495c-890c-4a606d5436df" />


#Création du script Batch et ajouter le code
```
Powershell
```
<img width="948" height="966" alt="Bahs1 png" src="https://github.com/user-attachments/assets/8f8b1146-5dfa-448b-957b-209e18bc727e" />

#Rendre exécutable le script

```
Powershell
sudo chmod +x /entreprise/script_gestion.sh
```
#










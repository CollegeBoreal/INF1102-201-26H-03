# TP Ansible – Déploiement Nginx
## Auteur : Oumar Balde (300147629)

Ce projet automatise l'installation de Nginx et le deploiement d'une page web personnalisée via 

#Objectif du TP
Ce travail pratique permet de mettre en œuvre un déploiement automatisé en utilisant Ansible afin de :

Installer Nginx sur un serveur distant

Déployer automatiquement une page web personnalisée

Activer et démarrer le service Nginx
#📁 Structure du projet
```Powershell

300147629/
├── files/
│   └── index.html
├── images/
│   └── (captures d’écran du TP)
├── inventory.ini
└── playbook.yml
```
#🖥️ Configuration utilisée
Machine de contrôle : VM Ubuntu (vm300147629)

Machine distante : 10.7.237.212

Connexion SSH via clé privée ma_cle.pk

Ansible installé sur la VM de contrôle

Nginx installé automatiquement sur la machine distante

#Installé Ansible :
```Powershell
sudo apt update
sudo apt install ansible-core -y
```
<img width="975" height="442" alt="image" src="https://github.com/user-attachments/assets/0a9ac858-a30f-4edb-9b90-c6c8a333737d" />

#Verification 
```Powershell
ansible --version
```
<img width="975" height="285" alt="image" src="https://github.com/user-attachments/assets/ece4d752-c940-40ff-a8f1-6f1a13906fe9" />


#Inventory (inventory.ini)
```powershell
[web]
10.7.237.212 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ma_cle.pk

```

#▶️ Exécution du playbook

```Powershell
ansible-playbook -i inventory.ini playbook.yml
```
<img width="975" height="319" alt="image" src="https://github.com/user-attachments/assets/4142700a-3d98-4d37-a015-d35172655198" />

#Vérification du déploiement
```powershell
curl http://10.7.237.212
```
<img width="975" height="489" alt="image" src="https://github.com/user-attachments/assets/5be4e642-8bd5-40f3-8766-e1c3e43bf33b" />




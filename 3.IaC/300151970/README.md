## 1. Vérification de l’installation d’OpenTofu

Commande exécutée :
```bash
tofu version
```
### Explication

Cette commande permet de vérifier que OpenTofu est correctement installé sur la machine locale.
Elle affiche la version utilisée et confirme que l’outil est opérationnel.

Cette vérification est essentielle avant de démarrer le projet afin d’éviter tout problème lié à l’environnement.

<img width="352" height="91" alt="image1" src="https://github.com/user-attachments/assets/67867d20-c769-4db9-9928-647410854f14" />


## 2. Initialisation du projet

Commande exécutée :

```bash
tofu init
```

### Explication

La commande `tofu init` initialise le projet Infrastructure as Code.
Elle permet notamment de :

* télécharger automatiquement le provider `telmate/proxmox`
* créer le dossier `.terraform`
* préparer la communication avec l’API Proxmox

Sans cette étape, OpenTofu ne peut pas exécuter les configurations définies.

<img width="1478" height="552" alt="tufu init" src="https://github.com/user-attachments/assets/b0a4193e-3157-4597-b4a2-d13747a147fb" />

---

## 3. Analyse du plan de déploiement

Commande exécutée :

```bash
tofu plan
```

### Explication

La commande `tofu plan` génère un aperçu détaillé des actions qui seront réalisées.

Dans ce cas, OpenTofu indique que la ressource `proxmox_vm_qemu.vm1` sera créée.
Aucune modification n’est encore appliquée à ce stade.

Cette étape permet de :

* vérifier que la configuration est correcte
* confirmer les paramètres (CPU, mémoire, disque, réseau)
* détecter d’éventuelles erreurs avant le déploiement

<img width="1436" height="678" alt="tofu plan" src="https://github.com/user-attachments/assets/d1cdeeb6-f9e8-4bda-9fcb-185f766b17b7" />


---

## 4. Déploiement de la machine virtuelle

Commande exécutée :

```bash
tofu apply
```

Après validation, OpenTofu applique le plan et crée réellement la machine virtuelle sur Proxmox.

### Explication

Cette étape :

* envoie les instructions à l’API Proxmox
* crée la VM selon les paramètres définis
* configure le réseau et l’accès SSH

Le code est ainsi transformé en infrastructure fonctionnelle.

<img width="1440" height="711" alt="tofu apply" src="https://github.com/user-attachments/assets/a59f6f5f-ea77-46a4-ac25-16168ca07b0d" />


---

## 5. Vérification dans l’interface Proxmox

Une fois le déploiement terminé, j’ai vérifié dans l’interface web de Proxmox que la machine virtuelle a bien été créée.

Points vérifiés :

* la VM apparaît dans la liste
* elle est en état *running*
* les ressources correspondent à la configuration définie

Cette vérification confirme le succès du déploiement automatisé.

<img width="1918" height="971" alt="Image" src="https://github.com/user-attachments/assets/4c993277-3d30-4c0f-a46f-05551bbe4fd8" />


---

## 6. Connexion à la machine virtuelle via SSH

Commande utilisée :

```bash
ssh -i ~/.ssh/ma_cle.pk \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
  ubuntu@10.7.237.223
```

### Explication

Cette commande permet de se connecter à la machine virtuelle à l’aide d’une clé privée.

Les options supplémentaires sont utilisées afin d’éviter les blocages liés aux empreintes SSH dans un environnement de laboratoire où les machines peuvent être recréées fréquemment.

Une connexion réussie confirme que :

* la VM est accessible sur le réseau
* la configuration SSH fonctionne correctement
* le système d’exploitation est opérationnel

<img width="1048" height="288" alt="umbuntu" src="https://github.com/user-attachments/assets/9c7dbd4d-ff8b-4b62-a75e-2dcc34097ae7" />

---

## 7. Installation d’un service web (NGINX)

Commandes exécutées :

```bash
sudo apt update
sudo apt install nginx -y
```

### Explication

L’installation de NGINX permet de démontrer que la machine virtuelle fonctionne normalement après le déploiement.

Cette étape confirme que :

* les mises à jour peuvent être téléchargées
* les paquets peuvent être installés
* le système est pleinement fonctionnel
  
<img width="1300" height="690" alt="sudo" src="https://github.com/user-attachments/assets/8f9c257a-9363-4ba2-806e-a7d132963d8c" />



---

## 8. Démarrage du service NGINX

Commande exécutée :

```bash
sudo systemctl start nginx
```

Vérification finale via navigateur

Accès depuis un navigateur :

```
http://10.7.237.223:80
```

L’affichage de la page par défaut de NGINX confirme que :

* le service web est actif
* le port 80 est accessible
* la configuration réseau est correcte

Cela valide que l’infrastructure déployée via OpenTofu est pleinement opérationnelle.


<img width="1918" height="975" alt="final" src="https://github.com/user-attachments/assets/bb2ab910-a0f2-4594-ac4a-324fdd3a1df7" />


---

## Structure du dépôt

```
3.IaC/
 └── 300151970/
      ├── README.md
      ├── main.tf
      ├── provider.tf
      ├── variables.tf
      └── images/
           ├── 01-tofu-version.png
           ├── 02-tofu-init.png
           ├── 03-tofu-plan.png
           ├── 04-tofu-apply.png
           ├── 05-proxmox-vm.png
           ├── 06-ssh-connection.png
           ├── 07-nginx-install.png
           ├── 08-nginx-start.png
           └----nginx-web.png
```

---

## Conclusion

Ce projet m’a permis de mettre en pratique le principe d’Infrastructure as Code en automatisant entièrement la création d’une machine virtuelle sur Proxmox.

Grâce à OpenTofu :

* l’infrastructure est décrite sous forme de code
* le déploiement est reproductible
* les erreurs humaines sont réduites
* la gestion devient plus efficace

Toutes les étapes ont été validées avec succès :
création de la VM, accès SSH, installation d’un service et validation via navigateur.

Le travail demandé est donc complété et fonctionnel.















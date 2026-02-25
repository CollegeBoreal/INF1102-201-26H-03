## 1. Vérification de l’installation d’OpenTofu

Commande exécutée :

tofu version

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

📸 **Insérer ici la capture d’écran de `tofu init`**
Nom du fichier recommandé :
`images/02-tofu-init.png`

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

📸 **Insérer ici la capture d’écran de `tofu plan`**
Nom du fichier recommandé :
`images/03-tofu-plan.png`

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

📸 **Insérer ici la capture d’écran de `tofu apply`**
Nom du fichier recommandé :
`images/04-tofu-apply.png`

---

## 5. Vérification dans l’interface Proxmox

Une fois le déploiement terminé, j’ai vérifié dans l’interface web de Proxmox que la machine virtuelle a bien été créée.

Points vérifiés :

* la VM apparaît dans la liste
* elle est en état *running*
* les ressources correspondent à la configuration définie

Cette vérification confirme le succès du déploiement automatisé.

📸 **Insérer ici la capture de la VM visible dans Proxmox**
Nom du fichier recommandé :
`images/05-proxmox-vm.png`

---

## 6. Connexion à la machine virtuelle via SSH

Commande utilisée :

```bash
ssh -i ~/.ssh/ma_cle.pk \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
  ubuntu@10.7.237.200
```

### Explication

Cette commande permet de se connecter à la machine virtuelle à l’aide d’une clé privée.

Les options supplémentaires sont utilisées afin d’éviter les blocages liés aux empreintes SSH dans un environnement de laboratoire où les machines peuvent être recréées fréquemment.

Une connexion réussie confirme que :

* la VM est accessible sur le réseau
* la configuration SSH fonctionne correctement
* le système d’exploitation est opérationnel

📸 **Insérer ici la capture de la connexion SSH réussie**
Nom du fichier recommandé :
`images/06-ssh-connection.png`

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

📸 **Insérer ici la capture de l’installation de NGINX**
Nom du fichier recommandé :
`images/07-nginx-install.png`

---

## 8. Démarrage du service NGINX

Commande exécutée :

```bash
sudo systemctl start nginx
```

Cette commande démarre le service NGINX afin qu’il écoute sur le port 80.

📸 **Insérer ici la capture du démarrage ou du status du service**
Nom du fichier recommandé :
`images/08-nginx-start.png`

---

## 9. Vérification finale via navigateur

Accès depuis un navigateur :

```
http://10.7.237.200:80
```

L’affichage de la page par défaut de NGINX confirme que :

* le service web est actif
* le port 80 est accessible
* la configuration réseau est correcte

Cela valide que l’infrastructure déployée via OpenTofu est pleinement opérationnelle.

📸 **Insérer ici la capture de la page web NGINX affichée**
Nom du fichier recommandé :
`images/09-nginx-web.png`

---

## Structure du dépôt recommandée

```
3.IaC/
 └── VOTRE_ID/
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
           └── 09-nginx-web.png
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

---

Si tu veux, je peux maintenant vérifier :

* que ton dossier respecte exactement ce que le prof attend
* que tu n’as rien oublié pour sécuriser le 100%
* ou t’aider à faire un dernier check avant push GitHub 🚀





<details>
  
  ```powershell
  tofu version
  ```
Rôle :
Vérifie que OpenTofu est correctement installé sur ma machine et que le provider Proxmox est disponible.
Cela prouve que l’environnement IaC est prêt.
</details>



📸 Capture 2 — tofu init
tofu init
Rôle :
Initialise le projet IaC :

télécharge le provider telmate/proxmox

prépare le dossier pour communiquer avec l’API Proxmox

Sans cette étape, OpenTofu ne peut pas fonctionner.

📸 Capture 3 — tofu plan
tofu plan
Rôle :
Affiche ce que OpenTofu va créer sans encore l’exécuter.
On voit que la ressource proxmox_vm_qemu.vm1 sera créée.
Cela permet de valider que le code est correct avant le déploiement.

📸 Capture 4 — tofu apply
tofu apply
Rôle :
Déploie réellement la machine virtuelle sur Proxmox via l’API.
Cette étape transforme le code en infrastructure réelle.

📸 Capture 5 — VM visible dans l’interface Proxmox
Rôle :
Prouve que la VM a été créée automatiquement par OpenTofu et non manuellement.

📸 Capture 6 — Onglet Cloud-Init / Summary (IP de la VM)
Rôle :
Montre que l’adresse IP configurée dans terraform.tfvars a été appliquée automatiquement grâce à Cloud-Init.

📸 Capture 7 — Connexion SSH réussie
ssh -i ~/.ssh/ma_cle.pk ubuntu@IP
Rôle :
Prouve que :

la VM fonctionne

les clés SSH ont été injectées automatiquement par OpenTofu

aucun mot de passe n’a été configuré manuellement

📸 Capture 8 — cloud-init status
cloud-init status
Rôle :
Confirme que la configuration automatique de la VM par Cloud-Init s’est terminée correctement (status: done).

📸 Capture 9 — Vérification CPU et RAM
lscpu
free -h
Rôle :
Montre que les ressources (CPU, RAM) correspondent exactement à celles définies dans le fichier main.tf.
Preuve que la configuration vient du code IaC.

📸 Capture 10 — Clés SSH injectées
cat ~/.ssh/authorized_keys

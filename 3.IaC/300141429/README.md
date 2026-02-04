#commande tofu version
<details>

  ```powershell
  (base) PS C:\WINDOWS\system32> tofu version
OpenTofu v1.11.4
on windows_amd64
  ```
</details>
Rôle :
Vérifie que OpenTofu est correctement installé sur ma machine et que le provider Proxmox est disponible.
Cela prouve que l’environnement IaC est prêt.



tofu init
Rôle :
Initialise le projet IaC :

télécharge le provider telmate/proxmox

prépare le dossier pour communiquer avec l’API Proxmox
Sans cette étape, OpenTofu ne peut pas fonctionner.

<img width="601" height="238" alt="image" src="https://github.com/user-attachments/assets/186d514e-a825-4193-9cf1-5342bd11e201" />



tofu plan
Rôle :
Affiche ce que OpenTofu va créer sans encore l’exécuter.
On voit que la ressource proxmox_vm_qemu.vm1 sera créée.
Cela permet de valider que le code est correct avant le déploiement.
<img width="826" height="455" alt="image" src="https://github.com/user-attachments/assets/49f7ddaf-b8d2-4839-b838-cc2072c917e1" />


📸 Capture 4 — tofu apply
tofu apply
Rôle :
Déploie réellement la machine virtuelle sur Proxmox via l’API.
Cette étape transforme le code en infrastructure réelle.
<img width="827" height="459" alt="image" src="https://github.com/user-attachments/assets/9ae4584d-6763-4a2a-927b-e9ec773ddff3" />


Verification de mon VM sur proxmox
<img width="1906" height="655" alt="image" src="https://github.com/user-attachments/assets/c69e23e4-6e47-41a7-9761-eff47b8d25fb" />

#verification d'acces a mon serveur via ssh avec:
ssh -i ~/.ssh/ma_cle.pk `
  -o StrictHostKeyChecking=no `
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty `
  ubuntu@10.7.237.200

Cette commande se connecte en SSH à la VM avec une clé privée tout en désactivant les vérifications d’empreinte pour éviter les blocages dans un lab où les VMs sont recréées souvent.

<img width="309" height="218" alt="image" src="https://github.com/user-attachments/assets/274ef884-5bac-4392-8f5a-8f44aebda091" />






# commandes:
sudo apt update
sudo apt install nginx -y

Il permet d'installer un service réel dans la VM pour démontrer qu’elle est pleinement fonctionnelle après le déploiement IaC.

<img width="473" height="187" alt="image" src="https://github.com/user-attachments/assets/88479a07-39f4-42c0-a4ce-d49fe9dc9bc1" />

# commande: systemctl status nginx
Rôle :
Prouve que le service web est actif








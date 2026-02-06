# My projet IaC with OpenTofu

```powershell
tofu version
```
<details>

  ```powershell
(base) PS C:\Users\zouma> tofu version
OpenTofu v1.11.4
on windows_amd64
  ```

</details>

Objectif:
Vérifiez que OpenTofu est correctement installer sur ma machine et que le provider Proxmox est disponible.
Donc ca prouve que l’environnement IaC est prêt.

```powershell
tofu init
```
Objectif:
Initialiser le projet IaC :

télécharge le provider telmate/proxmox

préparer le dossier pour communiquer avec l’API Proxmox
Sans cette étape, OpenTofu ne peut pas fonctionner.
<img width="1016" height="442" alt="tofu init png" src="https://github.com/user-attachments/assets/19f322f0-0d0e-43ff-9ea5-da0b39d219cc" />

```powershell
tofu plan
```
Objectif:
Affiche ce que OpenTofu va créer sans encore l’exécuter.
On observe  que la ressource proxmox_vm_qemu.vm1 sera créée.
Cela permet de valider que le code est correct avant le déploiement.
<img width="1918" height="927" alt="tufo plan png" src="https://github.com/user-attachments/assets/b9374044-50a0-40db-9fb7-2ead27a8f073" />

```powershell
tofu apply
```

Objectif:
C’est de déploier réellement la machine virtuelle sur Proxmox via l’API.
Cette étape transforme le code en infrastructure réelle.
<img width="1593" height="371" alt="tufo apply png" src="https://github.com/user-attachments/assets/9993c96b-25a8-4134-b072-c7f856e221bf" />
```powershell
Verification de mon VM sur proxmox
```

<img width="1918" height="1011" alt="Verifier VM png" src="https://github.com/user-attachments/assets/7a2e74cb-6260-4d3b-b633-6c5febdd6673" />


#verifier l'acces a mon serveur via ssh

```powershell
 ssh -i ~/.ssh/ma_cle.pk `
>>   -o StrictHostKeyChecking=no `
>>   -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty `
>>   ubuntu@10.7.237.212

```
<img width="1025" height="742" alt="connection ssh png" src="https://github.com/user-attachments/assets/034c181b-609e-40ad-9157-18f4967217da" />

#Les commandes sont ci-dessous:
```powershell
sudo apt update
sudo apt install nginx -y
```
#Cela permet d'installer un service réel dans la VM pour démontrer qu’elle est pleinement fonctionnelle après le déploiement IaC.

<img width="1335" height="881" alt="install ngnix png" src="https://github.com/user-attachments/assets/95265db2-7484-4cf6-be1c-0db0e23db3b9" />

# La commande:
```powershell
systemctl start nginx
```
systemctl start nginx permet de démarrer le service ngnix pour lancer le serveur web sur la machine.


```powershell
#Effectuions un test  finale surla page web nginx.
```
<img width="1710" height="557" alt="welcom ngnix png" src="https://github.com/user-attachments/assets/d1bcef48-3d1b-47c4-afae-21a0e38d8113" />






```powershell
tofu version
```
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


```powershell
tofu init
```
Rôle :
Initialise le projet IaC :

télécharge le provider telmate/proxmox

prépare le dossier pour communiquer avec l’API Proxmox
Sans cette étape, OpenTofu ne peut pas fonctionner.

<img width="1835" height="532" alt="image" src="https://github.com/user-attachments/assets/ad200afb-8a07-4a8d-82ba-a17decf558e3" />



```powershell
tofu plan
```
Rôle :
Affiche ce que OpenTofu va créer sans encore l’exécuter.
On voit que la ressource proxmox_vm_qemu.vm1 sera créée.
Cela permet de valider que le code est correct avant le déploiement.
<img width="1912" height="1057" alt="image" src="https://github.com/user-attachments/assets/5bca7546-c6c3-4941-b23f-cc4c32e273b5" />

<img width="1865" height="677" alt="image" src="https://github.com/user-attachments/assets/29519c63-b01c-4ee8-9c12-9d48d83ab57f" />



```powershell
tofu apply
```
Rôle :
Déploie réellement la machine virtuelle sur Proxmox via l’API.
Cette étape transforme le code en infrastructure réelle.
<img width="1912" height="1057" alt="image" src="https://github.com/user-attachments/assets/2a5f3427-8f30-4305-9d10-7669e503b4f5" />
<img width="1300" height="533" alt="image" src="https://github.com/user-attachments/assets/21414a22-0131-41fb-994b-30c49c168c76" />


```powershell
Verification de mon VM sur proxmox
```
<img width="1905" height="775" alt="image" src="https://github.com/user-attachments/assets/3904e450-0b23-4cb8-a45c-4ad5a186ee29" />



#verification d'acces a mon serveur via ssh avec:
```powershell
ssh -i ~/.ssh/ma_cle.pk `
  -o StrictHostKeyChecking=no `
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty `
  ubuntu@10.7.237.199
```

Cette commande se connecte en SSH à la VM avec une clé privée tout en désactivant les vérifications d’empreinte pour éviter les blocages dans un lab où les VMs sont recréées souvent.

<img width="1157" height="217" alt="image" src="https://github.com/user-attachments/assets/aeec5995-482e-40b4-bd9a-3561867d9ea0" />




# commandes:
```powershell
sudo apt update
sudo apt install nginx -y
```

Il permet d'installer un service réel dans la VM pour démontrer qu’elle est pleinement fonctionnelle après le déploiement IaC.

<img width="1892" height="492" alt="image" src="https://github.com/user-attachments/assets/333da6d9-3a34-4cea-b7ee-c3a17876bf7e" />


# commande:
```powershell
systemctl start nginx
```
systemctl start nginx démarre le service NGINX pour lancer le serveur web sur la machine.

```powershell
Verification finale de la page web nginx mon ip et le port 80 : 10.7.237.200:80
```
<img width="1208" height="392" alt="image" src="https://github.com/user-attachments/assets/4affa230-f27e-48f8-8d4a-d993bcac8c8d" />


Cela montre que le travail demande est effectue avec succes















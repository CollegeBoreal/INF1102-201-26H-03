# Voici le travail


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
#Terraform.tfvars
``` lua
pm_vm_name      = "vm300147629"
pm_ipconfig0    = "ip=10.7.237.212/23,gw=10.7.237.1"
pm_nameserver   = "10.7.237.3"
pm_url          = "https://10.7.237.13:8006/api2/json"
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "55dccf39-a3db-4bad-8a28-954addb13739"
sshkeys = [
  file("~/.ssh/ma_cle.pub"),
  file("~/.ssh/cle_publique_du_prof.pub")
```


 Voir si OpenTofu  est installer sur Vm
 
```powershell
tofu init
```
<img width="1016" height="442" alt="tofu init png" src="https://github.com/user-attachments/assets/19f322f0-0d0e-43ff-9ea5-da0b39d219cc" />

```powershell
tofu plan
```
Le déploiement.
<img width="1918" height="927" alt="tufo plan png" src="https://github.com/user-attachments/assets/b9374044-50a0-40db-9fb7-2ead27a8f073" />

```powershell
tofu apply
```
Déploier la machine virtuelle sur Proxmox
<img width="1593" height="371" alt="tufo apply png" src="https://github.com/user-attachments/assets/9993c96b-25a8-4134-b072-c7f856e221bf" />
```powershell
Verification Vm sur proxmox
```

<img width="1918" height="1011" alt="Verifier VM png" src="https://github.com/user-attachments/assets/7a2e74cb-6260-4d3b-b633-6c5febdd6673" />


#verification l'acces au serveur avec  ssh 

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
#D'installation nginx sur Vm.

<img width="1335" height="881" alt="install ngnix png" src="https://github.com/user-attachments/assets/95265db2-7484-4cf6-be1c-0db0e23db3b9" />

# La commande:
```powershell
systemctl start nginx
```
systemctl start nginx  démarre le service ngnix 

```powershell
#Resultat du test.
```
<img width="1710" height="557" alt="welcom ngnix png" src="https://github.com/user-attachments/assets/d1bcef48-3d1b-47c4-afae-21a0e38d8113" />






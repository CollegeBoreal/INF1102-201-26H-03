# 🎌 Proxmox

### **Proxmox VE (Virtual Environment) 🌐💻**

**Proxmox** est une **plateforme open-source 🆓** qui permet de **virtualiser des serveurs 🖥️**.
Avec Proxmox, tu peux créer, gérer et surveiller à la fois :

* des **machines virtuelles (VMs) 🖥️➡️🖥️**
* des **containers légers 🐳**

Il est basé sur **Linux Debian 🐧** et combine plusieurs technologies de virtualisation dans **un seul environnement centralisé 🗂️**.

---

### **1. Définition**

**Proxmox VE (Virtual Environment)** est une **plateforme open-source de virtualisation** qui permet de créer, gérer et superviser des **machines virtuelles (VMs) et des containers** sur un serveur physique.
Il est basé sur **Debian Linux** et combine plusieurs technologies de virtualisation dans un seul environnement.

---

### **2. Ses composants principaux**

1. **Hyperviseur** :

   * Proxmox utilise **KVM** pour la virtualisation complète des machines (VMs) et **LXC** pour les containers légers.
   * KVM = Hyperviseur type 1 intégré au noyau Linux.
   * LXC = Conteneurs Linux isolés, plus légers qu’une VM complète.

2. **Interface Web (GUI)** :

   * Proxmox fournit une **interface web complète** pour créer, gérer et surveiller vos VMs et containers, sans passer par la ligne de commande.

3. **Services intégrés** :

   * Gestion des snapshots, backups et restauration.
   * Réplication et haute disponibilité (HA).
   * Gestion de stockage local et distant (ZFS, Ceph, NFS, etc.).

4. **API et outils CLI** :

   * Vous pouvez automatiser les tâches avec l’**API REST** ou les commandes en ligne (`pve*`).

---

### **3. Avantages**

* **Open-source** et gratuit (avec option d’abonnement pour support officiel).
* **Gestion centralisée** de plusieurs serveurs Proxmox (cluster).
* Supporte **KVM + LXC** dans un seul outil.
* **Snapshots, backups et migration à chaud** des VMs.

---

### **4. Comparaison simple**

| Proxmox       | VMware ESXi       | VirtualBox    |
| ------------- | ----------------- | ------------- |
| Open-source   | Propriétaire      | Open-source   |
| Serveur Linux | Hyperviseur dédié | Desktop/local |
| KVM + LXC     | VM uniquement     | VM uniquement |
| Cluster et HA | Oui               | Non           |


## 1️⃣ Les services Proxmox essentiels (qui fait quoi)

### 🧠 Cœur Proxmox

| Service        | Rôle                                           |
| -------------- | ---------------------------------------------- |
| `pve-cluster`  | Gère la config partagée (`/etc/pve`)           |
| `pvedaemon`    | API backend (création VM, permissions, tâches) |
| `pveproxy`     | Interface Web (HTTPS :8006)                    |
| `pvestatd`     | Stats CPU/RAM/disques                          |
| `pve-firewall` | Pare-feu Proxmox                               |

👉 **Sans `pve-cluster`, Proxmox est cassé** (même en mono-nœud).

---

### 🖥️ Virtualisation

| Service       | Rôle                       |
| ------------- | -------------------------- |
| `qemu-server` | Gestion des VM KVM         |
| `lxc`         | Gestion des conteneurs LXC |
| `ksmtuned`    | Optimisation mémoire       |

---

### 🌐 Cluster (si applicable)

| Service    | Rôle                              |
| ---------- | --------------------------------- |
| `corosync` | Communication entre nœuds         |
| `pmxcfs`   | FS cluster (monté sur `/etc/pve`) |

---

## 2️⃣ Proxmox est-il un *service systemd* ?

👉 **Non**, Proxmox **n’est pas un service unique**, mais une **suite de services systemd**.

Il n’existe PAS :

```bash
systemctl restart proxmox ❌
```

Mais OUI :

```bash
systemctl restart pveproxy
```

---

## 3️⃣ Redémarrage propre (sans arrêter les VM)

### 🔄 Redémarrer uniquement l’interface Web

```bash
systemctl restart pveproxy
```

✔️ Aucun impact sur les VM

---

### 🔄 Redémarrer les services Proxmox (safe)

```bash
systemctl restart pvedaemon
systemctl restart pvestatd
systemctl restart pveproxy
```

✔️ Les VM continuent de tourner

---

### ⚠️ Redémarrage plus lourd (attention)

```bash
systemctl restart pve-cluster
```

⚠️ Peut bloquer l’UI temporairement
⚠️ À éviter en prod si cluster actif

---

## 4️⃣ Vérifier l’état global

```bash
systemctl list-units --type=service | grep pve
```
<details>

```lua
  pve-cluster.service                loaded active running The Proxmox VE cluster filesystem
  pve-firewall.service               loaded active running Proxmox VE firewall
  pve-guests.service                 loaded active exited  PVE guests
  pve-ha-crm.service                 loaded active running PVE Cluster HA Resource Manager Daemon
  pve-ha-lrm.service                 loaded active running PVE Local HA Resource Manager Daemon
  pve-lxc-syscalld.service           loaded active running Proxmox VE LXC Syscall Daemon
  pvebanner.service                  loaded active exited  Proxmox VE Login Banner
  pvedaemon.service                  loaded active running PVE API Daemon
  pvefw-logger.service               loaded active running Proxmox VE firewall logger
  pvenetcommit.service               loaded active exited  Commit Proxmox VE network changes
  pveproxy.service                   loaded active running PVE API Proxy Server
  pvescheduler.service               loaded active running Proxmox VE scheduler
  pvestatd.service                   loaded active running PVE Status Daemon
```
  
</details>

Ou plus ciblé :

```bash
systemctl status pveproxy pvedaemon pve-cluster
```
<details>

```lua
● pveproxy.service - PVE API Proxy Server
     Loaded: loaded (/lib/systemd/system/pveproxy.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2026-02-04 23:55:51 EST; 18h ago
    Process: 1572964 ExecStartPre=/usr/bin/pvecm updatecerts --silent (code=exited, status=0/SUCCESS)
    Process: 1572966 ExecStart=/usr/bin/pveproxy start (code=exited, status=0/SUCCESS)
    Process: 1573652 ExecReload=/usr/bin/pveproxy restart (code=exited, status=0/SUCCESS)
   Main PID: 1572967 (pveproxy)
      Tasks: 4 (limit: 77175)
     Memory: 224.6M
        CPU: 3min 14.648s
     CGroup: /system.slice/pveproxy.service
             ├─1572967 pveproxy
             ├─1718755 pveproxy worker
             ├─1730495 pveproxy worker
             └─1734182 pveproxy worker

Feb 05 14:15:36 labinfo pveproxy[1572967]: starting 1 worker(s)
Feb 05 14:15:36 labinfo pveproxy[1572967]: worker 1718755 started
Feb 05 15:19:45 labinfo pveproxy[1715532]: worker exit
Feb 05 15:19:45 labinfo pveproxy[1572967]: worker 1715532 finished
Feb 05 15:19:45 labinfo pveproxy[1572967]: starting 1 worker(s)
Feb 05 15:19:45 labinfo pveproxy[1572967]: worker 1730495 started
Feb 05 15:41:03 labinfo pveproxy[1718592]: worker exit
Feb 05 15:41:03 labinfo pveproxy[1572967]: worker 1718592 finished
Feb 05 15:41:03 labinfo pveproxy[1572967]: starting 1 worker(s)
Feb 05 15:41:03 labinfo pveproxy[1572967]: worker 1734182 started

● pvedaemon.service - PVE API Daemon
     Loaded: loaded (/lib/systemd/system/pvedaemon.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2026-02-04 23:55:49 EST; 18h ago
    Process: 1572958 ExecStart=/usr/bin/pvedaemon start (code=exited, status=0/SUCCESS)
   Main PID: 1572960 (pvedaemon)
      Tasks: 4 (limit: 77175)
     Memory: 224.2M
        CPU: 5min 24.741s
     CGroup: /system.slice/pvedaemon.service
             ├─1572960 pvedaemon
             ├─1657260 pvedaemon worker
             ├─1658835 pvedaemon worker
             └─1718468 pvedaemon worker

Feb 05 14:39:50 labinfo pvedaemon[1657260]: <tofu@pve!opentofu> starting task UPID:labinfo:001A4C86:049F7F20:6984F206:qmshutdown:100:tofu@pve!opentofu:
Feb 05 14:39:56 labinfo pvedaemon[1657260]: <tofu@pve!opentofu> end task UPID:labinfo:001A4C86:049F7F20:6984F206:qmshutdown:100:tofu@pve!opentofu: OK
Feb 05 14:39:56 labinfo pvedaemon[1723581]: start VM 100: UPID:labinfo:001A4CBD:049F8181:6984F20C:qmstart:100:tofu@pve!opentofu:
Feb 05 14:39:56 labinfo pvedaemon[1718468]: <tofu@pve!opentofu> starting task UPID:labinfo:001A4CBD:049F8181:6984F20C:qmstart:100:tofu@pve!opentofu:
Feb 05 14:39:57 labinfo pvedaemon[1718468]: <tofu@pve!opentofu> end task UPID:labinfo:001A4CBD:049F8181:6984F20C:qmstart:100:tofu@pve!opentofu: OK
Feb 05 14:56:13 labinfo pvedaemon[1658835]: <root@pam> successful auth for user 'root@pam'
Feb 05 15:08:39 labinfo pvedaemon[1718468]: <root@pam> successful auth for user 'root@pam'
Feb 05 15:11:13 labinfo pvedaemon[1718468]: <root@pam> successful auth for user 'root@pam'
Feb 05 15:26:14 labinfo pvedaemon[1657260]: <root@pam> successful auth for user 'root@pam'
Feb 05 15:41:15 labinfo pvedaemon[1657260]: <root@pam> successful auth for user 'root@pam'

● pve-cluster.service - The Proxmox VE cluster filesystem
     Loaded: loaded (/lib/systemd/system/pve-cluster.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2026-01-27 15:13:06 EST; 1 weeks 2 days ago
    Process: 978 ExecStart=/usr/bin/pmxcfs (code=exited, status=0/SUCCESS)
   Main PID: 1016 (pmxcfs)
      Tasks: 9 (limit: 77175)
     Memory: 66.5M
        CPU: 7min 19.075s
     CGroup: /system.slice/pve-cluster.service
             └─1016 /usr/bin/pmxcfs

Jan 27 15:13:05 labinfo systemd[1]: Starting The Proxmox VE cluster filesystem...
Jan 27 15:13:06 labinfo systemd[1]: Started The Proxmox VE cluster filesystem.
```
  
</details>

---

## 5️⃣ Phrase parfaite pour un examen 💯

> *Proxmox VE est une plateforme de virtualisation basée sur Debian qui repose sur plusieurs services systemd, notamment pve-cluster, pvedaemon et pveproxy, permettant la gestion des machines virtuelles, des conteneurs et du clustering.*

---

## 🈷️ Problème de connection root UI

Tu as un problème pour te connecter à l’interface web de Proxmox en tant que **root**. La commande que tu montres :

```bash
systemctl restart pveproxy pvedaemon
```

**fait partie de la procédure**, mais voyons un peu plus en détail pour corriger ton problème de connexion root UI.

---

### Étapes de diagnostic et correction

1. **Vérifier que les services essentiels tournent :**

```bash
systemctl status pveproxy
systemctl status pvedaemon
systemctl status pve-cluster
systemctl status corosync   # si cluster
```

* `pveproxy` → sert l’interface web.
* `pvedaemon` → gère les tâches et l’authentification.
* `pve-cluster` → stocke la configuration.
* `corosync` → uniquement si tu as un cluster.

Si l’un est **inactive** ou **failed**, tu peux le redémarrer :

```bash
systemctl restart pveproxy pvedaemon pve-cluster
```

---

2. **Vérifier la connexion root**

* Assure-toi que tu utilises **root@pam** ou **root@pve** correctement dans l’UI.
* Exemple :

  * **Utilisateur :** `root@pam`
  * **Mot de passe :** celui défini avec `passwd root`

Si tu veux **changer le mot de passe root** :

```bash
passwd root
```

⚠️ Si tu as essayé `pveum passwd root@pve` et que ça ne fonctionne pas, utilise plutôt :

```bash
pveum user list   # pour lister les users
pveum passwd root@pam
```

---

3. **Vérifier le certificat SSL (si nécessaire)**

Si l’UI te refuse la connexion, parfois c’est dû au certificat auto-signé :

```bash
ls -l /etc/pve/local/pve-ssl.*
```

Tu peux régénérer le certificat :

```bash
pvecm updatecerts
systemctl restart pveproxy
```

---

4. **Vérifier les logs**

Si après tout ça ça ne marche toujours pas :

```bash
journalctl -u pveproxy -f
journalctl -u pvedaemon -f
```

Ça te donnera la raison exacte de l’échec (mot de passe, permission, SSL, etc.).

# :books: References 

---

##  Prereqs on Proxmox (PVE 7) (Déjâ fait sur le serveur)

### ✔ Enable API access

You need either:

* a **user + password**, or
* **API token** (recommended)

**Recommended (API token):**

```bash
pveum user add tofu@pve
pveum aclmod / -user tofu@pve -role Administrator
pveum user token add tofu@pve opentofu --privsep 0
```

Save:

* **Token ID**: `tofu@pve!opentofu`
* **Token Secret**: (shown once)

## refresh Token

```bash
pveum user token remove tofu@pve opentofu
```

```bash
pveum user token add tofu@pve opentofu --privsep 0
```
```lua
user config - ignore invalid acl token 'tofu@pve!opentofu'
┌──────────────┬──────────────────────────────────────┐
│ key          │ value                                │
╞══════════════╪══════════════════════════════════════╡
│ full-tokenid │ tofu@pve!opentofu                    │
├──────────────┼──────────────────────────────────────┤
│ info         │ {"privsep":"0"}                      │
├──────────────┼──────────────────────────────────────┤
│ value        │ 63cd5a0b-2xxxxxxxxxxxxx-993a2d9de8dd │
└──────────────┴──────────────────────────────────────┘
```

---

### ✔ Create VM Template (cloud-init_template.sh)

```lua
# Download cloud image
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# Create VM
qm create 9000 --name ubuntu-jammy-template --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0

# Import disk
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm

# Attach disk
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0

# Cloud-init disk
qm set 9000 --ide2 local-lvm:cloudinit

# Boot settings
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0

# Convert to template
qm template 9000
```

## 🏗️ Installation

- [ ] [💻 Proxmox VE Installation – HP ProLiant DL360 G6](https://github.com/CollegeBoreal/Laboratoires/tree/main/D.DC/S.Servers/Proliant/Proxmox)


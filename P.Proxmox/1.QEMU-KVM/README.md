# 🐦‍⬛ [QEMU](https://www.qemu.org) (Quick EMUlator)

QEMU, c’est **un émulateur et virtualiseur open-source**. Dit simplement : il permet de faire tourner **un système d’exploitation dans un autre**, comme une machine virtuelle.

Un peu plus clair 👇

## 🧠 QEMU, à quoi ça sert ?

QEMU peut :

* **Émuler** du matériel (CPU, carte réseau, disque, etc.)
* **Virtualiser** des machines complètes quand il est combiné avec **KVM** (sur Linux)

Avec QEMU, tu peux par exemple :

* Lancer **Linux sur Windows ou macOS**
* Tester un OS sans toucher à ta machine
* Simuler une autre architecture CPU (ARM, PowerPC, RISC-V…)

---

### ⚙️ Émulation vs Virtualisation

C’est la distinction clé :

* **Émulation (QEMU seul)**
  👉 Peut imiter *n’importe quel processeur*
  ❌ Lent (tout est traduit en logiciel)

* **Virtualisation (QEMU + KVM)**
  👉 Utilise le CPU réel
  ✅ Très rapide (quasi natif)
  ❌ Nécessite un CPU compatible + Linux

> Dans Proxmox, quand tu vois `qemu-system-x86_64`, c’est QEMU **avec KVM activé**.

---

### 🧱 Type d’hyperviseur

* **QEMU + KVM = hyperviseur de type 1 (bare-metal)** ✅
* **QEMU seul = pas vraiment un hyperviseur** (émulation pure) ❌

---

### 🔍 Pourquoi QEMU + KVM est un hyperviseur ?

Quand QEMU utilise **KVM (Kernel-based Virtual Machine)** :

* Le **noyau Linux** devient l’hyperviseur
* QEMU fournit le **matériel virtuel** (CPU, disque, réseau, BIOS/UEFI…)
* Les VM s’exécutent **directement sur le CPU** (Intel VT-x / AMD-V)

👉 C’est exactement ce que fait **Proxmox VE**.

---

### 📊 Comparaison rapide

| Solution             | Type               | Rôle                      |
| -------------------- | ------------------ | ------------------------- |
| **QEMU seul**        | Émulateur          | Simule le matériel (lent) |
| **KVM (dans Linux)** | Hyperviseur type 1 | Exécute les VM            |
| **QEMU + KVM**       | Hyperviseur type 1 | Stack complet             |
| VMware ESXi          | Type 1             | Bare-metal                |
| VirtualBox           | Type 2             | Sur OS hôte               |

---

### 🧠 Dans Proxmox (important)

Quand tu crées une VM :

* Proxmox appelle `qemu-system-*`
* KVM est activé (`-enable-kvm`)
* Le noyau Linux **planifie les vCPU**
* QEMU gère les périphériques virtuels

👉 Tu **n’installes pas QEMU dans la VM** : c’est l’hôte qui l’utilise.

---

### 🧩 Phrase clé à retenir

> **QEMU n’est un hyperviseur que lorsqu’il est combiné à KVM ; seul, c’est un émulateur.**

---

### 🧩 QEMU dans l’écosystème

* **Proxmox** → utilise QEMU/KVM pour les VM
* **libvirt / virt-manager** → pilotent QEMU
* **Docker / Podman** → pas QEMU (conteneurs ≠ VM)
* **UTM / Lima / Colima (macOS)** → basés sur QEMU

---

### 🧪 En une phrase

> **QEMU est le moteur qui fait tourner les machines virtuelles**, et avec KVM, il devient aussi rapide qu’un hyperviseur « pro ».

Si tu veux, je peux te l’expliquer **dans le contexte précis de Proxmox**, ou te faire un **schéma VM vs conteneur** pour tes étudiants 👀

## ⚙️ Manipulation 

### 🔹 Gestion générale des VM

```bash
qm list
```

Liste toutes les VM et templates.

```bash
qm status <VMID>
```

Affiche l’état d’une VM (running, stopped).

```bash
qm config <VMID>
```

Affiche la configuration complète d’une VM.

---

### 🔹 Création et suppression

```bash
qm create <VMID> [options]
```

Crée une VM vide.

```bash
qm destroy <VMID>
```

Supprime une VM (sans purge).

```bash
qm destroy <VMID> --purge
```

Supprime la VM **et** toutes les références associées (disques, config).

```bash
qm clone <SRC_VMID> <NEW_VMID> [options]
```

Clone une VM ou un template.

```bash
qm template <VMID>
```

Convertit une VM en **template**.

---

### 🔹 Démarrage / arrêt

```bash
qm start <VMID>
```

```bash
qm stop <VMID>
```

```bash
qm shutdown <VMID>
```

Arrêt propre via l’OS invité.

```bash
qm reset <VMID>
```

Redémarrage brutal.

---

### 🔹 Verrous (locks) 🔐

```bash
qm unlock <VMID>
```

Supprime un verrou (clone, snapshot, migrate…).

```bash
qm lock <VMID>
```

Verrouille manuellement une VM (rarement utilisé).

---

### 🔹 Disques

```bash
qm importdisk <VMID> <image> <storage>
```

Importe une image disque (qcow2, raw, img).

```bash
qm importdisk <VMID> <image> <storage> --format raw
```

Importe et convertit en **raw** (recommandé pour LVM-thin).

```bash
qm set <VMID> --scsi0 <storage>:vm-<VMID>-disk-0
```

Attache un disque à la VM.

```bash
qm resize <VMID> scsi0 +10G
```

Agrandit un disque existant.

```bash
qm move_disk <VMID> scsi0 <storage>
```

Déplace un disque vers un autre stockage.

---

### 🔹 Cloud-init ☁️

```bash
qm set <VMID> --ide2 <storage>:cloudinit
```

Ajoute le disque cloud-init.

```bash
qm set <VMID> --ciuser ubuntu
```

```bash
qm set <VMID> --sshkeys ~/.ssh/id_rsa.pub
```

```bash
qm set <VMID> --ipconfig0 ip=dhcp
```

---

### 🔹 Réseau

```bash
qm set <VMID> --net0 virtio,bridge=vmbr0
```

```bash
qm set <VMID> --net1 virtio,bridge=vmbr1
```

---

### 🔹 CPU / Mémoire

```bash
qm set <VMID> --cores 2 --sockets 1
```

```bash
qm set <VMID> --memory 2048
```

```bash
qm set <VMID> --cpu host
```

---

### 🔹 Console / affichage

```bash
qm set <VMID> --serial0 socket --vga serial0
```

```bash
qm terminal <VMID>
```

Ouvre une console série.

---

### 🔹 Snapshots (attention ⚠️)

```bash
qm snapshot <VMID> <name>
```

```bash
qm listsnapshot <VMID>
```

```bash
qm delsnapshot <VMID> <name>
```

⚠️ **À éviter avec LVM-thin + cloud images** si tu clones souvent.

---

### 🔹 Debug & maintenance

```bash
qm showcmd <VMID> --pretty
```

Montre la commande QEMU réelle utilisée.

```bash
qm rescan
```

Rescan des stockages.

---

### 🧠 Commandes LVM utiles avec qm

```bash
lvs
```

```bash
lvs -o+data_percent,metadata_percent
```

```bash
lvremove /dev/pve/vm-XXX-disk-0
```

Supprime manuellement un disque orphelin.

## 🧽 Cleaning Proxmox

A **full summary of all the commands** we discussed for cleaning locks, checking storage, and managing your VMs in Proxmox. I’ll organize them in logical steps:

---

### **1️⃣ Check VM and storage status**

**List all VMs:**

```bash
qm list
```

**Check thin pool and LVM status:**

```bash
vgs
lvs -a
lvs -o+data_percent,metadata_percent
```

---

### **2️⃣ Remove stale Proxmox locks**

**Remove all lock files:**

```bash
rm -f /var/lock/qemu-server/lock-*.conf
```

**Restart Proxmox daemons to flush task state:**

```bash
systemctl restart pvedaemon pveproxy
```

**Verify locks removed:**

```bash
ls /var/lock/qemu-server/
```

* Should return empty.

---

### **3️⃣ Start / stop VMs safely**

**Stop a VM (if running):**

```bash
qm stop <VMID>
```

Example:

```bash
qm stop 102
```

**Start a VM:**

```bash
qm start <VMID>
```

Example:

```bash
qm start 102
```

**Check VM config:**

```bash
qm config <VMID>
```

---

### **4️⃣ Delete VMs permanently**

**Destroy a VM (remove config + disk):**

```bash
qm destroy <VMID> --purge
```

Example:

```bash
qm destroy 100 --purge
qm destroy 101 --purge
qm destroy 102 --purge
```

**Destroy a template (optional):**

```bash
qm destroy 9000
```

**Verify deletion:**

```bash
qm list
```

* Only remaining VMs (if any) will show.

---

### **5️⃣ Optional: Monitor thin pool usage**

**Check data and metadata usage:**

```bash
lvs -o+data_percent,metadata_percent
```

* Watch for **Data% > 85%** or **Meta% > 80%** to avoid LVM issues.

---

#### ✅ Notes / Tips

* Always stop the VM before destroying it.
* Removing stale locks is safe **only when no VM operation is running**.
* Restarting `pvedaemon` + `pveproxy` ensures Proxmox task state is clean.
* For automation tools like OpenTofu / Terraform:

  ```hcl
  terraform { parallelism = 1 }
  ```

  prevents stale locks during parallel cloning.

---

### **1️⃣ `qm` – Gestion des machines virtuelles QEMU/KVM**

Utilisé pour la virtualisation complète (KVM/QEMU).

| Commande                                | Utilité                                       |
| --------------------------------------- | --------------------------------------------- |
| `qm list`                               | Lister toutes les VMs QEMU sur l’hôte Proxmox |
| `qm start <vmid>`                       | Démarrer une VM                               |
| `qm stop <vmid>`                        | Arrêter une VM proprement                     |
| `qm shutdown <vmid>`                    | Envoyer un ACPI shutdown (arrêt logiciel)     |
| `qm reset <vmid>`                       | Redémarrer une VM (comme un power cycle)      |
| `qm destroy <vmid>`                     | Supprimer entièrement une VM                  |
| `qm create <vmid> [options]`            | Créer une nouvelle VM                         |
| `qm set <vmid> [options]`               | Modifier la configuration d’une VM            |
| `qm config <vmid>`                      | Afficher le fichier de configuration d’une VM |
| `qm importdisk <vmid> <disk> <storage>` | Importer un disque dans une VM                |
| `qm resize <vmid> <disk> +<taille>`     | Redimensionner un disque de VM                |
| `qm monitor <vmid>`                     | Ouvrir le monitor QEMU pour debug             |
| `qm terminal <vmid>`                    | Accéder à la console de la VM via le shell    |

---

### **2️⃣ `pct` – Gestion des conteneurs LXC**

Utilisé pour les conteneurs Linux légers.

| Commande                      | Utilité                                      |
| ----------------------------- | -------------------------------------------- |
| `pct list`                    | Lister tous les conteneurs                   |
| `pct start <ctid>`            | Démarrer un conteneur                        |
| `pct stop <ctid>`             | Arrêter un conteneur                         |
| `pct shutdown <ctid>`         | Arrêter proprement un conteneur              |
| `pct create <ctid> [options]` | Créer un nouveau conteneur                   |
| `pct destroy <ctid>`          | Supprimer un conteneur                       |
| `pct enter <ctid>`            | Entrer dans le shell du conteneur            |
| `pct config <ctid>`           | Afficher la configuration du conteneur       |
| `pct mount <ctid>`            | Monter le système de fichiers du conteneur   |
| `pct unmount <ctid>`          | Démonter le système de fichiers du conteneur |

---

### **3️⃣ `pvesh` – CLI de l’API REST Proxmox**

Permet des tâches avancées et l’automatisation via l’API de Proxmox.

| Commande                                          | Utilité                          |
| ------------------------------------------------- | -------------------------------- |
| `pvesh get /nodes`                                | Lister tous les nœuds du cluster |
| `pvesh get /nodes/<node>/qemu`                    | Lister les VMs d’un nœud         |
| `pvesh get /nodes/<node>/lxc`                     | Lister les conteneurs d’un nœud  |
| `pvesh create /nodes/<node>/qemu/<vmid>/snapshot` | Créer un snapshot d’une VM       |
| `pvesh delete /nodes/<node>/qemu/<vmid>`          | Supprimer une VM via l’API       |

---

### ⚠️ Points importants

* Ces commandes **existent uniquement sur un hôte Proxmox VE**, généralement basé sur Debian.
* Elles **gèrent QEMU/KVM et LXC**, mais avec des fonctions spécifiques Proxmox (stockage, snapshots, cluster).

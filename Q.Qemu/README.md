## 🔹 Gestion générale des VM

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

## 🔹 Création et suppression

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

## 🔹 Démarrage / arrêt

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

## 🔹 Verrous (locks) 🔐

```bash
qm unlock <VMID>
```

Supprime un verrou (clone, snapshot, migrate…).

```bash
qm lock <VMID>
```

Verrouille manuellement une VM (rarement utilisé).

---

## 🔹 Disques

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

## 🔹 Cloud-init ☁️

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

## 🔹 Réseau

```bash
qm set <VMID> --net0 virtio,bridge=vmbr0
```

```bash
qm set <VMID> --net1 virtio,bridge=vmbr1
```

---

## 🔹 CPU / Mémoire

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

## 🔹 Console / affichage

```bash
qm set <VMID> --serial0 socket --vga serial0
```

```bash
qm terminal <VMID>
```

Ouvre une console série.

---

## 🔹 Snapshots (attention ⚠️)

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

## 🔹 Debug & maintenance

```bash
qm showcmd <VMID> --pretty
```

Montre la commande QEMU réelle utilisée.

```bash
qm rescan
```

Rescan des stockages.

---

## 🧠 Commandes LVM utiles avec qm

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


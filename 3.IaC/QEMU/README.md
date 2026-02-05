# 🐦‍⬛ [QEMU](https://www.qemu.org) (Quick EMUlator)

A **full summary of all the commands** we discussed for cleaning locks, checking storage, and managing your VMs in Proxmox. I’ll organize them in logical steps:

---

## **1️⃣ Check VM and storage status**

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

## **2️⃣ Remove stale Proxmox locks**

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

## **3️⃣ Start / stop VMs safely**

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

## **4️⃣ Delete VMs permanently**

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

## **5️⃣ Optional: Monitor thin pool usage**

**Check data and metadata usage:**

```bash
lvs -o+data_percent,metadata_percent
```

* Watch for **Data% > 85%** or **Meta% > 80%** to avoid LVM issues.

---

### ✅ Notes / Tips

* Always stop the VM before destroying it.
* Removing stale locks is safe **only when no VM operation is running**.
* Restarting `pvedaemon` + `pveproxy` ensures Proxmox task state is clean.
* For automation tools like OpenTofu / Terraform:

  ```hcl
  terraform { parallelism = 1 }
  ```

  prevents stale locks during parallel cloning.



Alright, let’s do this cleanly and *practically* 🙂
OpenTofu works **almost exactly like Terraform**, and Proxmox VE 7 is well-supported via the **Telmate Proxmox provider**.

Below is a **minimal, working, PVE-7-friendly workflow**.

---

## 0️⃣ Prereqs on Proxmox (PVE 7)

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

---

## 1️⃣ Install OpenTofu

On your workstation:

```bash
curl -fsSL https://get.opentofu.org/install-opentofu.sh | sh
```

Verify:

```bash
tofu version
```

---

## 2️⃣ Create project structure

```bash
mkdir pve-opentofu
cd pve-opentofu
```

```bash
touch provider.tf main.tf variables.tf terraform.tfvars
```

---

## 3️⃣ Provider configuration (`provider.tf`)

```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.pm_url
  pm_api_token_id = var.pm_token_id
  pm_api_token_secret = var.pm_token_secret
  pm_tls_insecure = true
}
```

---

## 4️⃣ VM resource (Cloud-Init VM) (`main.tf`)

Example **Ubuntu VM** cloned from a template:

```hcl
resource "proxmox_vm_qemu" "vm1" {
  name        = "tofu-vm01"
  target_node = "pve"
  clone       = "ubuntu-2204-template"

  cores   = 2
  sockets = 1
  memory  = 2048

  scsihw = "virtio-scsi-pci"

  disk {
    size    = "20G"
    type    = "scsi"
    storage = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  os_type = "cloud-init"

  ipconfig0 = "ip=dhcp"

  ciuser  = "ubuntu"
  sshkeys = file("~/.ssh/id_rsa.pub")
}
```

---

## 5️⃣ Variables (`variables.tf`)

```hcl
variable "pm_token_id" {
  type = string
}

variable "pm_token_secret" {
  type      = string
  sensitive = true
}
```

---

## 6️⃣ Secrets (`terraform.tfvars`)

```hcl
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "PASTE_SECRET_HERE"
```

⚠️ **Do not commit this file**

---

## 7️⃣ Initialize & apply

```bash
tofu init
tofu plan
tofu apply
```

Type `yes`.

🎉 VM will appear in Proxmox.

---

## 8️⃣ Common gotchas (PVE 7 specific)

### ❌ “Clone source does not exist”

➡ You **must create a template first**

Example:

```bash
qm create 9000 --name ubuntu-2204-template
qm set 9000 --scsi0 local-lvm:0,import-from=/var/lib/vz/template/iso/jammy-server-cloudimg-amd64.img
qm template 9000
```

---

### ❌ Cloud-init not working

Make sure:

```bash
qm set VMID --ide2 local-lvm:cloudinit
```

---

## 9️⃣ Advanced (when you’re ready)

You can:

* auto-generate **MAC addresses**
* attach **PCI passthrough**
* define **multiple disks**
* integrate with **Ansible**
* manage **LXC containers**
* create **entire Proxmox clusters declaratively**

---

## TL;DR

* OpenTofu = Terraform replacement ✅
* Telmate Proxmox provider works perfectly on **PVE 7**
* Best approach: **cloud-init template + clone**
* API token is safer than passwords

---

```bash
pveum user add tofu@pve
pveum aclmod / -user tofu@pve -role Administrator
pveum user token add tofu@pve opentofu --privsep 0
┌──────────────┬──────────────────────────────────────┐
│ key          │ value                                │
╞══════════════╪══════════════════════════════════════╡
│ full-tokenid │ tofu@pve!opentofu                    │
├──────────────┼──────────────────────────────────────┤
│ info         │ {"privsep":"0"}                      │
├──────────────┼──────────────────────────────────────┤
│ value        │ 4fa24fc3-bd8c-4916-ba6e-09xxxxxxxx00 │
└──────────────┴──────────────────────────────────────┘
```


```terraform
tofu apply

OpenTofu used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

OpenTofu will perform the following actions:

  # proxmox_vm_qemu.vm1 will be created
  + resource "proxmox_vm_qemu" "vm1" {
      + additional_wait           = 5
      + automatic_reboot          = true
      + balloon                   = 0
      + bios                      = "seabios"
      + boot                      = (known after apply)
      + bootdisk                  = (known after apply)
      + ciuser                    = "ubuntu"
      + clone                     = "ubuntu-jammy-template"
      + clone_wait                = 10
      + cores                     = 2
      + cpu                       = "host"
      + default_ipv4_address      = (known after apply)
      + define_connection_info    = true
      + force_create              = false
      + full_clone                = true
      + guest_agent_ready_timeout = 100
      + hotplug                   = "network,disk,usb"
      + id                        = (known after apply)
      + ipconfig0                 = "ip=dhcp"
      + kvm                       = true
      + memory                    = 2048
      + name                      = "tofu-vm01"
      + nameserver                = (known after apply)
      + onboot                    = false
      + oncreate                  = true
      + os_type                   = "cloud-init"
      + preprovision              = true
      + reboot_required           = (known after apply)
      + scsihw                    = "virtio-scsi-pci"
      + searchdomain              = (known after apply)
      + sockets                   = 1
      + ssh_host                  = (known after apply)
      + ssh_port                  = (known after apply)
      + sshkeys                   = <<-EOT
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2pLhMqFGKffSdYvNCMAyM7598oBY+m/3q5AMXmb7IE6vq42+yGzqEUzZu9WrFckFD4Hq52rIU5DeOvi83DCF3uroXjNTEtCKdi+tY7cV18bHmsDsBHMqTnpuvroofgFWA0Pi++b2kGW2I5eyy1Qjv5rOp7y11Xe6XeZFEz7qQO1/xNiBMJEruG9Xldgooe4hkaOF39qnbqD4ui3LxYaTUTEulstw4wN70dSB8Zu9YQP7A7KU2zIEwJ1aw8whfO1CAM/AVvoDyqMtV8VXoaZSHOBgluMtinQfyyt473S2ZZeJlnmhK0F1gdOhO4SVZNRMj96m30ryYkYBFWvvLRP5N b300098957@ramena
        EOT
      + tablet                    = true
      + target_node               = "labinfo"
      + unused_disk               = (known after apply)
      + vcpus                     = 0
      + vlan                      = -1
      + vmid                      = (known after apply)

      + disk {
          + backup             = true
          + cache              = "none"
          + file               = (known after apply)
          + format             = (known after apply)
          + iops               = 0
          + iops_max           = 0
          + iops_max_length    = 0
          + iops_rd            = 0
          + iops_rd_max        = 0
          + iops_rd_max_length = 0
          + iops_wr            = 0
          + iops_wr_max        = 0
          + iops_wr_max_length = 0
          + iothread           = 0
          + mbps               = 0
          + mbps_rd            = 0
          + mbps_rd_max        = 0
          + mbps_wr            = 0
          + mbps_wr_max        = 0
          + media              = (known after apply)
          + replicate          = 0
          + size               = "20G"
          + slot               = (known after apply)
          + ssd                = 0
          + storage            = "local-lvm"
          + storage_type       = (known after apply)
          + type               = "scsi"
          + volume             = (known after apply)
        }

      + network {
          + bridge    = "vmbr0"
          + firewall  = false
          + link_down = false
          + macaddr   = (known after apply)
          + model     = "virtio"
          + queues    = (known after apply)
          + rate      = (known after apply)
          + tag       = -1
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  OpenTofu will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

proxmox_vm_qemu.vm1: Creating...
proxmox_vm_qemu.vm1: Still creating... [10s elapsed]
proxmox_vm_qemu.vm1: Still creating... [20s elapsed]
proxmox_vm_qemu.vm1: Still creating... [30s elapsed]
proxmox_vm_qemu.vm1: Still creating... [40s elapsed]
proxmox_vm_qemu.vm1: Still creating... [50s elapsed]
proxmox_vm_qemu.vm1: Still creating... [1m0s elapsed]
proxmox_vm_qemu.vm1: Still creating... [1m10s elapsed]
proxmox_vm_qemu.vm1: Still creating... [1m20s elapsed]
proxmox_vm_qemu.vm1: Still creating... [1m30s elapsed]
proxmox_vm_qemu.vm1: Still creating... [1m40s elapsed]
proxmox_vm_qemu.vm1: Still creating... [1m50s elapsed]
proxmox_vm_qemu.vm1: Still creating... [2m0s elapsed]
proxmox_vm_qemu.vm1: Still creating... [2m10s elapsed]
proxmox_vm_qemu.vm1: Still creating... [2m20s elapsed]
proxmox_vm_qemu.vm1: Still creating... [2m30s elapsed]
proxmox_vm_qemu.vm1: Still creating... [2m40s elapsed]
proxmox_vm_qemu.vm1: Still creating... [2m50s elapsed]
proxmox_vm_qemu.vm1: Still creating... [3m0s elapsed]
proxmox_vm_qemu.vm1: Still creating... [3m10s elapsed]
proxmox_vm_qemu.vm1: Still creating... [3m20s elapsed]
proxmox_vm_qemu.vm1: Still creating... [3m30s elapsed]
proxmox_vm_qemu.vm1: Still creating... [3m40s elapsed]
proxmox_vm_qemu.vm1: Still creating... [3m50s elapsed]
proxmox_vm_qemu.vm1: Still creating... [4m0s elapsed]
proxmox_vm_qemu.vm1: Still creating... [4m10s elapsed]
proxmox_vm_qemu.vm1: Still creating... [4m20s elapsed]
proxmox_vm_qemu.vm1: Still creating... [4m30s elapsed]
proxmox_vm_qemu.vm1: Still creating... [4m41s elapsed]
proxmox_vm_qemu.vm1: Still creating... [4m51s elapsed]
proxmox_vm_qemu.vm1: Still creating... [5m1s elapsed]
proxmox_vm_qemu.vm1: Still creating... [5m11s elapsed]
proxmox_vm_qemu.vm1: Still creating... [5m21s elapsed]
proxmox_vm_qemu.vm1: Still creating... [5m31s elapsed]
proxmox_vm_qemu.vm1: Still creating... [5m41s elapsed]
proxmox_vm_qemu.vm1: Still creating... [5m51s elapsed]
proxmox_vm_qemu.vm1: Still creating... [6m1s elapsed]
proxmox_vm_qemu.vm1: Still creating... [6m11s elapsed]
proxmox_vm_qemu.vm1: Still creating... [6m21s elapsed]
proxmox_vm_qemu.vm1: Still creating... [6m31s elapsed]
proxmox_vm_qemu.vm1: Still creating... [6m41s elapsed]
proxmox_vm_qemu.vm1: Still creating... [6m51s elapsed]
proxmox_vm_qemu.vm1: Still creating... [7m1s elapsed]
proxmox_vm_qemu.vm1: Still creating... [7m11s elapsed]
proxmox_vm_qemu.vm1: Still creating... [7m21s elapsed]
proxmox_vm_qemu.vm1: Still creating... [7m31s elapsed]
proxmox_vm_qemu.vm1: Still creating... [7m41s elapsed]
proxmox_vm_qemu.vm1: Still creating... [7m51s elapsed]
proxmox_vm_qemu.vm1: Still creating... [8m1s elapsed]
proxmox_vm_qemu.vm1: Still creating... [8m11s elapsed]
proxmox_vm_qemu.vm1: Still creating... [8m21s elapsed]
proxmox_vm_qemu.vm1: Still creating... [8m31s elapsed]
proxmox_vm_qemu.vm1: Still creating... [8m41s elapsed]
proxmox_vm_qemu.vm1: Still creating... [8m51s elapsed]
proxmox_vm_qemu.vm1: Still creating... [9m1s elapsed]
proxmox_vm_qemu.vm1: Still creating... [9m11s elapsed]
proxmox_vm_qemu.vm1: Still creating... [9m21s elapsed]
proxmox_vm_qemu.vm1: Still creating... [9m31s elapsed]
proxmox_vm_qemu.vm1: Still creating... [9m41s elapsed]
proxmox_vm_qemu.vm1: Still creating... [9m51s elapsed]
proxmox_vm_qemu.vm1: Still creating... [10m1s elapsed]
proxmox_vm_qemu.vm1: Still creating... [10m11s elapsed]
proxmox_vm_qemu.vm1: Still creating... [10m21s elapsed]
proxmox_vm_qemu.vm1: Still creating... [10m31s elapsed]
proxmox_vm_qemu.vm1: Creation complete after 10m36s [id=labinfo/qemu/100]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```


```lua
ssh -i ~/.ssh/b300098957@ramena \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/tmp/ssh_known_hosts_empty \
  ubuntu@10.7.237.193
```

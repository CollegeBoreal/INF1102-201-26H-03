Below is a **minimal, practical guide** to launching a **Linux VM on Proxmox using OpenTofu** (Terraform-compatible).

I’ll assume:

* You already have **Proxmox VE running**
* You have an **API token** (user@realm!token)
* You want to clone from a **Linux cloud-init template** (Ubuntu/Debian/etc.)

---

## 1️⃣ Prerequisites on Proxmox

### A. Create a Linux cloud-init template (once)

Example (Ubuntu 22.04):

```bash
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

> bash cloud-init_template.sh 
<details>

```lua
--2026-01-16 13:27:29--  https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
Resolving cloud-images.ubuntu.com (cloud-images.ubuntu.com)... 185.125.190.40, 185.125.190.37, 2620:2d:4000:1::17, ...
Connecting to cloud-images.ubuntu.com (cloud-images.ubuntu.com)|185.125.190.40|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 689194496 (657M) [application/octet-stream]
Saving to: ‘jammy-server-cloudimg-amd64.img’

jammy-server-cloudimg-amd64. 100%[===========================================>] 657.27M  12.5MB/s    in 74s     

2026-01-16 13:28:44 (8.91 MB/s) - ‘jammy-server-cloudimg-amd64.img’ saved [689194496/689194496]

importing disk 'jammy-server-cloudimg-amd64.img' to VM 9000 ...
  Logical volume "vm-9000-disk-0" created.
transferred 0.0 B of 2.2 GiB (0.00%)
transferred 22.5 MiB of 2.2 GiB (1.00%)
transferred 45.0 MiB of 2.2 GiB (2.00%)
transferred 67.6 MiB of 2.2 GiB (3.00%)
transferred 90.3 MiB of 2.2 GiB (4.01%)
transferred 112.8 MiB of 2.2 GiB (5.01%)
transferred 136.0 MiB of 2.2 GiB (6.04%)
transferred 158.8 MiB of 2.2 GiB (7.05%)
transferred 181.3 MiB of 2.2 GiB (8.05%)
transferred 203.8 MiB of 2.2 GiB (9.05%)
transferred 226.3 MiB of 2.2 GiB (10.05%)
transferred 248.8 MiB of 2.2 GiB (11.05%)
transferred 271.4 MiB of 2.2 GiB (12.05%)
transferred 294.1 MiB of 2.2 GiB (13.06%)
transferred 316.6 MiB of 2.2 GiB (14.06%)
transferred 339.2 MiB of 2.2 GiB (15.06%)
transferred 361.7 MiB of 2.2 GiB (16.06%)
transferred 384.2 MiB of 2.2 GiB (17.06%)
transferred 406.7 MiB of 2.2 GiB (18.06%)
transferred 429.2 MiB of 2.2 GiB (19.06%)
transferred 452.0 MiB of 2.2 GiB (20.07%)
transferred 474.5 MiB of 2.2 GiB (21.07%)
transferred 497.0 MiB of 2.2 GiB (22.07%)
transferred 519.5 MiB of 2.2 GiB (23.07%)
transferred 542.1 MiB of 2.2 GiB (24.07%)
transferred 564.6 MiB of 2.2 GiB (25.07%)
transferred 587.3 MiB of 2.2 GiB (26.08%)
transferred 609.8 MiB of 2.2 GiB (27.08%)
transferred 632.4 MiB of 2.2 GiB (28.08%)
transferred 654.9 MiB of 2.2 GiB (29.08%)
transferred 677.4 MiB of 2.2 GiB (30.08%)
transferred 699.9 MiB of 2.2 GiB (31.08%)
transferred 722.7 MiB of 2.2 GiB (32.09%)
transferred 745.2 MiB of 2.2 GiB (33.09%)
transferred 767.7 MiB of 2.2 GiB (34.09%)
transferred 790.2 MiB of 2.2 GiB (35.09%)
transferred 812.7 MiB of 2.2 GiB (36.09%)
transferred 835.3 MiB of 2.2 GiB (37.09%)
transferred 858.0 MiB of 2.2 GiB (38.10%)
transferred 880.5 MiB of 2.2 GiB (39.10%)
transferred 903.1 MiB of 2.2 GiB (40.10%)
transferred 925.6 MiB of 2.2 GiB (41.10%)
transferred 948.1 MiB of 2.2 GiB (42.10%)
transferred 970.6 MiB of 2.2 GiB (43.10%)
transferred 993.1 MiB of 2.2 GiB (44.10%)
transferred 1015.9 MiB of 2.2 GiB (45.11%)
transferred 1.0 GiB of 2.2 GiB (46.11%)
transferred 1.0 GiB of 2.2 GiB (47.11%)
transferred 1.1 GiB of 2.2 GiB (48.11%)
transferred 1.1 GiB of 2.2 GiB (49.11%)
transferred 1.1 GiB of 2.2 GiB (50.11%)
transferred 1.1 GiB of 2.2 GiB (51.12%)
transferred 1.1 GiB of 2.2 GiB (52.12%)
transferred 1.2 GiB of 2.2 GiB (53.12%)
transferred 1.2 GiB of 2.2 GiB (54.12%)
transferred 1.2 GiB of 2.2 GiB (55.12%)
transferred 1.2 GiB of 2.2 GiB (56.12%)
transferred 1.3 GiB of 2.2 GiB (57.13%)
transferred 1.3 GiB of 2.2 GiB (58.23%)
transferred 1.3 GiB of 2.2 GiB (59.32%)
transferred 1.3 GiB of 2.2 GiB (60.32%)
transferred 1.3 GiB of 2.2 GiB (61.33%)
transferred 1.4 GiB of 2.2 GiB (62.33%)
transferred 1.4 GiB of 2.2 GiB (63.33%)
transferred 1.4 GiB of 2.2 GiB (64.34%)
transferred 1.4 GiB of 2.2 GiB (65.44%)
transferred 1.5 GiB of 2.2 GiB (66.44%)
transferred 1.5 GiB of 2.2 GiB (67.45%)
transferred 1.5 GiB of 2.2 GiB (68.46%)
transferred 1.5 GiB of 2.2 GiB (69.51%)
transferred 1.6 GiB of 2.2 GiB (70.51%)
transferred 1.6 GiB of 2.2 GiB (71.55%)
transferred 1.6 GiB of 2.2 GiB (72.65%)
transferred 1.6 GiB of 2.2 GiB (73.65%)
transferred 1.6 GiB of 2.2 GiB (74.65%)
transferred 1.7 GiB of 2.2 GiB (75.65%)
transferred 1.7 GiB of 2.2 GiB (76.65%)
transferred 1.7 GiB of 2.2 GiB (77.66%)
transferred 1.7 GiB of 2.2 GiB (78.66%)
transferred 1.8 GiB of 2.2 GiB (79.66%)
transferred 1.8 GiB of 2.2 GiB (80.66%)
transferred 1.8 GiB of 2.2 GiB (81.66%)
transferred 1.8 GiB of 2.2 GiB (82.66%)
transferred 1.8 GiB of 2.2 GiB (83.67%)
transferred 1.9 GiB of 2.2 GiB (84.67%)
transferred 1.9 GiB of 2.2 GiB (85.67%)
transferred 1.9 GiB of 2.2 GiB (86.67%)
transferred 1.9 GiB of 2.2 GiB (87.67%)
transferred 2.0 GiB of 2.2 GiB (88.67%)
transferred 2.0 GiB of 2.2 GiB (89.68%)
transferred 2.0 GiB of 2.2 GiB (90.68%)
transferred 2.0 GiB of 2.2 GiB (91.68%)
transferred 2.0 GiB of 2.2 GiB (92.68%)
transferred 2.1 GiB of 2.2 GiB (93.68%)
transferred 2.1 GiB of 2.2 GiB (94.68%)
transferred 2.1 GiB of 2.2 GiB (95.69%)
transferred 2.1 GiB of 2.2 GiB (96.69%)
transferred 2.1 GiB of 2.2 GiB (97.69%)
transferred 2.2 GiB of 2.2 GiB (98.69%)
transferred 2.2 GiB of 2.2 GiB (99.69%)
transferred 2.2 GiB of 2.2 GiB (100.00%)
transferred 2.2 GiB of 2.2 GiB (100.00%)

Successfully imported disk as 'unused0:local-lvm:vm-9000-disk-0'
update VM 9000: -scsi0 local-lvm:vm-9000-disk-0 -scsihw virtio-scsi-pci
update VM 9000: -ide2 local-lvm:cloudinit
  Logical volume "vm-9000-cloudinit" created.
update VM 9000: -boot c -bootdisk scsi0
update VM 9000: -serial0 socket -vga serial0
  Renamed "vm-9000-disk-0" to "base-9000-disk-0" in volume group "pve"
  Logical volume pve/base-9000-disk-0 changed.
  WARNING: Combining activation change with other commands is not advised.
```

</details>

---

## 2️⃣ Install OpenTofu

```bash
brew install opentofu        # macOS
# or
sudo snap install opentofu   # Linux
```

Verify:

```bash
tofu version
```

---

## 3️⃣ Provider Configuration (`provider.tf`)

```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.47"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = true
}
```

---

## 4️⃣ Variables (`variables.tf`)

```hcl
variable "proxmox_endpoint" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "node_name" {
  default = "pve"
}

variable "vm_user" {
  default = "ubuntu"
}

variable "ssh_public_key" {
  type = string
}
```

---

## 5️⃣ Linux VM Definition (`vm.tf`)

```hcl
resource "proxmox_virtual_environment_vm" "linux_vm" {
  name      = "linux-vm-01"
  node_name = var.node_name

  clone {
    vm_id = 9000 # template ID
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 2048
  }

  disk {
    interface = "scsi0"
    size      = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = var.vm_user
      keys     = [var.ssh_public_key]
    }
  }
}
```

---

## 6️⃣ Secrets (`terraform.tfvars`)

```hcl
proxmox_endpoint = "https://proxmox.example.com:8006/api2/json"
proxmox_api_token = "root@pam!tofu=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
ssh_public_key    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
```

---

## 7️⃣ Launch the VM 🚀

```bash
tofu init
tofu plan
tofu apply
```

After ~30 seconds, the VM will:

* Be cloned from the template
* Boot automatically
* Get DHCP IP
* Allow SSH via your key

---

## 8️⃣ Verify

```bash
ssh ubuntu@<vm-ip>
```

or check in Proxmox UI:

```
Datacenter → Node → VM → Console
```

---

## 🧠 Common Gotchas

| Issue              | Fix                                                                   |
| ------------------ | --------------------------------------------------------------------- |
| VM boots but no IP | Cloud-init disk missing                                               |
| SSH not working    | SSH key format wrong                                                  |
| Clone fails        | Template must be **stopped**                                          |
| Permissions error  | Token role needs `VM.Allocate`, `VM.Clone`, `Datastore.AllocateSpace` |

---

## 9️⃣ Want more?

I can show you:

* 🔁 Multiple VMs with `for_each`
* 🌐 Static IP configuration
* 📦 Ansible + OpenTofu combo
* 🧩 OpenTofu module layout
* 🛡️ Least-privilege Proxmox roles

Just tell me what you want next.


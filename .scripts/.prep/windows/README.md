

---

Perfect! Since you want to **download both Windows Server 2025 ISO and VirtIO ISO in the background** on a Proxmox server, we can use `wget` with `nohup` or `&` so the downloads continue even if your session disconnects.

Here’s a simple **bash script** for that:

```bash
#!/bin/bash
# -------------------------------
# Download Windows Server 2025 ISO + VirtIO ISO in background
# -------------------------------

# Destination directory on Proxmox
ISO_DIR="/var/lib/vz/template/iso"
mkdir -p "$ISO_DIR"

# URLs
WIN_SERVER_URL="https://archive.org/download/windows_server_2025/en_windows_server_2025_all_in_one_24h2_build_26100.1.iso"
VIRTIO_URL="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso"

# Filenames
WIN_SERVER_FILE="$ISO_DIR/en_windows_server_2025_all_in_one_24h2_build_26100.1.iso"
VIRTIO_FILE="$ISO_DIR/virtio-win.iso"

# -------------------------------
# Download in background
# -------------------------------

echo "Starting Windows Server 2025 ISO download in background..."
nohup wget -c -O "$WIN_SERVER_FILE" "$WIN_SERVER_URL" > "$ISO_DIR/winserver_download.log" 2>&1 &

echo "Starting VirtIO ISO download in background..."
nohup wget -c -O "$VIRTIO_FILE" "$VIRTIO_URL" > "$ISO_DIR/virtio_download.log" 2>&1 &

echo "Downloads started. Check logs in $ISO_DIR/*.log"
```

---

### **How it works**

* `nohup` → ensures the download keeps running if you log out.
* `-c` → continue/resume if the file partially downloads.
* `> logfile 2>&1 &` → runs in background and logs output to a file.

After running this script:

```bash
chmod +x download_isos.sh
./download_isos.sh
```

You can monitor progress:

```bash
tail -f /var/lib/vz/template/iso/winserver_download.log
tail -f /var/lib/vz/template/iso/virtio_download.log
```

Once both downloads finish, the files will be in:

```
/var/lib/vz/template/iso/en_windows_server_2025_all_in_one_24h2_build_26100.1.iso
/var/lib/vz/template/iso/virtio-win.iso
```

Ready to attach to your Proxmox VM.

---

Perfect! Attaching a **Proxmox template** instead of the ISO is much faster, especially for a classroom environment. Here’s a **student-ready OpenTofu (Terraform) script** that **clones from a template**:

---

### **OpenTofu Script: Clone VM from Template**

```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">=2.9.7"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://proxmox.example.com:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "yourpassword"
  pm_tls_insecure = true
}

# ------------------------------
# Student VM from Template
# ------------------------------
resource "proxmox_vm_qemu" "student_vm" {
  name        = "winstudent-${var.student_id}"
  target_node = "pve"

  # Clone from existing template
  clone       = var.template_vm_id

  # Resources for VM (override template if needed)
  cores       = 1
  sockets     = 1
  memory      = 2048
  scsihw      = "virtio-scsi-pci"

  # Optional: cloud-init config for student customization
  ciuser      = var.student_username
  cipassword  = var.student_password
}

# ------------------------------
# Variables
# ------------------------------
variable "student_id" {
  type        = string
  description = "Unique student identifier"
}

variable "template_vm_id" {
  type        = number
  description = "Proxmox VM ID of the template to clone"
}

variable "student_username" {
  type        = string
  description = "Username for student VM"
  default     = "student"
}

variable "student_password" {
  type        = string
  description = "Password for student VM"
  default     = "P@ssword123!"
}
```

---

### **How it works**

1. `clone = var.template_vm_id` → clones an existing **Proxmox template VM** instead of installing from ISO.
2. **Overrides resources** (CPU, RAM, etc.) if you want to adjust for the student VM.
3. Supports **cloud-init**, so each student can have a different username/password.

---

### **Example usage**

```bash
terraform apply \
  -var="student_id=01" \
  -var="template_vm_id=200" \
  -var="student_username=alice" \
  -var="student_password=Welcome123!"
```

* Creates `winstudent-01` cloned from template `200`.
* Student can log in with `alice/Welcome123!`.

---

✅ **Benefits**

* Very fast — no need to wait for Windows install.
* Saves storage — uses thin-provisioned clone.
* Easy to scale for 10+ students per server.

---

Perfect — now we’re talking about **making the student VMs fully network-accessible**. Let’s break it down carefully.

---

## **1️⃣ Assigning a static IP**

There are two main approaches in Proxmox + OpenTofu:

### **Option A — Use Cloud-Init to assign IP**

If your template supports **cloud-init**, you can assign a **static IP** when cloning the VM:

```hcl
resource "proxmox_vm_qemu" "student_vm" {
  name        = "winstudent-${var.student_id}"
  target_node = "pve"
  clone       = var.template_vm_id

  cores       = 1
  sockets     = 1
  memory      = 2048
  scsihw      = "virtio-scsi-pci"

  # Cloud-init network configuration
  ciuser      = var.student_username
  cipassword  = var.student_password

  # Set static IP
  ipconfig0   = "ip=${var.student_ip}/24,gw=${var.gateway}"
}
```

Then in your variables:

```hcl
variable "student_ip" {
  type = string
}

variable "gateway" {
  type    = string
  default = "10.7.237.1"
}
```

* `ipconfig0` applies to the **first network interface** of the VM.
* Cloud-init modifies Windows network settings at first boot.

---

### **Option B — Set IP inside Windows manually**

* Use **template with DHCP** to assign temporary IP.
* Student logs in, sets a **manual static IP** in Windows.
* Works, but less automated and slower for 10+ students.

> ✅ **Recommendation:** use **cloud-init static IP** if template supports it.

---

## **2️⃣ Enabling RDP**

Windows Server has **RDP (Remote Desktop) disabled by default**, so you need to:

1. **Enable RDP** in the template before cloning:

   * On the template VM:

     * `Win + R` → `sysdm.cpl` → Remote → “Allow remote connections to this computer”
     * Optional: allow RDP through Windows Firewall
   * Install **VirtIO drivers** for network access

2. **Check network**:

   * Ensure **Proxmox bridge (`vmbr0`)** allows the VM to reach your LAN.
   * If using NAT, forward the RDP port from Proxmox host to VM.

3. **Connect using RDP**:

   * Windows client or `mstsc /v:IP_ADDRESS`
   * Use **cloud-init username/password** or the credentials you configured in the template.

---

## **3️⃣ Putting it together in Terraform / OpenTofu**

Example variables for 10 students:

```hcl
variable "student_ip" {
  type = string
}

variable "gateway" {
  type    = string
  default = "10.7.237.1"
}

variable "student_username" {
  type = string
}

variable "student_password" {
  type = string
}
```

* Each student VM can have a **unique IP** (e.g., 10.7.237.101–110)
* Cloud-init configures network at first boot
* RDP can be used immediately after VM boots

---

💡 **Extra tip for classrooms:**

* Use **sequential IP assignment** and **linked clones** to save space.
* Optionally, pre-enable **RDP firewall rules** in the template so students don’t need to touch Windows Firewall.





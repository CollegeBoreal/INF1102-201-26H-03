resource "proxmox_vm_qemu" "vm_iac" {

  name        = var.pm_vm_name
  target_node = "labinfo"
  clone       = "ubuntu-jammy-template"

  cores  = 2
  memory = 2048

  disk {
    size    = "10G"
    storage = "local-lvm"
    type    = "scsi"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  os_type = "cloud-init"

  ipconfig0  = var.pm_ipconfig0
  nameserver = var.pm_nameserver
}

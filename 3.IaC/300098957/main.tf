resource "proxmox_vm_qemu" "vm1" {
  name        = var.pm_vm_name
  target_node = "labinfo"
  clone       = "ubuntu-jammy-template"

  cores   = 2
  sockets = 1
  memory  = 4096

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

  ipconfig0 = var.pm_ipconfig0
  nameserver = var.pm_nameserver

  ciuser  = "ubuntu"
  sshkeys = <<EOF
   ${file("~/.ssh/github.com-setrar.pub")}
   ${file("~/.ssh/b300098957@ramena.pub")}
  EOF
  # sshkeys = file("~/.ssh/b300098957@ramena.pub")
}


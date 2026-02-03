resource "proxmox_virtual_environment_vm" "linux_vm" {
  vm_id    = 098957
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

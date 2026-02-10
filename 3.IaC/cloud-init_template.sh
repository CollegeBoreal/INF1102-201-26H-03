# Download cloud image
#wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# Create VM
qm create 9000 --name ubuntu-jammy-template --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0

# Convert qcow2 to raw on thin LVM pool
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm --format raw

# Attach disk
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0

# Cloud-init disk
qm set 9000 --ide2 local-lvm:cloudinit

# Boot settings
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0

# Convert to template
qm template 9000

#!/bin/bash

# Ubicación del disco de datos
diskPath="/dev/disk/azure/scsi1/lun0"

# Formatear el disco de datos
sudo mkfs.ext4 $diskPath

# Crear un punto de montaje para el disco de datos
sudo mkdir /mnt/data

# Montar el disco de datos
sudo mount $diskPath /mnt/data

# Actualizar /etc/fstab para montar el disco de datos automáticamente en el arranque
echo "$diskPath /mnt/data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab

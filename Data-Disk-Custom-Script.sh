#!/bin/bash

# Obtener el ID del disco de datos
diskId=$(az vm show -g ${resourceGroup().name} -n SMC-VM01-Alastria --query "storageProfile.dataDisks[0].managedDisk.id" -o tsv)

# Formatear el disco de datos
sudo mkfs.ext4 $diskId

# Crear un punto de montaje para el disco de datos
sudo mkdir /mnt/datadisk

# Montar el disco de datos
sudo mount $diskId /mnt/datadisk

# Actualizar /etc/fstab para montar el disco de datos automáticamente en el arranque
echo "$diskId /mnt/datadisk ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab

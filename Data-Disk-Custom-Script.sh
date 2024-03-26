#!/bin/bash

# Obtener el nombre del grupo de recursos de la VM
resourceGroupName=$(az vm show -g $(az vm list --query "[?name=='SMC-VM01-Alastria'].resourceGroup" -o tsv) -n SMC-VM01-Alastria --query "resourceGroup" -o tsv)

# Obtener el ID del disco de datos
diskId=$(az vm show -g $resourceGroupName -n SMC-VM01-Alastria --query "storageProfile.dataDisks[0].managedDisk.id" -o tsv)

# Formatear el disco de datos
sudo mkfs.ext4 $diskId

# Crear un punto de montaje para el disco de datos
sudo mkdir /mnt/data

# Montar el disco de datos
sudo mount $diskId /mnt/data

# Actualizar /etc/fstab para montar el disco de datos automáticamente en el arranque
echo "$diskId /mnt/data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab

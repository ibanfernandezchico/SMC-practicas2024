#!/bin/bash

# Obtener el nombre del grupo de recursos
resourceGroupName=$(az vm list --query "[0].resourceGroup" -o tsv)

# Obtener el ID del disco de datos
diskId=$(az vm show -g $resourceGroupName -n $(az vm list --query "[0].name" -o tsv) --query "storageProfile.dataDisks[0].managedDisk.id" -o tsv)

# Formatear el disco de datos
sudo mkfs.ext4 $diskId

# Crear un punto de montaje para el disco de datos
sudo mkdir /mnt/datos

# Montar el disco de datos
sudo mount $diskId /mnt/datos

# Actualizar /etc/fstab para montar el disco de datos automáticamente en el arranque
echo "$diskId /mnt/datos ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab

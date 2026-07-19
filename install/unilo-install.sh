#!/bin/bash
# install/unilo-install

TARGET="/boot/unilo"

echo "Instalando UNILO en $TARGET..."

# Crear estructura de carpetas
sudo mkdir -p $TARGET/{themes,efi,fonts,locale}

# Copiar binarios BIOS
sudo cp ~/unilo/bin/unilo.bin $TARGET/

# Copiar binarios UEFI
sudo cp ~/unilo/bin/bin-uefi/unilo.efi $TARGET/efi/

# Copiar herramientas auxiliares
sudo cp ~/unilo/bin/unilo-consult $TARGET/
sudo cp ~/unilo/bin/mkconf $TARGET/

# Crear archivo de configuración inicial si no existe
if [ ! -f $TARGET/unilo.conf ]; then
    echo "Creando archivo de configuración inicial..."
    sudo touch $TARGET/unilo.conf
fi

echo "UNILO instalado correctamente en $TARGET"

#!/bin/bash
# Script mkconf para UNILO

TARGET="/boot/unilo/unilo.conf"

echo "Generando configuración en $TARGET..."

# Entrada para BIOS
echo 'menuentry "UNILO BIOS" {
    loader /boot/unilo/unilo.bin
}' | sudo tee -a $TARGET

# Entrada para UEFI
echo 'menuentry "UNILO UEFI" {
    loader /boot/unilo/efi/unilo.efi
}' | sudo tee -a $TARGET

echo "Archivo de configuración actualizado."

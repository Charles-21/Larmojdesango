#!/bin/bash

# Script para automatizar el proceso de subir cambios a GitHub

echo "Verificando cambios..."
git status

echo ""
echo "Agregando todos los archivos modificados..."
git add .

# Pide mensaje de commit
echo ""
read -p "Escribe tu mensaje de commit: " mensaje

# Si no se escribió mensaje, cancela
if [ -z "$mensaje" ]; then
    echo " Error:Que escribas un mensaje de commit. Cancelando."
    exit 1
fi

echo ""
echo "HHaciendo commit..."
git commit -m "$mensaje"

echo ""
echo "Empujando a GitHub..."
git push origin main

echo ""
echo " ¡Cambios subidos exitosamente, camarada!"


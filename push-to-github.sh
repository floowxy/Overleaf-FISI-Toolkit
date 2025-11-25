#!/bin/bash
# Script para preparar y subir a GitHub
# Ejecuta: bash push-to-github.sh

set -e

echo "🔍 Verificando archivos antes de subir..."
echo ""

# Verificar que no hay archivos sensibles
echo "1️⃣ Verificando que no hay archivos sensibles rastreados..."
SENSITIVE=$(git ls-files | grep -E "(\.env$|\.pem|\.key|\.crt)" | grep -v "\.example" || true)
if [ -n "$SENSITIVE" ]; then
    echo "❌ ERROR: Se encontraron archivos sensibles:"
    echo "$SENSITIVE"
    echo ""
    echo "Por favor revisa estos archivos antes de continuar."
    exit 1
fi
echo "✅ No hay archivos sensibles rastreados"
echo ""

# Mostrar qué se va a subir
echo "2️⃣ Archivos que se van a subir:"
echo ""
git status --short
echo ""

# Verificar remote
echo "3️⃣ Repositorio destino:"
git remote -v | grep origin
echo ""

# Confirmación
read -p "¿Deseas continuar con el push? (s/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "❌ Push cancelado"
    exit 1
fi

echo ""
echo "📤 Preparando commit..."
echo ""

# Git add
git add .

# Commit con mensaje detallado
git commit -F /tmp/commit_message.txt

echo ""
echo "🚀 Haciendo push a GitHub..."
echo ""

# Push
git push -u origin master

echo ""
echo "✅ ¡Listo! Tu código está en GitHub:"
echo "   https://github.com/floowxy/Overleaf-FISI-Toolkit"
echo ""

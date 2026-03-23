#!/bin/bash

# Konta PWA - Setup Script para Desarrollo Local
# Este script configura el entorno de desarrollo local

echo "🚀 Konta PWA - Setup Inicial"
echo "=============================="
echo ""

# Verificar Node.js instalado (opcional para algunos servidores)
if command -v node &> /dev/null; then
    echo "✓ Node.js detectado: $(node --version)"
else
    echo "⚠ Node.js no encontrado (opcional)"
fi

# Crear estructura de carpetas si falta
echo ""
echo "📁 Verificando estructura de archivos..."

required_files=(
    "index.html"
    "manifest.json"
    "sw.js"
    "README.md"
    "DEPLOY.md"
    "PWA-CHECKLIST.md"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ✗ $file (FALTA)"
    fi
done

echo ""
echo "🔧 Opciones de Desarrollo Local"
echo "================================"
echo ""
echo "1) Ver con servidor HTTP simple (Python)"
echo "2) Ver con servidor HTTP simple (Node.js)"
echo "3) Ver con PHP built-in"
echo "4) Salir"
echo ""
read -p "Selecciona opción (1-4): " option

case $option in
    1)
        echo ""
        echo "🐍 Iniciando servidor Python..."
        echo "Abriendo: http://localhost:8000"
        echo "Presiona Ctrl+C para detener"
        echo ""
        
        # Python 3
        if command -v python3 &> /dev/null; then
            python3 -m http.server 8000 --directory .
        # Python 2
        elif command -v python &> /dev/null; then
            python -m SimpleHTTPServer 8000
        else
            echo "❌ Python no encontrado"
            exit 1
        fi
        ;;
    2)
        echo ""
        echo "⚡ Iniciando servidor Node.js..."
        echo ""
        
        # Crear simple server.js si no existe
        cat > server.js << 'EOF'
const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  let filePath = req.url === '/' ? 'index.html' : req.url;
  filePath = path.join(__dirname, filePath);

  fs.readFile(filePath, (err, content) => {
    if (err) {
      // SPA routing - return index.html for non-existent routes
      fs.readFile(path.join(__dirname, 'index.html'), (err, content) => {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(content);
      });
    } else {
      const contentType = filePath.endsWith('.json') ? 'application/json' : 'text/html';
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content);
    }
  });
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`
✓ Servidor iniciado en http://localhost:${PORT}
✓ Presiona Ctrl+C para detener
  `);
});
EOF
        
        echo "🚀 Abriendo: http://localhost:3000"
        echo ""
        node server.js
        ;;
    3)
        echo ""
        echo "🐘 Iniciando servidor PHP..."
        echo "Abriendo: http://localhost:8000"
        echo "Presiona Ctrl+C para detener"
        echo ""
        
        if command -v php &> /dev/null; then
            php -S localhost:8000
        else
            echo "❌ PHP no encontrado"
            exit 1
        fi
        ;;
    4)
        echo "Saliendo..."
        exit 0
        ;;
    *)
        echo "❌ Opción inválida"
        exit 1
        ;;
esac

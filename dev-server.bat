@echo off
setlocal enabledelayedexpansion

REM Konta PWA - Setup Script para Desarrollo Local (Windows)
REM Este script configura el entorno de desarrollo local en Windows

echo.
echo 🚀 Konta PWA - Setup Inicial (Windows)
echo ======================================
echo.

REM Verificar Node.js instalado
where node >nul 2>nul
if !errorlevel! equ 0 (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo ✓ Node.js detectado: !NODE_VERSION!
) else (
    echo ⚠ Node.js no encontrado (opcional)
)

echo.
echo 📁 Verificando estructura de archivos...
echo.

setlocal
REM Verificar archivos requeridos
set "files=index.html manifest.json sw.js README.md DEPLOY.md PWA-CHECKLIST.md"

for %%F in (%files%) do (
    if exist "%%F" (
        echo   ✓ %%F
    ) else (
        echo   ✗ %%F ^(FALTA^)
    )
)

echo.
echo 🔧 Opciones de Desarrollo Local
echo ================================
echo.
echo 1) Ver con servidor Node.js (recomendado)
echo 2) Ver con Python
echo 3) Ver con PHP
echo 4) Abrir en navegador (archivo local)
echo 5) Salir
echo.

set /p option="Selecciona opción (1-5): "

if "%option%"=="1" goto node_server
if "%option%"=="2" goto python_server
if "%option%"=="3" goto php_server
if "%option%"=="4" goto open_browser
if "%option%"=="5" goto exit_script
goto invalid_option

:node_server
echo.
echo ⚡ Iniciando servidor Node.js...
echo.

REM Crear server.js
(
echo const http = require('http');
echo const fs = require('fs');
echo const path = require('path');
echo.
echo const server = http.createServer((req, res) =^> {
echo   let filePath = req.url === '/' ? 'index.html' : req.url;
echo   filePath = path.join(__dirname, filePath);
echo.
echo   fs.readFile(filePath, (err, content) =^> {
echo     if (err) {
echo       // SPA routing - return index.html for non-existent routes
echo       fs.readFile(path.join(__dirname, 'index.html'), (err, content) =^> {
echo         res.writeHead(200, { 'Content-Type': 'text/html' });
echo         res.end(content);
echo       });
echo     } else {
echo       const contentType = filePath.endsWith('.json') ? 'application/json' : 'text/html';
echo       res.writeHead(200, { 'Content-Type': contentType });
echo       res.end(content);
echo     }
echo   });
echo });
echo.
echo const PORT = 3000;
echo server.listen(PORT, () =^> {
echo   console.log(`
echo ✓ Servidor iniciado en http://localhost:${PORT}
echo ✓ Presiona Ctrl+C para detener
echo   `);
echo });
) > server.js

where node >nul 2>nul
if errorlevel 1 (
    echo ❌ Node.js no encontrado. Instálalo desde https://nodejs.org
    pause
    exit /b 1
)

echo 🚀 Abriendo: http://localhost:3000
echo.
start http://localhost:3000
node server.js
goto end

:python_server
echo.
echo 🐍 Iniciando servidor Python...
echo.

where python >nul 2>nul
if errorlevel 1 (
    where python3 >nul 2>nul
    if errorlevel 1 (
        echo ❌ Python no encontrado. Instálalo desde https://python.org
        pause
        exit /b 1
    )
    set PYTHON=python3
) else (
    set PYTHON=python
)

echo 🚀 Abriendo: http://localhost:8000
echo Presiona Ctrl+C para detener
echo.
start http://localhost:8000
%PYTHON% -m http.server 8000
goto end

:php_server
echo.
echo 🐘 Iniciando servidor PHP...
echo.

where php >nul 2>nul
if errorlevel 1 (
    echo ❌ PHP no encontrado. Instálalo desde https://php.net
    pause
    exit /b 1
)

echo 🚀 Abriendo: http://localhost:8000
echo Presiona Ctrl+C para detener
echo.
start http://localhost:8000
php -S localhost:8000
goto end

:open_browser
echo.
echo 🌐 Abriendo archivo local en navegador...
echo ⚠️ NOTA: Los Service Workers no funcionarán en archivos locales
echo.
for %%F in (%CD%\index.html) do (
    start "" "%%F"
)
echo ✓ Archivo abierto en navegador (modo lectura local)
echo.
pause
goto end

:invalid_option
echo.
echo ❌ Opción inválida
pause
exit /b 1

:exit_script
echo.
echo Saliendo...
exit /b 0

:end
echo.

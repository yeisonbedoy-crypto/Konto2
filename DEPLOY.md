# 🚀 Guía Completa de Despliegue - Konta PWA

## Prerequisitos Globales

- ✅ Dominio personalizado (opcional pero recomendado)
- ✅ HTTPS activado (obligatorio para PWA)
- ✅ Acceso a repositorio Git
- ✅ Conocimientos básicos de terminal/consola

---

## Opción 1: Vercel (⭐ RECOMENDADO)

### Ventajas
- ✅ HTTPS automático
- ✅ Despliegue instantáneo
- ✅ CDN global
- ✅ Actualizaciones automáticas desde Git
- ✅ Dominio gratuito o personalizado
- ✅ Analytics incluido

### Pasos

1. **Subir código a GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Konta PWA"
   git remote add origin https://github.com/TU_USUARIO/konta.git
   git push -u origin main
   ```

2. **Registrarse en Vercel:**
   - Ir a https://vercel.com
   - Hacer clic en "Sign Up"
   - Conectar con GitHub/GitLab/Bitbucket

3. **Crear proyecto:**
   - Click en "New Project"
   - Buscar y seleccionar tu repositorio `konta`
   - Click en "Import"

4. **Configurar:**
   - **Build Command**: Dejar en blanco (es solo archivos estáticos)
   - **Output Directory**: `.` (raíz)
   - Click en "Deploy"

5. **Esperar:**
   - Vercel despliegará automáticamente
   - URLs automaticamente: `https://konta.vercel.app`

6. **Dominio personalizado (opcional):**
   - Ve a Settings → Domains
   - Añade tu dominio
   - Sigue las instrucciones de DNS

### Actualizar la app

```bash
# Simplemente hace push a main
git push origin main
# Vercel se auto-actualiza automáticamente
```

---

## Opción 2: GitHub Pages (Gratuito)

### Ventajas
- ✅ Completamente gratuito
- ✅ Integrado en GitHub
- ✅ HTTPS automático
- ✅ Perfecto para proyectos de código abierto

### Desventajas
- ❌ URL incluye nombre de repositorio
- ❌ Rendimiento inferior a Vercel

### Pasos

1. **Crear repositorio público:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Konta PWA"
   git remote add origin https://github.com/TU_USUARIO/konta.git
   git push -u origin main
   ```

2. **Activar Pages:**
   - Ir a GitHub → Tu repo → Settings
   - Ir a "Pages" (en el menú lateral)
   - **Source**: `main` branch
   - **Folder**: `/` (raíz)
   - Click en "Save"

3. **Esperar:**
   - GitHub construirá y despliegará
   - URL: `https://TU_USUARIO.github.io/konta`

4. **Dominio personalizado (opcional):**
   - En Pages Settings → Custom domain
   - Ingresa tu dominio
   - Sigue las instrucciones de DNS

### Actualizar la app

```bash
git push origin main
# GitHub Pages se actualiza automáticamente
```

---

## Opción 3: Servidor Propio/VPS

### Requisitos
- Servidor con SSH acceso
- Dominio propio
- Certificado SSL (Let's Encrypt)

### 3.1 Con Apache

1. **Conectar por SSH:**
   ```bash
   ssh usuario@tu-servidor.com
   ```

2. **Clonar repositorio:**
   ```bash
   cd /var/www/
   git clone https://github.com/TU_USUARIO/konta.git
   cd konta
   ```

3. **Copiar configuración Apache:**
   ```bash
   sudo cp .htaccess /var/www/konta/
   sudo chown -R www-data:www-data /var/www/konta
   sudo chmod -R 755 /var/www/konta
   ```

4. **Crear Virtual Host:**
   ```bash
   sudo nano /etc/apache2/sites-available/konta.conf
   ```

   Pega esto:
   ```apache
   <VirtualHost *:80>
     ServerName tu-dominio.com
     ServerAlias www.tu-dominio.com
     
     DocumentRoot /var/www/konta
     
     <Directory /var/www/konta>
       Options Indexes FollowSymLinks
       AllowOverride All
       Require all granted
     </Directory>
     
     ErrorLog ${APACHE_LOG_DIR}/konta_error.log
     CustomLog ${APACHE_LOG_DIR}/konta_access.log combined
   </VirtualHost>
   ```

   (Ctrl+X, Y, Enter para guardar)

5. **Activar el sitio:**
   ```bash
   sudo a2ensite konta.conf
   sudo a2enmod rewrite
   sudo systemctl restart apache2
   ```

6. **SSL con Let's Encrypt:**
   ```bash
   sudo apt install certbot python3-certbot-apache
   sudo certbot --apache -d tu-dominio.com -d www.tu-dominio.com
   ```

7. **Verificar:**
   - Abre https://tu-dominio.com en el navegador

### 3.2 Con Nginx

1. **Conectar por SSH:**
   ```bash
   ssh usuario@tu-servidor.com
   ```

2. **Clonar repositorio:**
   ```bash
   cd /var/www/
   git clone https://github.com/TU_USUARIO/konta.git
   cd konta
   ```

3. **Copiar configuración Nginx:**
   ```bash
   sudo cp nginx.conf /etc/nginx/sites-available/konta
   sudo nano /etc/nginx/sites-available/konta
   ```

   Actualiza:
   - `server_name tu-dominio.com www.tu-dominio.com;`
   - `root /var/www/konta;`

4. **Activar el sitio:**
   ```bash
   sudo ln -s /etc/nginx/sites-available/konta /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

5. **SSL con Let's Encrypt:**
   ```bash
   sudo apt install certbot python3-certbot-nginx
   sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com
   ```

6. **Verificar:**
   - Abre https://tu-dominio.com en el navegador

### 3.3 Mantener Actualizado

```bash
cd /var/www/konta
git pull origin main
# El caché se actualiza automáticamente con los headers
```

---

## Opción 4: IIS (Windows Server)

1. **Clonar repositorio:**
   ```powershell
   cd C:\inetpub\wwwroot
   git clone https://github.com/TU_USUARIO/konta.git
   ```

2. **Copiar web.config:**
   ```powershell
   Copy-Item -Path ".\konta\web.config" -Destination ".\konta\"
   ```

3. **Crear aplicación en IIS:**
   - Abrir IIS Manager
   - Clic en tu sitio → Agregar aplicación
   - Alias: `konta`
   - Ruta física: `C:\inetpub\wwwroot\konta`
   - OK

4. **Configurar SSL:**
   - En el sitio → Enlazos HTTPS
   - Seleccionar certificado
   - OK

5. **Actualizar:**
   ```powershell
   cd C:\inetpub\wwwroot\konta
   git pull origin main
   # Opcional: iisreset
   ```

---

## Verificación Post-Despliegue

### Checklist:

1. **URL accesible:**
   ```bash
   curl -I https://tu-dominio.com/
   # Debe retornar HTTP/2 200
   ```

2. **HTTPS funcionando:**
   - Abre en navegador
   - Verifica candado de seguridad

3. **Manifest.json:**
   ```bash
   curl https://tu-dominio.com/manifest.json
   # Debe retornar JSON valido
   ```

4. **Service Worker:**
   - DevTools → Application → Service Workers
   - Debe mostrar registrado

5. **Headers correctos:**
   ```bash
   curl -I https://tu-dominio.com/index.html
   # Cache-Control: no-cache
   
   curl -I https://tu-dominio.com/manifest.json
   # Cache-Control: public, max-age=86400
   ```

6. **Lighthouse Check:**
   - DevTools → Lighthouse
   - Correr auditoría PWA
   - Debe dar 90+ en todas las categorías

### Lighthouse en DevTools:

1. Abre DevTools (F12)
2. Tab "Lighthouse"
3. Click "Analyze page load"
4. Espera a que complete

Debe mostrar:
- ✅ PWA Optimized
- ✅ Mobile friendly
- ✅ Fast Load

---

## Monitoreo Continuo

### Errores de Service Worker:

1. DevTools → Application → Service Workers
2. Click en el SW registrado
3. Revisa errores en la consola

### Actualizaciones de la App:

- Los cambios se distribuyen automáticamente a través del CDN
- El SW verifica actualizaciones cada 60 segundos
- Los usuarios verán cambios en <5 minutos generalmente

### Analytics (Vercel):

- Dashboard de Vercel muestra:
  - Tráfico en tiempo real
  - Duración del deploy
  - Errores

---

## Solución de Problemas de Despliegue

### "Error 404 en rutas"
**Causa:** Falta rewrite de rutas  
**Solución:** Asegurar que `.htaccess`, `nginx.conf` o `web.config` están en la raíz

### "Service Worker no se registra"
**Causa:** Archivo `sw.js` no encontrado  
**Solución:** Verificar que `sw.js` está en la raíz (no en carpeta)

### "App no se instala"
**Causa:** Falta HTTPS o manifest.json inválido  
**Solución:** 
- Verificar HTTPS con candado
- Abrir DevTools → Application → Manifest
- Corregir errores en JSON

### "Cambios no aparecen"
**Causa:** Cache agresivo del navegador  
**Solución:**
- Ctrl+Shift+R fuerza recarga
- Esperar 60 segundos
- Limpiar caché del navegador

---

## Próximas Mejoras

- [ ] Enviar a App Store
- [ ] Enviar a Play Store
- [ ] Analytics avanzado
- [ ] Web Push Notifications
- [ ] Solicitar permisos de cámara

---

**Última actualización**: Marzo 2026  
**PWA Version**: 1.0.0

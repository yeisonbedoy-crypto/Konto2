# 📱 Konta - PWA (Progressive Web App)

Aplicación inteligente de gestión de facturas con soporte para iOS y Android como **aplicación instalada**.

## 🚀 Características PWA

- ✅ **Instalable en iOS y Android** - Acceso directo desde pantalla de inicio
- ✅ **Funciona offline** - Service Worker cacheado
- ✅ **Interfaz responsive** - Optimizado para todos los tamaños de pantalla
- ✅ **Notch & Safe Areas** - Soporte completo para iPhone X+ y Android
- ✅ **Atajos de aplicación** - Acceso rápido a funciones principales
- ✅ **Splash screen personalizado** - Pantalla de carga estilizada

## 📥 Instalación

### En iPhone (iOS)

1. Abre la app **Safari** en tu iPhone
2. Dirige a: `https://tucorreo.github.io/konta` (o tu dominio)
3. Toca el botón **Compartir** (cuadrado con flecha)
4. Desplázate y selecciona **"Añadir a la pantalla de inicio"**
5. Confirma el nombre de la app (por defecto: "Konta")
6. ¡Listo! Aparecerá un ícono en tu pantalla de inicio

### En Android

1. Abre el navegador **Chrome**
2. Dirige a: `https://tucorreo.github.io/konta` (o tu dominio)
3. Toca el menú (⋮) en la esquina superior derecha
4. Selecciona **"Instalar app"** o **"Instalar en pantalla de inicio"**
5. Confirma la instalación
6. ¡Listo! La app aparecerá en tu bandeja de aplicaciones

## 📁 Estructura de Archivos

```
/
├── index.html          # Archivo principal (HTML + CSS + JS)
├── manifest.json       # Configuración PWA (iconos, nombre, etc.)
├── sw.js              # Service Worker (funcionalidad offline)
└── README.md          # Este archivo
```

## 🎨 Personalización

### Cambiar Color de Tema

En `manifest.json`, modifica la propiedad `theme_color`:

```json
"theme_color": "#10b981"  // Cambia a tu color preferido (ej: #635bff)
```

También actualiza en el `<head>` del `index.html`:

```html
<meta name="theme-color" content="#10b981">
```

### Actualizar Iconos

Los iconos están en formato SVG inline en `manifest.json`. Para cambiarlos:

1. Reemplaza el contenido SVG en la propiedad `icons`
2. Los tamaños recomendados son: **192x192px** y **512x512px**
3. Asegúrate de que tengan un **fondo sólido** y **maskable** (recortable)

## 🔧 Configuración de Despliegue

### Opción 1: GitHub Pages (Gratuito)

1. Sube los archivos a un repositorio en GitHub
2. Ve a **Settings → Pages**
3. Selecciona la rama `main` como source
4. Tu PWA estará en: `https://username.github.io/repo-name`

### Opción 2: Vercel (Recomendado)

1. Conecta tu repositorio a Vercel
2. Vercel despliegue automáticamente
3. Tu PWA estará en: `https://tu-proyecto.vercel.app`

### Opción 3: Servidor Personal

1. Sube los archivos a tu servidor web
2. Asegúrate de que se sirva con **HTTPS** (obligatorio para PWA)
3. Configura los headers correctos:

```
Cache-Control: no-cache
Content-Type: application/json (para manifest.json)
```

## 🔐 HTTPS Requerido

⚠️ **Las PWA solo funcionan en HTTPS** (excepto en localhost para desarrollo)

Si necesitas certificado SSL gratuito, usa [Let's Encrypt](https://letsencrypt.org/)

## 📊 Monitoreo

Para verificar que tu PWA está correctamente configurada:

1. Abre DevTools en Chrome (F12)
2. Ve a la pestaña **Application**
3. Verifica:
   - ✓ Manifest muestra correctamente
   - ✓ Service Worker está registrado
   - ✓ Storage/Cache funcionan

En Firefox:
1. Abre DevTools (F12)
2. Ve a la pestaña **Storage → Local Storage**
3. Verifica que se cache el contenido

## 🆘 Troubleshooting

### "No aparece el botón de instalar"

- Verifica que está en **HTTPS**
- Service Worker debe estar disponible sin errores
- Espera 30+ segundos después del primer acceso
- Prueba en otra ventana de incógnito

### "No se ve bien en iPhone"

- Borra caché: Settings → Safari → Advanced → Website Data
- Fuerza recarga: Safari → Menú → Reload
- Reinstala la app desde pantalla de inicio

### "Los cambios no se actualizan"

- El Service Worker cachea agresivamente
- Para forzar actualización: accede a la app y espera 60 segundos
- O: Settings → [App] → Eliminar app → Reinstalar

## 📚 Recursos

- [MDN - Progressive Web Apps](https://developer.mozilla.org/es/docs/Web/Progressive_web_apps)
- [Web.dev - PWA Checklist](https://web.dev/install-criteria/)
- [PWA Builder](https://www.pwabuilder.com/)

---

**Versión**: 1.0.0  
**Última actualización**: Marzo 2026  
**Desarrollador**: Tu Nombre o Empresa

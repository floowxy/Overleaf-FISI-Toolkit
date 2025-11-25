# Overleaf FISI Toolkit

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![Docker](https://img.shields.io/badge/Docker-Required-2496ED?logo=docker)](https://www.docker.com/)
[![Overleaf](https://img.shields.io/badge/Overleaf-Community%20Edition-47A141)](https://github.com/overleaf/toolkit)

## 📚 Sobre Este Proyecto

Este repositorio contiene mi implementación de **Overleaf Community Edition** utilizando el [Overleaf Toolkit oficial](https://github.com/overleaf/toolkit), configurado para uso académico en la **Facultad de Ingeniería de Sistemas e Informática (FISI)** de la **Universidad Nacional Mayor de San Marcos (UNMSM)**.

### Propósito

Este proyecto fue creado como parte de mi proceso de aprendizaje en tecnologías de contenedores (Docker), despliegue de aplicaciones web, y gestión de infraestructura. El objetivo es proporcionar una instancia de Overleaf accesible para estudiantes de FISI que necesiten colaborar en documentos LaTeX para trabajos académicos, artículos científicos, tesis y proyectos formales.

> **Nota Importante**: Este NO es un proyecto original mío. Es una implementación y configuración del [Overleaf Toolkit](https://github.com/overleaf/toolkit) desarrollado por el equipo de Overleaf. Todo el crédito del software base va para ellos.

## 🎓 Caso de Uso

- **Trabajos académicos** y documentación formal
- **Artículos científicos** y papers de investigación
- **Proyectos colaborativos** entre estudiantes
- **Tesis y monografías** en formato LaTeX
- **Aprendizaje** de LaTeX y herramientas de edición colaborativa

## 🛠️ Tecnologías Utilizadas

- **Docker & Docker Compose**: Contenedorización y orquestación
- **Overleaf Community Edition**: Editor LaTeX colaborativo
- **Cloudflare Tunnel**: Acceso seguro sin exponer puertos (opcional)
- **MongoDB**: Base de datos para almacenamiento
- **Redis**: Cache y gestión de sesiones
- **ShareLaTeX/Overleaf**: Motor de compilación LaTeX

## 🚀 Instalación y Configuración

### Requisitos Previos

- **Docker**: versión 20.10 o superior
- **Docker Compose**: versión 1.29 o superior
- **Sistema Operativo**: Linux recomendado (también funciona en macOS/Windows con WSL2)
- **RAM**: Mínimo 2GB disponibles (recomendado 4GB+)
- **Espacio en Disco**: Mínimo 10GB libres

### Instalación Rápida

```bash
# 1. Clonar el repositorio
git clone https://github.com/floowxy/Overleaf-FISI-Toolkit.git
cd Overleaf-FISI-Toolkit

# 2. Copiar el archivo de configuración de ejemplo
cp config/variables.env.example config/variables.env

# 3. Editar la configuración (personaliza según tus necesidades)
nano config/variables.env

# 4. Inicializar el toolkit
bin/init

# 5. Levantar los servicios
bin/up
```

### Acceso Local

Una vez iniciados los servicios, accede a Overleaf en:

- **URL Local**: <http://localhost> (puerto 80 por defecto)

### Crear Primer Usuario Administrador

```bash
# Crear usuario admin
bin/docker-compose exec sharelatex /bin/bash -c "cd /overleaf/services/web && node modules/server-ce-scripts/scripts/create-admin-user --email=admin@example.com"
```

## ⚙️ Configuración Personalizada

### Variables de Entorno

Edita `config/variables.env` para personalizar:

```env
# Branding
OVERLEAF_APP_NAME="Overleaf FISI"
OVERLEAF_NAV_TITLE="Overleaf FISI"

# Administración
OVERLEAF_ADMIN_EMAIL=tu-email@unmsm.edu.pe

# Características educativas
EMAIL_CONFIRMATION_DISABLED=true
ENABLED_LINKED_FILE_TYPES=project_file,project_output_file
ENABLE_CONVERSIONS=true
```

Ver [`config/variables.env.example`](config/variables.env.example) para todas las opciones disponibles.

## 🌐 Acceso Público con Cloudflare Tunnel (Opcional)

Si quieres hacer tu instancia accesible desde Internet sin abrir puertos, puedes usar Cloudflare Tunnel.

### Ventajas

- ✅ No necesitas IP pública estática
- ✅ No abres puertos en tu firewall
- ✅ SSL/HTTPS gratuito
- ✅ Protección DDoS de Cloudflare

### Configuración Básica

1. **Instala cloudflared** en tu servidor (ver [documentación](doc/cloudflare-tunnel-setup.md))
2. **Configura las variables de entorno** en `config/variables.env`:

   ```env
   OVERLEAF_SITE_URL=https://tu-dominio.com
   OVERLEAF_BEHIND_PROXY=true
   OVERLEAF_SECURE_COOKIE=true
   ```

3. **Sigue la guía completa** en [`doc/cloudflare-tunnel-setup.md`](doc/cloudflare-tunnel-setup.md)

> ⚠️ **Nota de Seguridad**: Nunca subas tus credenciales de Cloudflare Tunnel a Git. El directorio `.cloudflared/` ya está protegido en `.gitignore`.

## 📖 Documentación

- [`doc/quick-start-guide.md`](doc/quick-start-guide.md) - Guía rápida oficial
- [`doc/configuration.md`](doc/configuration.md) - Opciones de configuración
- [`doc/cloudflare-tunnel-setup.md`](doc/cloudflare-tunnel-setup.md) - Setup de Cloudflare Tunnel
- [Overleaf Wiki](https://github.com/overleaf/overleaf/wiki) - Documentación oficial completa

## 🔧 Comandos Útiles

```bash
# Iniciar servicios
bin/up

# Detener servicios
bin/stop

# Ver logs
bin/logs

# Reiniciar servicios
bin/restart

# Diagnóstico del sistema
bin/doctor

# Actualizar Overleaf
bin/upgrade

# Acceder al shell del contenedor
bin/shell
```

## 📂 Estructura del Proyecto

```
.
├── bin/                    # Scripts de gestión del toolkit
├── config/                 # Archivos de configuración
│   ├── variables.env.example  # Configuración de ejemplo
│   └── variables.env       # Tu configuración (no en Git)
├── data/                   # Datos persistentes (no en Git)
│   ├── mongo/              # Base de datos MongoDB
│   ├── redis/              # Cache Redis
│   └── overleaf/           # Archivos de Overleaf
├── doc/                    # Documentación
├── lib/                    # Archivos de Docker Compose
└── LICENSE                 # Licencia AGPL-3.0
```

## 🔒 Seguridad y Privacidad

### Archivos Protegidos (No en Git)

Los siguientes archivos/directorios contienen información sensible y están protegidos por `.gitignore`:

- `config/variables.env` - Configuración con datos específicos
- `config/overleaf.rc` - Configuración de runtime
- `data/` - Todos los datos de la instancia
- `.cloudflared/` - Credenciales de Cloudflare Tunnel

### Mejores Prácticas

1. ✅ **Nunca compartas** tu archivo `config/variables.env`
2. ✅ **Haz backups regulares** del directorio `data/`
3. ✅ **Usa contraseñas fuertes** para cuentas de admin
4. ✅ **Mantén actualizado** Docker y Overleaf
5. ✅ **Revisa los logs** regularmente con `bin/logs`

## 🤝 Contribuir

### A Este Proyecto

Si encuentras mejoras para la configuración o documentación:

1. Fork este repositorio
2. Crea una rama con tu mejora (`git checkout -b mejora/descripcion`)
3. Commit tus cambios (`git commit -m 'Descripción de la mejora'`)
4. Push a la rama (`git push origin mejora/descripcion`)
5. Abre un Pull Request

### Al Proyecto Original

Para contribuir al Overleaf Toolkit oficial:

- Repositorio: <https://github.com/overleaf/toolkit>
- Guía: [CONTRIBUTING.md](https://github.com/overleaf/overleaf/blob/main/CONTRIBUTING.md)

## 📝 Licencia

Este proyecto mantiene la licencia original del Overleaf Toolkit:

**GNU Affero General Public License v3.0 (AGPL-3.0)**

Ver [LICENSE](LICENSE) para el texto completo.

### ¿Qué significa?

- ✅ Puedes usar este software libremente
- ✅ Puedes modificarlo según tus necesidades
- ✅ Puedes distribuir tu versión modificada
- ⚠️ Debes mantener la misma licencia AGPL-3.0
- ⚠️ Debes compartir el código fuente de tus modificaciones
- ⚠️ Si ofreces el servicio públicamente, debes proporcionar el código

## 🙏 Agradecimientos

- **[Overleaf Team](https://www.overleaf.com)** - Por crear y mantener este excelente software open source
- **[Overleaf Toolkit](https://github.com/overleaf/toolkit)** - Por proporcionar las herramientas de despliegue
- **FISI - UNMSM** - Por el ambiente académico que motiva este tipo de proyectos
- **Comunidad de LaTeX** - Por el ecosistema de herramientas

## 🔗 Enlaces Relacionados

- [Overleaf Official](https://www.overleaf.com)
- [Overleaf GitHub](https://github.com/overleaf)
- [Overleaf Wiki](https://github.com/overleaf/overleaf/wiki)
- [LaTeX Project](https://www.latex-project.org/)
- [FISI - UNMSM](https://sistemas.unmsm.edu.pe)
- [Cloudflare Tunnel Docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)

## 📧 Contacto

**Diego Sotelo**  
Estudiante de Ingeniería de Sistemas - FISI UNMSM  
Email: <diego.sotelo@unmsm.edu.pe>

---

<p align="center">
  <i>Proyecto académico desarrollado con fines educativos</i><br>
  <i>FISI - Universidad Nacional Mayor de San Marcos</i><br>
  <i>2025</i>
</p>

# Script de Configuración y Personalización para Arch Linux

Este script automatiza la instalación y configuración de varios paquetes esenciales en un sistema Arch Linux, incluyendo el entorno de escritorio GNOME, herramientas de desarrollo, controladores gráficos, códecs multimedia, aplicaciones de Flatpak y más. Además, instala y configura MySQL Server, MySQL Workbench, DB Manager, y algunas aplicaciones útiles.

## Requisitos

- **Arch Linux**: El script está diseñado para funcionar en una instalación limpia de Arch Linux.
- **Conexión a Internet**: Se requieren conexiones a internet para descargar los paquetes y actualizar el sistema.

## Funciones del Script

Este script realiza las siguientes tareas:

### 1. **Instalar y configurar GNOME**
   - Instala el entorno de escritorio GNOME.
   - Habilita el administrador de pantalla `gdm` para iniciar GNOME.

### 2. **Actualizar el sistema y habilitar repositorio multilib**
   - Actualiza el sistema a la última versión.
   - Habilita el repositorio `multilib` para permitir la instalación de paquetes de 32 bits.

### 3. **Instalar herramientas esenciales**
   - Instala paquetes como `base-devel`, `linux-headers`, `git`, `curl` y `zsh`.

### 4. **Instalar yay (AUR helper)**
   - Instala `yay` para facilitar la instalación de paquetes desde AUR.

### 5. **Instalar códecs privativos multimedia**
   - Instala códecs necesarios como `gst-libav`, `gst-plugins-ugly`, `libdvdcss` y `ffmpeg`.

### 6. **Instalar fuentes de Microsoft Office**
   - Instala las fuentes de Microsoft Office a través de AUR (`ttf-ms-fonts`).

### 7. **Instalar controladores NVIDIA**
   - Instala los controladores `nvidia` y configura `prime-run` para optimizar el rendimiento gráfico.

### 8. **Configurar Zsh con Oh My Zsh y Powerlevel10k**
   - Configura `zsh` como el shell predeterminado.
   - Instala y configura `Oh My Zsh` y el tema `Powerlevel10k`.

### 9. **Instalar aplicaciones de GNOME**
   - Instala aplicaciones de GNOME como `gedit`, `evince`, `eog` y `gvfs-smb`.

### 10. **Instalar Java (JDK y JRE)**
   - Instala OpenJDK y configura la variable de entorno `JAVA_HOME`.

### 11. **Instalar Python, pip y Tkinter**
   - Instala `python`, `pip` y `Tkinter` para desarrollo en Python.

### 12. **Instalar Flatpak y aplicaciones Flatpak**
   - Instala `flatpak` y agrega el repositorio `flathub`.
   - Instala aplicaciones populares como `OBS Studio`, `Kdenlive` y `Notes` desde Flatpak.

### 13. **Instalar y configurar NetworkManager**
   - Instala y habilita `NetworkManager` para gestionar conexiones de red.

### 14. **Instalar y activar Blueman y Bluez**
   - Instala y habilita los servicios de Bluetooth (`blueman`, `bluez`, `bluez-utils`).

### 15. **Instalar MySQL Server y herramientas asociadas**
   - Instala MySQL Server y lo inicializa.
   - Instala `MySQL Workbench` y `DB Manager`.

## Uso

1. **Clona o descarga este repositorio**:
   - Abre una terminal y clona este repositorio usando Git:

   ```bash
   git clone https://github.com/tu_usuario/tu_repositorio.git


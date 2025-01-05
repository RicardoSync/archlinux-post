#!/bin/bash

# Colores para salida
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

# Función para mostrar mensajes
function echo_info {
    echo -e "${GREEN}$1${NC}"
}

function echo_error {
    echo -e "${RED}$1${NC}"
}

# Instalar GNOME
echo_info "Instalando GNOME y aplicaciones relacionadas..."
sudo pacman -S --noconfirm gnome-shell gnome-control-center gnome-terminal gnome-keyring nautilus file-roller firefox gdm
sudo systemctl enable --now gdm

# Actualizar sistema y habilitar multilib
echo_info "Actualizando sistema y habilitando repositorio multilib..."
sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

# Instalar herramientas esenciales
echo_info "Instalando herramientas esenciales..."
sudo pacman -S --noconfirm base-devel linux-headers git curl zsh

# Instalar yay (AUR helper) si no está instalado
if ! command -v yay &>/dev/null; then
    echo_info "Instalando yay (AUR helper)..."
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo_info "yay ya está instalado."
fi

# Instalar códecs privativos multimedia
echo_info "Instalando códecs privativos multimedia..."
sudo pacman -S --noconfirm gst-libav gst-plugins-ugly libdvdcss ffmpeg

# Instalar fuentes de Microsoft Office
echo_info "Instalando fuentes de Microsoft Office..."
yay -S --noconfirm ttf-ms-fonts

# Instalar controladores NVIDIA y prime-run
echo_info "Instalando controladores NVIDIA y configurando prime-run..."
sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings nvidia-prime

# Configurar Zsh con Oh My Zsh y Powerlevel10k
echo_info "Instalando y configurando Zsh, Oh My Zsh y Powerlevel10k..."
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
    echo_error "No se pudo instalar Oh My Zsh."
}
yay -S --noconfirm zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

# Instalar aplicaciones de GNOME
echo_info "Instalando aplicaciones de GNOME..."
sudo pacman -S --noconfirm gedit evince eog gvfs-smb

# Instalar Java (JDK y JRE)
echo_info "Instalando Java (JDK y JRE)..."
sudo pacman -S --noconfirm jre-openjdk jdk-openjdk
echo_info "Configurando JAVA_HOME..."
echo 'export JAVA_HOME=/usr/lib/jvm/default' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Instalar pip para Python y Tkinter
echo_info "Instalando Python, pip y Tkinter..."
sudo pacman -S --noconfirm python python-pip tk

# Instalar Flatpak
echo_info "Instalando Flatpak..."
sudo pacman -S --noconfirm flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalar y configurar temas adw-gtk
echo_info "Instalando y configurando temas adw-gtk..."
sudo pacman -S --noconfirm adw-gtk-theme
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark

# Instalar y activar NetworkManager
echo_info "Instalando y activando NetworkManager..."
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable --now NetworkManager

# Instalar y activar Blueman y Bluez
echo_info "Instalando y activando Blueman y Bluez..."
sudo pacman -S --noconfirm blueman bluez bluez-utils
sudo systemctl enable --now bluetooth.service

# Instalar MySQL y configurar
echo_info "Instalando MySQL..."
sudo pacman -S --noconfirm mysql
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mysqld
sudo systemctl start mysqld  # Asegurarse de que MySQL se inicie

# Instalar Snapd
echo_info "Instalando Snapd..."
git clone https://aur.archlinux.org/snapd.git
cd snapd || exit
makepkg -si --noconfirm
cd ..
rm -rf snapd
sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
sudo ln -s /var/lib/snapd/snap /snap

# Instalar aplicaciones de Flatpak
echo_info "Instalando aplicaciones de Flatpak..."
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.kde.kdenlive -y
flatpak install flathub io.github.nuttyartist.notes -y

# Verificar instalaciones
echo_info "Verificando instalaciones..."
echo -n "Python: " && python --version
echo -n "pip: " && pip --version
echo -n "Java: " && java -version
echo -n "Flatpak: " && flatpak --version
echo -n "MySQL: " && mysql --version

# Finalización
echo_info "Configuración completada. Reinicia tu sistema para aplicar todos los cambios."
sudo systemctl start gdm


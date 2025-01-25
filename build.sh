#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# enable copr repos
dnf5 -y copr enable alternateved/bleeding-emacs
dnf5 -y copr enable atim/lazygit
dnf5 -y copr enable atim/nushell
dnf5 -y copr enable atim/starship
dnf5 -y copr enable nucleo/gocryptfs
dnf5 -y copr enable peterwu/iosevka
dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable varlad/zellij
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 -y copr enable alebastr/swayr
dnf5 -y copr enable yalter/niri
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y copr enable meeuw/alot
dnf5 -y copr enable ecomaikgolf/typst

curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | tee /etc/yum.repos.d/terra.repo
# dnf config-manager --add-repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
rpm-ostree install terra-release

# this installs a package from fedora repos
rpm-ostree install atool akregator alot mailcap aerc msmtp
      # - appimagelauncher
rpm-ostree install bat bemenu
      # - bettercap
rpm-ostree install blueman cargo cryfs digikam distrobox dconf-editor dolphin egl-wayland entr
      # epiphany is the package name of gnome web
      # - epiphany
rpm-ostree install eww eza fastfetch fbreader fd-find firewall-config foot foot-terminfo fzf gh glances bpytop glibc-locale-source gocryptfs grim gparted gvfs-gphoto2 gvfs-afc hotspot imv
      # - gtk3 gnome-tweaks # removed to test if this removes the gtk portal
      # - insync
      # - intel-media-driver
rpm-ostree install inxi j4-dmenu-desktop jrnl kalendar kamera kf5-solid kf6-solid kio-gdrive kio-extras-kf5 kio-fuse kio-ftps kjournald kontact ksystemlog kwallet-pam kanshi libimobiledevice libimobiledevice-utils libusb light lm_sensors lshw luarocks lynx macchanger mako mediainfo mpv neochat network-manager-applet NetworkManager-tui catimg
rpm-ostree install youtube-dl
      # - niri
      # - nnn
      # - nvidia-vaapi-driver
rpm-ostree install nvtop
# - openh264
rpm-ostree install openssl-devel pasystray perf perl-File-MimeInfo plasma-wayland-protocols
      # removed by EC 2025.01.11 to test on sway auna usb player : pulseaudio-utils
      # - qutebrowser
      # - qt5-qtwebengine-freeworld
rpm-ostree install qt6-qtwayland
      # - qtile
rpm-ostree install samba
      # - sddm
      # - sddm-wayland-sway
      # - sddm-wayland-generic
rpm-ostree install cosmic-desktop miracle-wm
rpm-ostree install xdg-desktop-portal-hyprland hyprland-plugins hyprpaper hypridle hyprlock hyprpolkitagent hyprsysteminfo hyprshot hyprnome hyprdim
      # removed: hyprland hyprland-devel cmake meson cpio
rpm-ostree install strace
      # - sway
rpm-ostree install systemd trash-cli gdu duc usbip udisks2 udiskie variety virt-install virt-manager virt-top virt-viewer w3m 
      # - wayfire
rpm-ostree install tlp powertop
# rpm-ostree install power-profiles-daemon
      # - xorg-x11-drv-nvidia-cuda

# needed for youtube-dl
rpm-ostree install python3-pip

########################################################################################################
# NEW SORT BY PURPOSE
########################################################################################################

# sway and wayland
rpm-ostree install slurp wdisplays wl-clipboard wofi xdg-desktop-portal-wlr swaybg swayr swayidle swaylock sway-systemd waybar
rpm-ostree install river rofi-wayland 

# gtk libs
rpm-ostree install webkit2gtk3 webkit2gtk4.0 gtk4-devel libadwaita-devel libadwaita 

# taskwarrior
rpm-ostree install taskopen 

# development tools
rpm-ostree install tmux zellij lazygit git zoxide
rpm-ostree install tilix wezterm kitty kitty-terminfo starship 
rpm-ostree install fish nushell
rpm-ostree install neovim
rpm-ostree install the_silver_searcher ripgrep 

# text pdf stuff
rpm-ostree install odt2txt pandoc zathura typst

# network tools
rpm-ostree install netscanner nmap sshfs 

rpm-ostree uninstall firefox firefox-langpacks

# flatpak install flathub com.brave.Browser
# flatpak uninstall org.gnome.eog

# this would install a package from rpmfusion
# rpm-ostree install vlc

# download and install 1password
curl https://downloads.1password.com/linux/keys/1password.asc | tee /etc/pki/rpm-gpg/RPM-GPG-KEY-1password
sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=0\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-1password" > /etc/yum.repos.d/1password.repo'

# sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=0\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-1password" > /etc/yum.repos.d/1password.repo'
# curl -O https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
# mkdir -p /opt/1Password
# dnf5 -y install 1password 1password-cli

# mkdir -p /usr/local/bin /usr/local/lib
# pip install --prefix /usr --upgrade youtube-dl

#### Example for enabling a System Unit File

systemctl enable podman.socket

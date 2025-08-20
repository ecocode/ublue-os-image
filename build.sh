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
# dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable varlad/zellij
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 -y copr enable alebastr/swayr
dnf5 -y copr enable yalter/niri-git
# yalter/niri is stable
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y copr enable meeuw/alot
# dnf5 -y copr enable ecomaikgolf/typst
dnf5 -y copr enable ulysg/xwayland-satellite
# only for fedora42
# dnf5 -y copr enable burhanverse/ghostty
dnf5 -y copr enable atim/kakoune

curl -fsSL https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo | tee /etc/yum.repos.d/virtio-win.repo

curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | tee /etc/yum.repos.d/terra.repo
# dnf config-manager --add-repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
rpm-ostree install terra-release

# dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/cuda-fedora41.repo
# curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/cuda-fedora41.repo | tee /etc/yum.repos.d/cuda.repo

# this installs a package from fedora repos
rpm-ostree install atool akregator alot mailcap msmtp aerc notmuch
# - appimagelauncher
rpm-ostree install bat
# - bettercap
rpm-ostree install blueman cryfs digikam distrobox dconf-editor dolphin entr
# epiphany is the package name of gnome web
# - epiphany
rpm-ostree install eza fastfetch fbreader fd-find firewall-config foot foot-terminfo fzf gh glances bpytop glibc-locale-source gocryptfs grim gparted gvfs-gphoto2 gvfs-afc hotspot imv
# - gtk3 gnome-tweaks # removed to test if this removes the gtk portal
# - insync
# - intel-media-driver
rpm-ostree install j4-dmenu-desktop jrnl kalendar kamera kf5-solid kf6-solid kio-gdrive kio-extras-kf5 kio-fuse kio-ftps kjournald kontact ksystemlog kwallet-pam kanshi libimobiledevice libimobiledevice-utils libusb light lm_sensors lshw luarocks lynx macchanger mako mediainfo mpv neochat fractal network-manager-applet NetworkManager-tui catimg
rpm-ostree install inxi nvtop drm_info
# rpm-ostree install youtube-dl
# - niri
# - nnn
# - nvidia-vaapi-driver
rpm-ostree install openssl-devel pasystray perf perl-File-MimeInfo plasma-wayland-protocols
# removed by EC 2025.01.11 to test on sway auna usb player : pulseaudio-utils
# - qutebrowser
# - qt5-qtwebengine-freeworld
rpm-ostree install qt6-qtwayland
# - qtile
# - sddm
# - sddm-wayland-sway
# - sddm-wayland-generic
rpm-ostree install cosmic-desktop miracle-wm niri xwayland-satellite kvantum
# rpm-ostree install xdg-desktop-portal-hyprland hyprland-plugins hyprpaper hypridle hyprlock hyprsysteminfo hyprshot hyprnome hyprdim
# removed: hyprland hyprland-devel cmake meson cpio
rpm-ostree install strace
# - sway
rpm-ostree install systemd trash-cli gdu duc usbip fwupd udisks2 udiskie wev wpaperd virt-install virt-manager virt-top virt-viewer virtio-win cockpit cockpit-machines cockpit-ostree cockpit-podman w3m samba
# - wayfire
rpm-ostree install tlp powertop
# rpm-ostree install power-profiles-daemon
# - xorg-x11-drv-nvidia-cuda
# These are needed for pdftools inside emacs
rpm-ostree install autoconf automake gcc libpng-devel make ninja-build poppler-devel poppler-glib-devel zlib-devel pkgconf

########################################################################################################
# NEW SORT BY PURPOSE
########################################################################################################

# sway and wayland
rpm-ostree install slurp wdisplays wl-clipboard wofi xdg-desktop-portal-wlr swaybg swayr swayidle swaylock sway-systemd waybar
rpm-ostree install river rofi-wayland bemenu
rpm-ostree install ibus gnome-keyring
# for compiling wlroots myself for mangowc - conflicting
# rpm-ostree install egl-wayland libglvnd-egl libseat-devel wayland-protocols-devel wayland-devel mesa-libEGL-devel mesa-libGLES-devel mesa-dri-drivers xorg-x11-server-Xwayland libgbm-devel libxkbcommon-devel libudev-devel pixman-devel libinput-devel libevdev-devel systemd-devel cairo-devel libpcap-devel json-c-devel pam-devel pango-devel pcre-devel gdk-pixbuf2-devel hwdata-devel
# rpm-ostree install libdrm libdrm-devel libdisplay-info

# system tools
rpm-ostree install borgbackup vorta

# gtk libs
rpm-ostree install webkit2gtk3 webkit2gtk4.0 gtk4-devel libadwaita-devel libadwaita

# taskwarrior
# rpm-ostree install taskopen

# development tools
rpm-ostree install tmux zellij lazygit git zoxide
rpm-ostree install tilix wezterm kitty kitty-terminfo starship ghostty ghostty-fish-completion ghostty-terminfo
rpm-ostree install fish nushell direnv
rpm-ostree install neovim emacs kakoune kakoune-lsp tree-sitter-cli global
rpm-ostree install the_silver_searcher ripgrep
# rpm-ostree install cuda-toolkit nvidia-gds

# text pdf stuff
rpm-ostree install odt2txt pandoc zathura zathura-pdf-poppler zathura-djvu zathura-ps a2ps ghostscript

# network tools
rpm-ostree install netscanner nmap sshfs

# don't uninstall firefox on aurora because it is not installed and error's out
rpm-ostree uninstall firefox firefox-langpacks

rpm-ostree install gimp3 dia flameshot

# flatpak install flathub com.brave.Browser
# flatpak uninstall org.gnome.eog

# flatpak install org.kde.krita

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

#### Example for enabling a System Unit File

systemctl enable podman.socket

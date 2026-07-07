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
dnf5 -y copr enable dejan/lazygit
dnf5 -y copr enable atim/nushell
dnf5 -y copr enable atim/starship
dnf5 -y copr enable nucleo/gocryptfs
dnf5 -y copr enable aquacash5/nerd-fonts
dnf5 -y copr enable varlad/zellij
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 -y copr enable alebastr/swayr
dnf5 -y copr enable yalter/niri-git
dnf5 -y copr enable mecattaf/duoRPM
# yalter/niri is stable
dnf5 -y copr enable ryanabx/cosmic-epoch
# dnf5 -y copr enable ecomaikgolf/typst
dnf5 -y copr enable ulysg/xwayland-satellite
# only for fedora42
# dnf5 -y copr enable burhanverse/ghostty
# dnf5 -y copr enable atim/kakoune
dnf5 -y copr enable errornointernet/klassy
dnf5 -y copr enable avengemedia/dms-git
# dnf5 -y copr enable avengemedia/dms
# dnf5 -y copr enable avengemedia/danklinux
dnf5 -y copr enable errornointernet/quickshell
# dnf5 -y copr enable dennemann/MangoWC
# dnf5 -y copr enable @ai-ml/nvidia-container-toolkit
dnf5 -y copr enable errornointernet/walker
# for uwsm
# dnf5 -y copr enable solopasha/hyprland
# dnf5 -y copr enable blacktau/hyprland
dnf5 -y copr enable lionheartp/Hyprland

curl -fsSL https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo | tee /etc/yum.repos.d/virtio-win.repo

curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | tee /etc/yum.repos.d/terra.repo
# dnf config-manager --add-repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo

echo "priority=1" | tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:yalter:niri-git.repo
echo "priority=3" | tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:lionheartp:Hyprland.repo
echo "priority=2" | tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:errornointernet:quickshell.repo
echo "priority=2" | tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:errornointernet:walker.repo
echo "priority=4" | tee -a /etc/yum.repos.d/terra.repo

# this should remove all cache
# rpm-ostree cleanup -m

dnf5 -y install terra-release

dnf5 -y remove mako nano nano-default-editor
dnf5 -y remove xwaylandvideobridge
dnf5 -y remove steam steam-devices steamdeck-kde-presets-desktop
dnf5 -y remove tuned tuned-ppd
dnf5 -y remove pasystray blueman

dnf5 -y remove firefox firefox-langpacks

# dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/cuda-fedora41.repo
# curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/cuda-fedora41.repo | tee /etc/yum.repos.d/cuda.repo

dnf5 -y install mesa-vulkan-drivers vulkan-tools
dnf5 -y install nvidia-container-toolkit
# nvidia-container-toolkit-selinux

# download and install 1password
# rpm-ostree install 1password
# rpm-ostree install 1password-cli
mkdir -p /usr/Downloads
curl --output-dir /usr/Downloads -O https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
curl --output-dir /usr/Downloads -O https://downloads.1password.com/linux/rpm/stable/x86_64/1password-cli-latest.rpm
# curl --follow --output-dir /usr/Downloads -o ares-latest.rpm https://www.graebert.com/cad-software/download/ares-commander/linux/rpm/latest
# curl --output-dir /usr/Downloads -o ares-latest.rpm https://files.graebert.com/ares/26.3.1.4145/ARES-Commander-2026-26.3.1.4145-x86_64.rpm
# rpm-ostree install ./1password-latest.rpm
# rpm-ostree install ./1password-cli-latest.rpm
# rm 1password-latest.rpm
# rm 1password-cli-latest.rpm

# needed for creality print
dnf5 -y install bzip2 bzip2-libs

# this installs a package from fedora repos
dnf5 -y install atool akregator mailcap msmtp
# aerc notmuch
# - appimagelauncher
dnf5 -y install bat
# - bettercap
# - blueman
dnf5 -y install cryfs digikam toolbox distrobox dconf-editor dolphin entr thunar thunar-archive-plugin insync
# epiphany is the package name of gnome web
# - epiphany
dnf5 -y install eza fastfetch fbreader fd-find firewall-config fzf gh glances glibc-locale-source gocryptfs grim gparted gvfs-gphoto2 gvfs-afc hotspot imv
# - gtk3 gnome-tweaks # removed to test if this removes the gtk portal
# - insync
# - intel-media-driver
dnf5 -y install j4-dmenu-desktop jrnl kalendar kamera kf5-solid kf6-solid kio-gdrive kio-extras-kf5 kio-fuse kio-ftps kjournald kontact ksystemlog kwallet-pam kanshi libimobiledevice libimobiledevice-utils libusb light lm_sensors lshw luarocks lynx macchanger mediainfo mpv neochat fractal dino catimg NetworkManager-tui

# dnf5 -y install mako network-manager-applet foot foot-terminfo variety
dnf5 -y install inxi nvtop drm_info
# dnf5 -y install youtube-dl
# - niri
# - nnn
# - nvidia-vaapi-driver
# - miracle-wm river
dnf5 -y install openssl-devel perf perl-File-MimeInfo plasma-wayland-protocols
# - pasystray

# removed by EC 2025.01.11 to test on sway auna usb player : pulseaudio-utils
# - qutebrowser
# - qt5-qtwebengine-freeworld
dnf5 -y install qt6-qtwayland
# - qtile
# - sddm
# - sddm-wayland-sway
# - sddm-wayland-generic
dnf5 -y install scroll xwayland-satellite klassy
# kvantum materia-kde-kvantum
dnf5 -y install niri mangowm xdg-desktop-portal-gtk dms brightnessctl cava cliphist matugen
# for compiling somewm and pinnacle, see repository
dnf5 -y install meson luajit luajit-devel lua-lgi cairo-devel pango-devel gdk-pixbuf2-devel wayland-devel wayland-protocols-devel libinput-devel libxkbcommon-devel libdrm-devel xorg-x11-server-Xwayland xorg-x11-server-Xwayland-devel libxcb-devel xcb-util-devel xcb-util-wm-devel xcb-util-renderutil-devel dbus-devel glib2-devel libasan libubsan protobuf-compiler
# wlroots0.19-devel

# removed cosmic-desktop
# stuff for wallpapers
dnf5 -y install kde-wallpapers plasma-workspace-wallpapers arc-kde-wallpapers materia-kde-wallpapers plasma-wallpapers-dynamic constantine-backgrounds-kde krfb akonadiconsole
# dnf5 -y install xdg-desktop-portal-hyprland hyprland-plugins hyprpaper hypridle hyprlock hyprsysteminfo hyprshot hyprnome hyprdim hyprpicker
# removed: hyprland hyprland-devel cmake meson cpio
# Hyprland
dnf5 -y install hyprland
dnf5 -y install hyprland-guiutils hypridle hyprlock hyprlauncher hyprpolkitagent hyprcursor hyprpicker xdg-desktop-portal-hyprland hyprland-qt-support hyprpolkitagent
# hyprsunset hyprshutdown hyprland-plugins gpu-screen-recorder

dnf5 -y install strace
# - sway
dnf5 -y install systemd uwsm trash-cli gdu duc usbip fwupd udisks2 udiskie wev wpaperd virt-install virt-manager virt-top virt-viewer virtio-win edk2-ovmf swtpm swtpm-tools cockpit cockpit-machines cockpit-ostree cockpit-podman podman-compose w3m samba ddclient
# - wayfire
dnf5 -y install tlp powertop acpi
# rpm-ostree install power-profiles-daemon
# - xorg-x11-drv-nvidia-cuda
# These are needed for pdftools inside emacs
dnf5 -y install autoconf automake gcc gcc-c++ libpng-devel pipewire-devel make ninja-build libvterm poppler poppler-devel poppler-glib-devel pdf-tools pkgconf patch
dnf5 -y install emacs global

########################################################################################################
# NEW SORT BY PURPOSE
########################################################################################################

# sway and wayland
dnf5 -y install slurp wdisplays wl-clipboard wofi xdg-desktop-portal-wlr swaybg swayr swayidle swaylock sway-systemd wf-recorder
dnf5 -y install rofi-wayland bemenu walker elephant
dnf5 -y install ibus gnome-keyring

# for ewm
dnf5 -y install systemd-devel

# for compiling wlroots myself for mangowc - conflicting
# rpm-ostree install egl-wayland libglvnd-egl libseat-devel wayland-protocols-devel wayland-devel mesa-libEGL-devel mesa-libGLES-devel mesa-dri-drivers xorg-x11-server-Xwayland libgbm-devel libxkbcommon-devel libudev-devel pixman-devel libinput-devel libevdev-devel systemd-devel cairo-devel libpcap-devel json-c-devel pam-devel pango-devel pcre-devel gdk-pixbuf2-devel hwdata-devel
# rpm-ostree install libdrm libdrm-devel libdisplay-info

# system tools
dnf5 -y install borgbackup vorta python3-llfuse fuse3-devel fuse3-libs fuse3 libacl-devel

# gtk libs
dnf5 -y install gtk4-devel libadwaita-devel libadwaita webkit2gtk4.1
# FC43 doesn't have webkit2gtk3 webkit2gtk4.0

# taskwarrior
# rpm-ostree install taskopen

# development tools
dnf5 -y install tmux zellij lazygit git zoxide
dnf5 -y install kitty kitty-terminfo wezterm ghostty starship
# rpm-ostree install tilix ghostty ghostty-fish-completion ghostty-terminfo
dnf5 -y install fish nushell direnv
# rpm-ostree install neovim kakoune tree-sitter-cli global
dnf5 -y install the_silver_searcher ripgrep
# rpm-ostree install cuda-toolkit nvidia-gds

# text pdf stuff
dnf5 -y install odt2txt pandoc zathura zathura-pdf-poppler zathura-djvu zathura-ps a2ps ghostscript okular

# fonts
dnf5 -y install iosevka-nerd-fonts fira-code-nerd-fonts roboto-mono-nerd-fonts droid-sans-mono-nerd-fonts deja-vu-sans-mono-nerd-fonts monofur-nerd-fonts jet-brains-mono-nerd-fonts rsms-inter-fonts

# network tools
dnf5 -y install nmap sshfs wireshark
# netscanner not in fedora43

# flatpak install flathub com.brave.Browser
# flatpak uninstall org.gnome.eog

# flatpak install org.kde.krita

# this would install a package from rpmfusion
# rpm-ostree install vlc

# mkdir -p /usr/local/bin /usr/local/lib

dnf5 -y install gimp3 blender dia flameshot

# rpm-ostree install /custom-rpm/kyodialog-9.3-0.x86_64.rpm
# rpm-ostree install /custom-rpm/insync-3.9.4.60020-fc40.x86_64.rpm
# rpm-ostree install /custom-rpm/ARES-Commander-2026-26.3.1.4145-x86_64.rpm
# rpm-ostree install /custom-rpm/expressvpn-3.69.0.0-1.x86_64.rpm

# this seems not allowed
# rpm-ostree install https://files.graebert.com/ares/26.3.1.4145/ARES-Commander-2026-26.3.1.4145-x86_64.rpm
# rpm-ostree install /usr/Downloads/ares-latest.rpm
# rm /usr/Downloads/ares-latest.rpm


#### Example for enabling a System Unit File
# we only use a --user podman.socket
# systemctl enable podman.socket

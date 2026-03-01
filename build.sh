#!/bin/bash

set -ouex pipefail


RELEASE="$(rpm -E %fedora)"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# enable copr repos
# dnf5 -y copr enable alternateved/bleeding-emacs
dnf5 -y copr enable dejan/lazygit
dnf5 -y copr enable atim/nushell
dnf5 -y copr enable atim/starship
dnf5 -y copr enable nucleo/gocryptfs
# dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable aquacash5/nerd-fonts
dnf5 -y copr enable varlad/zellij
# dnf5 -y copr enable wezfurlong/wezterm-nightly
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
dnf5 -y copr enable avengemedia/danklinux
dnf5 -y copr enable errornointernet/quickshell
dnf5 -y copr enable dennemann/MangoWC
dnf5 -y copr enable @ai-ml/nvidia-container-toolkit

echo "priority=1" | tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:yalter:niri-git.repo
echo "priority=2" | tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:errornointernet:quickshell.repo

curl -fsSL https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo | tee /etc/yum.repos.d/virtio-win.repo

curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | tee /etc/yum.repos.d/terra.repo
# dnf config-manager --add-repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
rpm-ostree install terra-release

rpm-ostree uninstall --idempotent mako nano nano-default-editor || true
rpm-ostree uninstall --idempotent xwaylandvideobridge || true
rpm-ostree uninstall --idempotent steam steam-devices steamdeck-kde-presets-desktop || true
rpm-ostree uninstall --idempotent tuned tuned-ppd || true

rpm-ostree uninstall --idempotent firefox firefox-langpacks || true

# dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/cuda-fedora41.repo
# curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/cuda-fedora41.repo | tee /etc/yum.repos.d/cuda.repo

rpm-ostree install -C mesa-vulkan-drivers
rpm-ostree install -C nvidia-container-toolkit nvidia-container-toolkit-selinux

# download and install 1password
# rpm-ostree install -C 1password
# rpm-ostree install -C 1password-cli
mkdir -p /usr/Downloads
curl --output-dir /usr/Downloads -O https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
curl --output-dir /usr/Downloads -O https://downloads.1password.com/linux/rpm/stable/x86_64/1password-cli-latest.rpm
# rpm-ostree install -C ./1password-latest.rpm
# rpm-ostree install -C ./1password-cli-latest.rpm
# rm 1password-latest.rpm
# rm 1password-cli-latest.rpm

# this installs a package from fedora repos
rpm-ostree install -C atool akregator mailcap msmtp
# aerc notmuch
# - appimagelauncher
rpm-ostree install -C bat
# - bettercap
rpm-ostree install -C blueman cryfs digikam toolbox distrobox dconf-editor dolphin entr thunar thunar-archive-plugin insync
# epiphany is the package name of gnome web
# - epiphany
rpm-ostree install -C eza fastfetch fbreader fd-find firewall-config fzf gh glances glibc-locale-source gocryptfs grim gparted gvfs-gphoto2 gvfs-afc hotspot imv
# - gtk3 gnome-tweaks # removed to test if this removes the gtk portal
# - insync
# - intel-media-driver
rpm-ostree install -C j4-dmenu-desktop jrnl kalendar kamera kf5-solid kf6-solid kio-gdrive kio-extras-kf5 kio-fuse kio-ftps kjournald kontact ksystemlog kwallet-pam kanshi libimobiledevice libimobiledevice-utils libusb light lm_sensors lshw luarocks lynx macchanger mediainfo mpv neochat fractal catimg NetworkManager-tui

# rpm-ostree install mako network-manager-applet foot foot-terminfo variety 
rpm-ostree install -C inxi nvtop drm_info
# rpm-ostree install youtube-dl
# - niri
# - nnn
# - nvidia-vaapi-driver
# - miracle-wm river
rpm-ostree install -C openssl-devel pasystray perf perl-File-MimeInfo plasma-wayland-protocols
# removed by EC 2025.01.11 to test on sway auna usb player : pulseaudio-utils
# - qutebrowser
# - qt5-qtwebengine-freeworld
rpm-ostree install -C qt6-qtwayland
# - qtile
# - sddm
# - sddm-wayland-sway
# - sddm-wayland-generic
rpm-ostree install -C scroll xwayland-satellite kvantum materia-kde-kvantum klassy
rpm-ostree install -C niri mangowc xdg-desktop-portal-gtk dms brightnessctl cava cliphist matugen
# removed cosmic-desktop
# stuff for wallpapers
rpm-ostree install -C kde-wallpapers plasma-workspace-wallpapers arc-kde-wallpapers materia-kde-wallpapers plasma-wallpapers-dynamic constantine-backgrounds-kde
# rpm-ostree install xdg-desktop-portal-hyprland hyprland-plugins hyprpaper hypridle hyprlock hyprsysteminfo hyprshot hyprnome hyprdim hyprpicker
# removed: hyprland hyprland-devel cmake meson cpio
rpm-ostree install -C strace
# - sway
rpm-ostree install -C systemd trash-cli gdu duc usbip fwupd udisks2 udiskie wev wpaperd virt-install virt-manager virt-top virt-viewer virtio-win edk2-ovmf swtpm swtpm-tools cockpit cockpit-machines cockpit-ostree cockpit-podman w3m samba ddclient
# - wayfire
rpm-ostree install -C tlp powertop acpi
# rpm-ostree install power-profiles-daemon
# - xorg-x11-drv-nvidia-cuda
# These are needed for pdftools inside emacs
# rpm install emacs
rpm-ostree install -C autoconf automake gcc libpng-devel make ninja-build poppler-devel poppler-glib-devel pkgconf

########################################################################################################
# NEW SORT BY PURPOSE
########################################################################################################

# sway and wayland
rpm-ostree install -C slurp wdisplays wl-clipboard wofi xdg-desktop-portal-wlr swaybg swayr swayidle swaylock sway-systemd waybar wf-recorder
rpm-ostree install -C rofi-wayland bemenu
rpm-ostree install -C ibus gnome-keyring
# for compiling wlroots myself for mangowc - conflicting
# rpm-ostree install egl-wayland libglvnd-egl libseat-devel wayland-protocols-devel wayland-devel mesa-libEGL-devel mesa-libGLES-devel mesa-dri-drivers xorg-x11-server-Xwayland libgbm-devel libxkbcommon-devel libudev-devel pixman-devel libinput-devel libevdev-devel systemd-devel cairo-devel libpcap-devel json-c-devel pam-devel pango-devel pcre-devel gdk-pixbuf2-devel hwdata-devel
# rpm-ostree install libdrm libdrm-devel libdisplay-info

# system tools
rpm-ostree install -C borgbackup vorta

# gtk libs
rpm-ostree install -C gtk4-devel libadwaita-devel libadwaita
# FC43 doesn't have webkit2gtk3 webkit2gtk4.0

# taskwarrior
# rpm-ostree install taskopen

# development tools
rpm-ostree install -C tmux zellij lazygit git zoxide
rpm-ostree install -C kitty kitty-terminfo starship
# rpm-ostree install tilix ghostty ghostty-fish-completion ghostty-terminfo
rpm-ostree install -C fish nushell direnv
# rpm-ostree install -C neovim kakoune tree-sitter-cli global
rpm-ostree install -C the_silver_searcher ripgrep
# rpm-ostree install cuda-toolkit nvidia-gds

# text pdf stuff
rpm-ostree install -C odt2txt pandoc zathura zathura-pdf-poppler zathura-djvu zathura-ps a2ps ghostscript okular

# fonts
rpm-ostree install -C iosevka-nerd-fonts fira-code-nerd-fonts roboto-mono-nerd-fonts droid-sans-mono-nerd-fonts deja-vu-sans-mono-nerd-fonts monofur-nerd-fonts jet-brains-mono-nerd-fonts rsms-inter-fonts

# network tools
rpm-ostree install -C nmap sshfs
# netscanner not in fedora43

# flatpak install flathub com.brave.Browser
# flatpak uninstall org.gnome.eog

# flatpak install org.kde.krita

# this would install a package from rpmfusion
# rpm-ostree install vlc

# mkdir -p /usr/local/bin /usr/local/lib

rpm-ostree install -C gimp3 dia flameshot

#### Example for enabling a System Unit File

systemctl enable podman.socket

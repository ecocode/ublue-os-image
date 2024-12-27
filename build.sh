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

curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | tee /etc/yum.repos.d/terra.repo
# dnf config-manager --add-repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
rpm-ostree install terra-release

# this installs a package from fedora repos
rpm-ostree install atool akregator alot aerc
      # - appimagelauncher
rpm-ostree install bat bemenu
      # - bettercap
rpm-ostree install blueman cargo cryfs digikam distrobox dconf-editor dolphin egl-wayland entr
      # epiphany is the package name of gnome web
      # - epiphany
rpm-ostree install eww eza fastfetch fbreader fd-find firewall-config fish foot foot-terminfo fzf gh glances bpytop glibc-locale-source gocryptfs grim gparted gvfs-gphoto2 gvfs-afc hotspot imv
      # - gtk3 gnome-tweaks cosmic-desktop # removed to test if this removes the gtk portal
      # - insync
      # - intel-media-driver
rpm-ostree install inxi j4-dmenu-desktop jrnl kalendar kamera kf5-solid kf6-solid kio-gdrive kio-extras-kf5 kio-fuse kio-ftps kjournald kontact ksystemlog kwallet-pam kanshi kitty kitty-terminfo libimobiledevice libimobiledevice-utils libusb light lm_sensors lshw luarocks lynx macchanger mako mediainfo miracle-wm mpv neochat neovim network-manager-applet NetworkManager-tui
      # - niri
      # - nnn
rpm-ostree install nushell
      # - nvidia-vaapi-driver
rpm-ostree install nvtop odt2txt pandoc
      # - openh264
rpm-ostree install openssl-devel pasystray perf perl-File-MimeInfo plasma-wayland-protocols pulseaudio-utils
      # - qutebrowser
      # - qt5-qtwebengine-freeworld
rpm-ostree install qt6-qtwayland
      # - qtile
rpm-ostree install ripgrep river rofi-wayland samba
      # - sddm
      # - sddm-wayland-sway
      # - sddm-wayland-generic
rpm-ostree install  slurp sshfs starship strace
      # - sway
rpm-ostree install swaybg swayr swayidle swaylock sway-systemd systemd taskopen tilix tlp tmux trash-cli usbip udisks2 udiskie variety virt-install virt-manager virt-top virt-viewer w3m waybar
      # - wayfire
rpm-ostree install webkit2gtk3 webkit2gtk4.0 gtk4-devel wdisplays wezterm wl-clipboard wofi xdg-desktop-portal-wlr power-profiles-daemon
      # - xorg-x11-drv-nvidia-cuda
rpm-ostree install zellij lazygit git zoxide

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
rpm-ostree install 1password 1password-cli

#### Example for enabling a System Unit File

systemctl enable podman.socket

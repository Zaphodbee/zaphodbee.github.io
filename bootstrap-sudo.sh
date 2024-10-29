sed -i "/etc/pacman.conf" \
    -e "s|^#Color|&\nColor\nILoveCandy|" \
    -e "s|^#VerbosePkgLists|&\nVerbosePkgLists|" \
    -e "s|^#ParallelDownloads.*|&\nParallelDownloads = 20|"

sed -i "/etc/makepkg.conf" \
    -e "s|^#BUILDDIR=.*|&\nBUILDDIR=/tmp/makepkg|" \
    -e "s|^PKGEXT.*|PKGEXT='.pkg.tar'|" \
    -e "s|^OPTIONS=.*|#&\nOPTIONS=(docs \!strip \!libtool \!staticlibs emptydirs zipman purge \!debug lto)|" \
    -e "s|-march=.* -mtune=generic|-march=native|" \
    -e "s|^#RUSTFLAGS=.*|&\nRUSTFLAGS=\"-C opt-level=2 -C target-cpu=native\"|" \
    -e "s|^#MAKEFLAGS=.*|&\nMAKEFLAGS=\"-j$(($(nproc --all)-1))\"|"

# The package cache can be cleaned periodically using the systemd timer paccache.timer.
# If the timer is enabled the cache will be cleaned weekly with paccache’s default options.
systemctl enable --now paccache.timer

# utilities
pacman -S git base-devel nano htop btop traceroute dnsutils alacritty ffmpeg

# gui
pacman -S xorg-server xorg-xinit i3-wm dmenu i3status xorg-xrandr nautilus lutris

# 4090 drivers
cd ~/repos
git clone https://github.com/Frogging-Family/nvidia-all.git
cd nvidia-all
makepkg -si

# gui utils
pacman -S firefox feh nvtop nvidia-utils flameshot mplayer vlc
yay -S google-chrome

# dev tools
pacman -S code

# set DNS servers in resolv and then lock file using this command
chattr +i /etc/resolv.conf

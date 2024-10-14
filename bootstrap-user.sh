# setup some repositories
mkdir ~/repos

# install yay
cd ~/repos
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -S google-chrome legendary




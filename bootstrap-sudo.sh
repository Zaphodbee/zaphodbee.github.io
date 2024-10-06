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

pacman -S git base-devel

# cleanup package cache periodically
systemctl enable --now paccache.timer

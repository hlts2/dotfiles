mkcd() {
    if [ -d $1 ]; then
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

if type pacman > /dev/null 2>&1; then
    update-arch() {
        sudo pacman-key --refresh-keys
        sudo pacman -S archlinux-keyring
        sudo pacman -Syyu
    }
fi

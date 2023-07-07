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

install-nix() {
    curl -L https://nixos.org/nix/install | sh
    nix-env -iA nixpkgs.nixFlakes
    mkdir $HOME/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
}

uninstall-nix() {
    rm -rf $HOME/{.nix-channels,.nix-defexpr,.nix-profile,.config/nixpkgs}
    sudo rm -rf /nix
}

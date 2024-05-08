set -eu

curl -L https://nixos.org/nix/install | sh
nix-env -iA nixpkgs.nixFlakes
mkdir $HOME/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

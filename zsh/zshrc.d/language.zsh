# Rust
if [ ! -d "$HOME/.cargo" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
source "$HOME/.cargo/env"

if [ ! -d "$HOME/.pyenv" ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi
eval "$(pyenv init -)"

# Volta
if [ ! -d $HOME/.volta ]; then
    curl https://get.volta.sh | bash
fi

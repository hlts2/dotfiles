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

langenv-init() {
    if type pyenv > /dev/null 2>&1; then
        pyenv install $LANG_PYTHON_VERSION
        pyenv global $LANG_PYTHON_VERSION

        # pip install --upgrade black
    fi

    if type volta > /dev/null 2>&1; then
        volta install node@$LANG_NODE_VERSION
    fi

    if [ -d /usr/local/go ]; then
        sudo rm -rf /usr/local/go
    fi

    case "$(uname -s)" in
        Darwin)
            kernel="darwin"
            ;;
        Linux)
            kernel="linux"
            ;;
        *)
            echo no snsupported kernel
            return 1
            ;;
    esac

    tarname="go.tar.gz"
    wget -O $tarname https://go.dev/dl/go$LANG_GO_VERSION.$kernel-amd64.tar.gz
    sudo tar -C /usr/local -xzf $tarname
    rm -rf $tarname
}

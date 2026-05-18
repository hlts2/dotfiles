if [[ -x $HOME/.local/bin/mise ]]; then
    _mise_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/mise-activate.zsh"
    if [[ ! -s $_mise_cache || $HOME/.local/bin/mise -nt $_mise_cache ]]; then
        mkdir -p "${_mise_cache:h}"
        "$HOME/.local/bin/mise" activate zsh > "$_mise_cache"
    fi
    source "$_mise_cache"
    unset _mise_cache
fi

if (( $+commands[fzf] )); then
    _fzf_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/fzf.zsh"
    if [[ ! -s $_fzf_cache || $commands[fzf] -nt $_fzf_cache ]]; then
        mkdir -p "${_fzf_cache:h}"
        fzf --zsh > "$_fzf_cache" 2>/dev/null
    fi
    source "$_fzf_cache"
    unset _fzf_cache
fi

if (( $+commands[zoxide] )); then
    _zoxide_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zoxide.zsh"
    if [[ ! -s $_zoxide_cache || $commands[zoxide] -nt $_zoxide_cache ]]; then
        mkdir -p "${_zoxide_cache:h}"
        zoxide init zsh > "$_zoxide_cache"
    fi
    source "$_zoxide_cache"
    unset _zoxide_cache
fi

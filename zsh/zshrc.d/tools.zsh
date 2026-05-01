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

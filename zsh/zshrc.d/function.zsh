mkcd() {
    if [[ -d $1 ]]; then
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

if (( $+commands[pacman] )); then
    update-arch() {
        sudo pacman-key --refresh-keys
        sudo pacman -S archlinux-keyring
        sudo pacman -Syyu
    }
fi

if (( $+commands[tmux] )); then
    function tses() {
        local session_name=$(tmux list-sessions -F "#{session_name}" | sort | fzf)
        [[ -z $session_name ]] && return
        if [[ -n $TMUX ]]; then
            tmux switch-client -t "$session_name"
        else
            tmux attach-session -t "$session_name"
        fi
    }
fi

if (( $+commands[ghq] )); then
    function ghqcd() {
        local repo=$(ghq list | fzf)
        [[ -z $repo ]] && return
        local dir="$(ghq root)/$repo"
        local session_name=$(echo "$repo" | tr './' '__')
        if tmux has-session -t "$session_name" 2>/dev/null; then
            if [[ -n $TMUX ]]; then
                tmux switch-client -t "$session_name"
            else
                tmux attach-session -t "$session_name"
            fi
        else
            if [[ -n $TMUX ]]; then
                tmux new-session -d -s "$session_name" -c "$dir" && tmux switch-client -t "$session_name"
            else
                tmux new-session -s "$session_name" -c "$dir"
            fi
        fi
    }
fi

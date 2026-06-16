function mkcd() {
    if [[ -d $1 ]]; then
        cd "$1"
    else
        mkdir -p "$1" && cd "$1"
    fi
}

if (( $+commands[pacman] )); then
    function update-arch() {
        sudo pacman-key --refresh-keys
        sudo pacman -S archlinux-keyring
        sudo pacman -Syyu
    }
fi

# Attach to a tmux session, switching in-place when already inside tmux.
function _tmux_goto() {
    if [[ -n $TMUX ]]; then
        tmux switch-client -t "$1"
    else
        tmux attach-session -t "$1"
    fi
}

if (( $+commands[tmux] )); then
    # Pick a tmux session with fzf and go to it.
    function tses() {
        local session_name=$(tmux list-sessions -F "#{session_name}" | sort | fzf)
        [[ -z $session_name ]] && return
        _tmux_goto "$session_name"
    }
fi

if (( $+commands[herdr] )); then
    # Pick a herdr session with fzf and go to it.
    function hses() {
        local session_name=$(herdr session list --json | jq -r '.sessions.[].name' | sort | fzf)
        [[ -z $session_name ]] && return
        herdr session attach "$session_name"
    }
fi

if (( $+commands[ghq] )); then
    # Pick a ghq repo with fzf and open it as an isolated workspace.
    # Inside herdr: one herdr workspace per repo. Otherwise: one tmux session per repo.
    function ghqcd() {
        local repo=$(ghq list | fzf)
        [[ -z $repo ]] && return
        local dir="$(ghq root)/$repo"

        if [[ -n $HERDR_ENV ]]; then
            # Targets the current session via $HERDR_SOCKET_PATH; no --session needed.
            local ws_id=$(herdr workspace list \
                | jq -r --arg l "$repo" '.result.workspaces[] | select(.label==$l) | .workspace_id' | head -1)
            if [[ -n $ws_id ]]; then
                herdr workspace focus "$ws_id"
            else
                herdr workspace create --cwd "$dir" --label "$repo" --focus
            fi
            return
        fi

        local tmux_session_name=$(echo "$repo" | tr './' '__')
        if tmux has-session -t "$tmux_session_name" 2>/dev/null; then
            _tmux_goto "$session_name"
        elif [[ -n $TMUX ]]; then
            tmux new-session -d -s "$tmux_session_name" -c "$dir" && _tmux_goto "$tmux_session_name"
        else
            tmux new-session -s "$tmux_session_name" -c "$dir"
        fi
    }
fi

# Run the hermes CLI inside the running 'hermes' container.
function hermesd() {
    if (( ! $+commands[docker] )); then
        echo "hermesd: docker not found" >&2
        return 1
    fi
    local cid=$(docker ps -f name=hermes --quiet)
    if [[ -z $cid ]]; then
        echo "hermesd: container 'hermes' is not running" >&2
        return 1
    fi
    docker exec -it hermes /opt/hermes/.venv/bin/hermes "$@"
}

# Entry point invoked by Ghostty's `command` directive.
# Replaces the current shell with tmux when available; no-op otherwise.
function ghostty-launch {
    (( $+commands[tmux] )) && exec tmux new-session
}

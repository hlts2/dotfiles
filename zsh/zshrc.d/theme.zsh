autoload -Uz colors && colors
autoload -Uz vcs_info && vcs_info

PROMPT="%{${fg[cyan]}%}%n@%m:%/#%{$reset_color%} %"

zstyle ':vcs_info:*' formats '(%s)[%b]'
zstyle ':vcs_info:*' actionformats '(%s)[%b|%a]'
precmd () { vcs_info }
setopt prompt_subst
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

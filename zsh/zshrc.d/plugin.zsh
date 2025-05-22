if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
	curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
		https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
	source ${ZIM_HOME}/zimfw.zsh init
fi

source ${ZIM_HOME}/init.zsh

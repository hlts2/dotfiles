#!bin/sh

if [ -z $ENV_LOADED ]; then

	#zsh環境変数
	export ZPLUG_HOME=$HOME/.zplug

	#nvim環境変数
	export XDG_CONFIG_HOME=$HOME/.config
	export NVIM_HOME=$XDG_CONFIG_HOME/nvim

	#Programming環境変数
	export PROGRAMMING_HOME=$HOME/Documents/Programming

	export ENV_LOADED="1"
fi


if [ -z $ZSH_LOADED ]; then

	#Zplug設定
	if [ -f $HOME/.zplug/init.zsh ]; then
    	source $ZPLUG_HOME/init.zsh

    	zplug "zsh-users/zsh-syntax-highlighting", defer:2
    	zplug "zsh-users/zsh-history-substring-search" 		#word C-p
		zplug "b4b4r07/enhancd", use:init.sh				#Movement

    	if ! zplug check --verbose; then
        	zplug install
    	fi

    	zplug load
	else
    	rm -rf $ZPLUG_HOME
    	git clone https://github.com/zplug/zplug $ZPLUG_HOME
    	source $ZPLUG_HOME
	fi

	#Color設定
    autoload -Uz colors
    colors
    PROMPT="%{$fg[cyan]%}%/#%{$reset_color%} %"

    #cd alias
    alias cdgo='cd $HOME/Documents/Programming/Go'
    alias cdswift='cd $HOME/Documents/Programming/Swift'
    alias cdc='cd $HOME/Documents/Programming/C'
    alias cdjava='cd $HOME/Documents/Programming/Java'
    alias cdandroid='cd $HOME/Documents/Programming/Android'
    alias cdios='cd $HOME/Documents/Programming/iOS'
    alias cdcent='cd $HOME/vagrant/CentOS7'
	alias vim='nvim'
	alias ls='ls -G -F'

	export ZSH_LOADED="1"
fi

load_anyenv_settings() {
    if [ -d $HOME/.anyenv ]; then
		export PATH="$HOME/.anyenv/bin:$PATH"
		eval "$(anyenv init -)"
		for D in 'ls $HOME/.anyenv/envs'
		do
			export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
		done
	fi
}

load_anyenv_settings

set number
set syntax=on
set tabstop=4
set softtabstop=0
set shiftwidth=4
set autoindent

" ----------------
" ---- Plugins ---
" ----------------
"
if has('vim_starting')
	set runtimepath+=~/.config/nvim/plugged/vim-plug
	if !isdirectory(expand('~/.config/nvim/plugged/vim-plug'))
		echo "install vim-plug..."
		call system('mkdir -p ~/.config/nvim/plugged/vim-plug')
		call system('git clone https://github.com/junegunn/vim-plug.git  ~/.config/nvim/plugged/vim-plug/autoload')
	endif
endif

call plug#begin(expand('$NVIM_HOME') . '/plugged')
	Plug 'junegunn/vim-plug', {'dir': expand('$NVIM_HOME') . '/plugged/vim-plug/autoload'}
	Plug 'sickill/vim-monokai'

	" --- Commons
	"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

	" --- Swift
	Plug 'keith/swift.vim'  		"syntax highlight
call plug#end()


" -------------------------
" ---- Plugin Settings ----
" -------------------------
"
" ---- Deoplete
let g:deoplete#enable_at_startup = 1

" ---- vim-monoka
syntax enable
colorscheme monokai

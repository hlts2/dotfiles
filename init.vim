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

	" --- Commons
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }	"Complete
	Plug 'joshdick/onedark.vim' 									"Theame
	Plug 'scrooloose/nerdtree'										"TreeView
	Plug 'Xuyuanp/nerdtree-git-plugin'								"Diff not working
	Plug 'airblade/vim-gitgutter' 									"Diff not working
	Plug 'vim-airline/vim-airline'									"Navi
	Plug 'bronson/vim-trailing-whitespace'							"Delete Space
	Plug 'Yggdroot/indentLine'										"Show Indent
	Plug 'thinca/vim-quickrun'										"Execute
	Plug 'Townk/vim-autoclose'										"Auto Close
	Plug 'Shougo/unite.vim'											"Search File
	Plug 'vim-scripts/MultipleSearch'								"Search world higmlight
	Plug 'joshdick/onedark.vim'

	" --- Swift
	Plug 'keith/swift.vim'											"Syntax highlight
	"Plug 'landaire/deoplete-swift'									"Swift Complete
call plug#end()


"-------------------------
" ---- Plugin Settings ----
" -------------------------
"
" ---- Deoplete
let g:deoplete#enable_at_startup = 1

"--- onedark.vim
let g:onedark_termcolors=256
syntax on
colorscheme onedark
let g:airline_theme='onedark'
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" ---- nerdtree
let NERDTreeShowHidden = 1
noremap <C-n> :NERDTreeToggle<CR>

" ---- nerdtree-git-plugin
let g:NERDTreeShowIgnoredStatus = 1

" ---- vim-trailing-whitespace
autocmd BufWritePre * :FixWhitespace

" ---- vim-quickrun
set splitbelow
set splitright
map <C-r> :write<CR>:QuickRun<CR><C-w><C-w>

" --- deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog  = expand('$HOME') . '/.anyenv/envs/pyenv/shims/python3'

" --- unite.vim
noremap <C-o> :Unite file buffer<CR>

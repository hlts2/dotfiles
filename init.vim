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
	Plug 'Xuyuanp/nerdtree-git-plugin'								"Diff
	Plug 'airblade/vim-gitgutter' 									"Diff
	Plug 'vim-airline/vim-airline'									"Navi
	Plug 'bronson/vim-trailing-whitespace'							"Delete Space
	Plug 'Yggdroot/indentLine'										"Show Indent
	Plug 'thinca/vim-quickrun'										"Execute
	Plug 'Townk/vim-autoclose'										"Auto Close
	Plug 'Shougo/unite.vim'											"Search File
	Plug 'vim-scripts/MultipleSearch'								"Search world higmlight
	Plug 'vim-syntastic/syntastic'                                  "Syntax check 1
	Plug 'tpope/vim-pathogen'                                       "Syntax check 2

	" --- Swift
	Plug 'keith/swift.vim'											"Syntax highlight
	Plug 'landaire/deoplete-swift'									"Swift Complete

	Plug 'kballard/vim-swift', {
		\ 'filetypes': 'swift',
		\ 'unite_sources': ['swift/device', 'swift/developer_dir']
		\}															"Syntax check 3

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

" ---- deoplete-swift
let g:quickrun_config = {}
let g:quickrun_config['swift'] = {
	\ 'command': 'xcrun',
	\ 'cmdopt': 'swift',
	\ 'exec': '%c %o %s',
	\}

let g:deoplete#sources#swift#daemon_autostart = 1

" ---- syntastic, vim-pathogen
" vim-pathogen
execute pathogen#infect()
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ---- vim-swift
let g:syntastic_swift_checkers = ['swiftlint']

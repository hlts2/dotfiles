" ----------------
" --- Default ----
" ----------------

" --- Encoding Settings
set encoding=utf8
set fileencoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8

" --- Display Settings
set number
set syntax=on
set cursorline
set cursorcolumn
set showmatch
set laststatus=2
set cmdheight=2

" --- Cursor Settings
set scrolloff=8
set sidescrolloff=16
set sidescroll=1

" --- Search & Replace Settings
set wrapscan
set nohlsearch
set autoread

" --- File Settings
set nobackup
set noswapfile
set hidden

" --- Beep Settings
set visualbell t_vb=

" --- Command Completion Settings
set wildmenu
set history=5000

" --- Indent Settings
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set softtabstop=0
set autoindent
set smartindent
set mouse=a

" --- Multiple Screen Settings
nnoremap st :tabnew<Enter>
nnoremap ss :split<Enter>
nnoremap sv :vsplit<Enter>

" tab movement
nnoremap sn gt
nnoremap sp gT

" split screen movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap sq :q!<Enter>

" --------------------------
" ---- Install vim-plug ----
" --------------------------
if has('vim_starting')
    set rtp+=~/.vim/plugged/vim-plug
    if !isdirectory(expand('~/.vim/plugged/vim-plug'))
        echo "install vim-plug..."
        call system('mkdir -p ~/.vim/plugged/vim-plug')
        call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
    endif
endif

" -------------------------
" ---- Plugins Install ----
" -------------------------
call plug#begin(expand('$VIM_HOME') . '/plugged')
    Plug 'junegunn/vim-plug', {'dir': expand('$VIM_HOME') . '/plugged/vim-plug/autoload'}

    Plug 'cocopon/iceberg.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'scrooloose/nerdtree'
    Plug 'tyru/caw.vim'
call plug#end()

" --------------------------
" ---- Iceberg settings ----
" --------------------------
colorscheme iceberg
syntax enable

" ---------------------------
" ---- Nerdtree settings ----
" ---------------------------
let NERDTreeShowHidden = 1
noremap <C-n> :NERDTreeToggle<CR>

" -----------------------------
" ---- IndentLine settings ----
" -----------------------------
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" ------------------------------
" ---- Caw.vim settings --------
" ------------------------------
nmap <Space>c <Plug>(caw:hatpos:toggle)
vmap <Space>c <Plug>(caw:hatpos:toggle)

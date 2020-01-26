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

" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" --- plugin loading with dein.vim
let s:dein_dir = '~/.vim/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

    if !isdirectory(expand(s:dein_repo_dir))
        execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir
endif

function! s:init_nerdtree_hook() abort
    let NERDTreeShowHidden = 1
    noremap <C-n> :NERDTreeToggle<CR>
endfunction

function! s:init_iceberg_hook() abort
    colorscheme iceberg
    syntax enable
endfunction

function! s:init_indentline_hook() abort
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
endfunction

function! s:init_cawvim_hook() abort
    nmap <Space>c <Plug>(caw:hatpos:toggle)
    vmap <Space>c <Plug>(caw:hatpos:toggle)
endfunction

if dein#load_state(s:dein_dir)
    call dein#begin(expand(s:dein_dir . '/'))
    call dein#add('Shougo/dein.vim')

    call dein#add('cocopon/iceberg.vim', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_iceberg_hook()',
        \})
    
    call dein#add('scrooloose/nerdtree', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_nerdtree_hook()',
        \})

    call dein#add('Yggdroot/indentLine', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_indentline_hook()',
        \})

    call dein#add('tyru/caw.vim', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_cawvim_hook()',
        \})

    call dein#end()
    call dein#save_state()
endif

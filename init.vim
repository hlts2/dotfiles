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
    set runtimepath+=~/.config/nvim/plugged/vim-plug
    if !isdirectory(expand('~/.config/nvim/plugged/vim-plug'))
        echo "install vim-plug..."
        call system('mkdir -p ~/.config/nvim/plugged/vim-plug')
        call system('git clone https://github.com/junegunn/vim-plug.git  ~/.config/nvim/plugged/vim-plug/autoload')
    endif
endif

" -------------------------
" ---- Plugins Install ----
" -------------------------
call plug#begin(expand('$NVIM_HOME') . '/plugged')
    Plug 'junegunn/vim-plug', {'dir': expand('$NVIM_HOME') . '/plugged/vim-plug/autoload'}

    " --- Commons
    Plug 'cocopon/iceberg.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':call coc#util#install()'}
    Plug 'Yggdroot/indentLine'
    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'w0rp/ale'
    Plug 'simeji/winresizer'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'tyru/caw.vim'
    Plug 'Townk/vim-autoclose'
    Plug 'thinca/vim-quickrun'
    Plug 'sheerun/vim-polyglot'
    Plug 'rhysd/accelerated-jk'
    Plug 'Shougo/unite.vim'

    " --- Go
    Plug 'fatih/vim-go', {'tag': 'v1.22'}
    Plug 'sebdah/vim-delve'
call plug#end()


" --------------------------
" ---- Iceberg settings ----
" --------------------------
colorscheme iceberg
syntax enable


" ----------------------------------
" ---- Editorconfig-vim settings ---
" ----------------------------------


" --------------------------
" ---- Coc.nvim settings ---
" --------------------------

" Tab Completion
function! s:completion_check_bs()
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~? '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>completion_check_bs() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

nmap <c-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <c-t> <c-o>
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" -----------------------------
" ---- IndentLine settings ----
" -----------------------------
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


" ----------------------------
" ---- Lightline settings ----
" ----------------------------
set laststatus=2

if !has('gui_running')
        set t_Co=256
endif

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }


" ---------------------------
" ---- Nerdtree settings ----
" ---------------------------
let NERDTreeShowHidden = 1
noremap <C-n> :NERDTreeToggle<CR>


" ------------------------------------
" ---- Nerdtree-git-plugin settings --
" ------------------------------------
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


" -------------------------------
" ---- Vim-gitgutter settings ---
" -------------------------------


" -------------------------------------------------
" ---- Vim-airline, Vim-airline-themes settings ---
" ------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'


" -----------------------
" ---- Ale settings -----
" -----------------------
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:airline#extensions#ale#enabled = 1

" Golang
" ================================================================
" let g:ale_linters = {
"\   'go': ['golangci-lint'],
"\}

let g:ale_go_golangci_lint_options = '--fast --tests --enable-all'
let g:ale_go_golangci_lint_package = 1


" -------------------------------
" ---- Winresizer settings ------
" -------------------------------
let g:winresizer_enable = 1
let g:winresizer_gui_enable = 1


" ---------------------------------------
" ---- Vim-trailing-whitespace settings -
" ---------------------------------------


" ------------------------------
" ---- Caw.vim settings --------
" ------------------------------
nmap <Space>c <Plug>(caw:hatpos:toggle)
vmap <Space>c <Plug>(caw:hatpos:toggle)


" -------------------------------
" ---- Vim-autoclose settings ---
" -------------------------------


" ------------------------------
" ---- Vim-quickrun settings ---
" ------------------------------
let g:quickrun_config = {}
let g:quickrun_config['swift'] = {
    \ 'command': 'xcrun',
    \ 'cmdopt': 'swift',
    \ 'exec': '%c %o %s',
    \}
let g:quickrun_config['python'] = {
    \ 'command': 'python3',
    \}

set splitbelow
set splitright
map <C-q> :write<CR>:QuickRun<CR><C-w><C-w>


" --------------------------------
" ---- Vim-polyglot settings -----
" --------------------------------


" --------------------------------
" ---- Accelerated-jk settings ---
" --------------------------------
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)


" ---------------------------
" ---- Unite.vim settings ---
" ---------------------------
noremap <Space>u :Unite file buffer<CR>


" ------------------------
" ---- Vim-go settings ---
" ------------------------
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_fmt_experimental = 1
let g:go_fmt_command = "goimports"
let g:go_test_timeout= '15s'
let g:go_autodetect_gopath = 1
" for LSP
let g:go_fmt_autosave = 1
" let g:go_fmt_autosave = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_info_mode = ''


" ---------------------------
" ---- Vim-delve settings ---
" --------------------------
nnoremap <leader>b :<C-u>DlvToggleBreakpoint<CR>
nnoremap <leader>d :<C-u>DlvDebug<CR>

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


function! s:init_iceberg_vim_hook() abort
    colorscheme iceberg
    syntax enable
endfunction

function! s:init_indentline_hook() abort
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
endfunction

function! s:init_lightline_vim_hook() abort
    set laststatus=2
    if !has('gui_running')
        set t_Co=256
    endif let g:lightline = {
         \ 'colorscheme': 'wombat',
         \ 'active': {
         \   'left': [ [ 'mode', 'paste' ],
         \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
         \ },
         \ 'component_function': {
         \   'gitbranch': 'fugitive#head'
         \ },
         \ }
endfunction

function! s:init_nerdtree_hook() abort
    let NERDTreeShowHidden = 1
    noremap <C-n> :NERDTreeToggle<CR>
endfunction

function! s:init_caw_vim_hook() abort
    nmap <Space>c <Plug>(caw:hatpos:toggle)
    vmap <Space>c <Plug>(caw:hatpos:toggle)
endfunction

function! s:init_accelerated_jk_hook() abort
    "nmap j <Plug>(accelerated_jk_gj)
	"nmap k <Plug>(accelerated_jk_gk)
endfunction

function! s:init_coc_nvim_hook() abort
    
    " Tab補完
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
endfunction

function! s:init_vim_go_hook() abort
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
endfunction

function! s:init_vim_delve_hook() abort
    nnoremap <leader>b :<C-u>DlvToggleBreakpoint<CR>
    nnoremap <leader>d :<C-u>DlvDebug<CR>
endfunction

function! s:init_ale_hook() abort
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
    let g:ale_linters = {
    \   'go': ['golangci-lint'],
    \}
    
    let g:ale_go_golangci_lint_options = '--fast --tests --enable-all'
    let g:ale_go_golangci_lint_package = 1
endfunction

if dein#load_state(s:dein_dir)
    call dein#begin(expand(s:dein_dir . '/'))
    call dein#add('Shougo/dein.vim')

    call dein#add('cocopon/iceberg.vim', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_iceberg_vim_hook()',
        \})

    call dein#add('Yggdroot/indentLine', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_indentline_hook()',
        \})

    call dein#add('itchyny/lightline.vim', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_lightline_vim_hook()',
        \})
    
    call dein#add('scrooloose/nerdtree', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_nerdtree_hook()',
        \})
    
    call dein#add('tyru/caw.vim', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_caw_vim_hook()',
        \})
    
    call dein#add('rhysd/accelerated-jk', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_accelerated_jk_hook()',
        \})
    
    call dein#add('neoclide/coc.nvim', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_coc_nvim_hook()',
        \})
    

    call dein#add('fatih/vim-go', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_vim_go_hook()',
        \})


    call dein#add('sebdah/vim-delve', {
        \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_vim_delve_hook()',
        \})

    call dein#add('sheerun/vim-polyglot')
    call dein#add('Townk/vim-autoclose')
    call dein#add('simeji/winresizer')
    call dein#add('chrisbra/vim-sh-indent')
    call dein#add('cespare/vim-toml')
    
    call dein#end()
    call dein#save_state()
endif

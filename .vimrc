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
set list

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
" ----------------
" ---- Plugins ---
" ----------------
"
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
    Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug'}

    " --- Commons
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   "Complete
    "Plug 'joshdick/onedark.vim'                                    "Theame
    Plug 'whatyouhide/vim-gotham'                                   "Theame
    Plug 'scrooloose/nerdtree'                                      "TreeView
    Plug 'Xuyuanp/nerdtree-git-plugin'                              "Diff
    Plug 'airblade/vim-gitgutter'                                   "Diff
    Plug 'vim-airline/vim-airline'                                  "Navi
    Plug 'simeji/winresizer'                                        "Window Resize
    Plug 'bronson/vim-trailing-whitespace'                          "Delete Space
    Plug 'Yggdroot/indentLine'                                      "Show Indent
    Plug 'thinca/vim-quickrun'                                      "Execute
    Plug 'Townk/vim-autoclose'                                      "Auto Close
    Plug 'Shougo/unite.vim'                                         "Search File
    Plug 'vim-scripts/MultipleSearch'                               "Search World Higmlight
    Plug 'vim-syntastic/syntastic'                                  "Syntax Check 1
    Plug 'tpope/vim-pathogen'                                       "To Use vim-syntastic/syntastic
    Plug 'editorconfig/editorconfig-vim'                            "Editconfig
    Plug 'ctrlpvim/ctrlp.vim'                                       "Selector
    Plug 'tacahiroy/ctrlp-funky'                                    "Selector(Method Search)
    Plug 'suy/vim-ctrlp-commandline'                                "Selector(Command Search)
    Plug 'tpope/vim-fugitive'                                       "Git
    " --- Swift
    Plug 'keith/swift.vim'                                          "Syntax Highlight
    "Plug 'landaire/deoplete-swift'                                 "Swift Complete
    Plug 'mitsuse/autocomplete-swift'                               "Swift Complate
    Plug 'kballard/vim-swift'                                       "Syntax Check

    " --- Go
    Plug 'fatih/vim-go'                                             "Go Complete    <c-x><x-o>
    Plug 'zchee/deoplete-go', { 'do': 'make'}                       "Go Complete realtime

    " ---- Java
    Plug 'artur-shaik/vim-javacomplete2'                            "Java Complete

    " --- Mark Down
    Plug 'plasticboy/vim-markdown'
    Plug 'kannokanno/previm'
    Plug 'tyru/open-browser.vim'
call plug#end()


" CtrlPFunkyの有効化
let g:ctrlp_funky_matchtype = 'path'

"-------------------------
" ---- Plugin Settings ----
" -------------------------
"
" ---- Deoplete.nvim
let g:python_host_skip_check = 1
let g:python2_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python3_host_prog  = expand('$HOME') . '/.anyenv/envs/pyenv/shims/python3'
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000

"--- Onedark
"colorscheme onedark
"let g:onedark_termcolors=256
"let g:airline_theme='onedark'
"let g:lightline = { 'colorscheme': 'onedark'}
"--- Gotham
colorscheme gotham256
let g:lightline = { 'colorscheme': 'gotham' }
let g:lightline = { 'colorscheme': 'gotham256' }


"---- Nerdtree
let NERDTreeShowHidden = 1
noremap <C-n> :NERDTreeToggle<CR>

" ---- Nerdtree-Git-Plugin
let g:NERDTreeShowIgnoredStatus = 1

" ---- Vim-Trailing-Whitespace
augroup VimTrailingWhilespace
    autocmd!
    autocmd BufWritePre * :FixWhitespace
augroup END

" ---- Vim-Quickrun
set splitbelow
set splitright
map <C-q> :write<CR>:QuickRun<CR><C-w><C-w>

" --- Unite
noremap <C-o> :Unite file buffer<CR>

" Vim-Pathogen
execute pathogen#infect()

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" quickrun
" normalモードで \r で実行
let g:quickrun_config = {}
let g:quickrun_config['swift'] = {
\ 'command': 'xcrun',
\ 'cmdopt': 'swift',
\ 'exec': '%c %o %s',
\}

" CtrlP
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100'
let g:ctrlp_show_hidden = 1
let g:ctrlp_types = ['fil']
let g:ctrlp_extensions = ['funky', 'commandline']

command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())
let g:ctrlp_funky_matchtype = 'path'

augroup SwiftSetting
    autocmd!
    "autocmd FileType swift let g:deoplete#sources#swift#daemon_autostart = 1 " swiftの自動補完on

    " ---- Deoplete-Swift
    autocmd FileType swift let g:deoplete#sources#swift#source_kitten_binary = system("which sourcekitten")
    "autocmd FileType swift imap <buffer> <C-j> <Plug>(deoplete_swift_jump_to_placeholder)
    "autocmd FileType swift let g:deoplete#sources#swift#daemon_autostart = 1

    " --- autocomplete-swift
    autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
    autocmd BufNewFile,BufRead *.swift set filetype=swift

    "---- Vim-Quickrun
    autocmd FileType swift let g:quickrun_config = {}
    autocmd FileType swift let g:quickrun_config['swift'] = { 'command': 'xcrun', 'cmdopt': 'swift', 'exec': '%c %o %s'}

    " ---- Vim-Swift
    autocmd FileType swift let g:syntastic_swift_checkers = ['swiftlint']
    autocmd FileType swift let g:swift_no_conceal = 1
    autocmd FileType swift let g:swift_developer_dir='/Applications/Xcode.app'
    autocmd FileType swift let g:swift_platform = 'macosx'
    autocmd FileType swift let g:swift_device = 'iPhone 7'
    autocmd FileType swift let g:swift_platform_detect_limit = 2
augroup END

augroup JavaSetting
    autocmd!
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
    autocmd FileType java let g:java_highlight_all=1
    autocmd FileType java let g:java_highlight_debug=1
    autocmd FileType java let g:java_allow_cpp_keywords=1
    autocmd FileType java let g:java_space_errors=1
    autocmd FileType java let g:java_highlight_functions=1
    autocmd FileType java let b:javagetset_enable_K_and_R=1
    autocmd FileType java let b:javagetset_add_this=1
    autocmd FileType java let g:JavaComplete_MavenRepositoryDisable = 0
    autocmd FileType java let g:JavaComplete_UseFQN = 0
    autocmd FileType java nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java nmap <F5> <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java imap <F5> <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java let g:JavaComplete_BaseDir = expand($HOME) . '/Documents/Programming/Java/.cache'
augroup END

augroup GOSettings
    autocmd!
    autocmd FileType go set completeopt+=noselect
    autocmd FileType go let g:deoplete#sources#go#gocode_binary=expand("$GOPATH") . '/bin/gocode'
    autocmd FileType go let g:deoplete#sources#go#package_dot=1
    autocmd FileType go let g:deoplete#sources#go#sort_class=['package', 'func', 'type', 'var', 'const']

    " --- Vim-Go
    autocmd FileType go let g:go_fmt_command = "goimports"
    autocmd FileType go let g:go_highlight_methods = 1
    autocmd FileType go let g:go_highlight_structs = 1
    autocmd FileType go let g:go_highlight_functions = 1
    autocmd FileType go let g:go_highlight_build_constraints = 1

    "---Golint
    autocmd FileType go set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
    autocmd FileType go let g:syntastic_go_checkers = ['go', 'golint', 'govet']

    " ---- Go Keymap
    autocmd FileType go nmap <Space>gb <Plug>(go-build)
    autocmd FileType go nmap <Space>gr <Plug>(go-run)
    autocmd FileType go nmap <Space>gt <Plug>(go-test)
augroup END

augroup MarkDownSettings
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END
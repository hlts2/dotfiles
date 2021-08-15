" --- Encoding Settings
set encoding=utf8
set fileencoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8

" --- Display Settings
set number
set syntax=on
set laststatus=2
set cmdheight=1

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

    Plug 'cocopon/iceberg.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'akinsho/nvim-toggleterm.lua'
    Plug 'airblade/vim-gitgutter'
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch' " for lightline
    Plug 'simeji/winresizer'
    Plug 'tyru/caw.vim'
    Plug 'Townk/vim-autoclose'
    " Go
    Plug 'mattn/vim-goimports'
    Plug 'kyoh86/vim-go-coverage'
    " Rust
    Plug 'rust-lang/rust.vim'
call plug#end()

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" --------------------------
" ---- iceberg.vim ---------
" --------------------------
colorscheme iceberg
syntax enable


" --------------------------
" ---- coc.nvim ------------
" --------------------------
set shortmess+=c

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[c` and `]c` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <c-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <c-t> <c-o>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions = [
    \ 'coc-go',
    \ 'coc-json',
    \ 'coc-rust-analyzer',
    \ 'coc-fzf-preview',
    \ 'coc-prettier',
    \ ]


" -----------------------------------
" ---- fzf-preview.nvim -------------
" -----------------------------------
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap [fzf-p]f  :<C-u>CocCommand fzf-preview.ProjectFiles<CR>


" ---------------------------
" ---- nerdtree -------------
" ---------------------------
let NERDTreeShowHidden = 1
noremap <C-n> :NERDTreeToggle<CR>


" ------------------------------------
" ---- nerdtree-git-plugin -----------
" ------------------------------------
let g:NERDTreeGitStatusIndicatorMapCustom = {
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
" ---- nvim-toggleterm.lua ------
" -------------------------------
nnoremap <silent><c-t> :<C-u>ToggleTerm<CR>


" ----------------------------
" ---- lightline.vim ---------
" ----------------------------
set laststatus=2

if !has('gui_running')
        set t_Co=256
endif

let g:lightline = {
   \ 'colorscheme': 'wombat',
   \ 'active': {
   \   'left': [ [ 'mode', 'paste' ],
   \             [ 'gitbranch', 'readonly', 'filename', 'coc' ,'modified' ] ]
   \ },
   \ 'component_function': {
   \   'gitbranch': 'gitbranch#name',
   \    'coc': 'coc#status',
   \ },
   \ }


" -------------------------------
" ---- indent-blankline.nvim ----
" -------------------------------
" let g:indent_blankline_space_char = '.'


" -------------------------------
" ---- winresizer --------------
" -------------------------------
let g:winresizer_enable = 1
let g:winresizer_gui_enable = 1


" ------------------------------
" ---- caw.vim -----------------
" ------------------------------
nmap <Space>c <Plug>(caw:hatpos:toggle)
vmap <Space>c <Plug>(caw:hatpos:toggle)

" ------------------------------
" ---- rust.vim ----------------
" ------------------------------
let g:rustfmt_autosave = 1

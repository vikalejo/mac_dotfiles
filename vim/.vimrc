" General
set nocompatible
filetype off

" Plugins (vim-plug)
call plug#begin('~/.vim/plugged')

" Ruby / Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-endwise'

" JavaScript / TypeScript / React (Next.js)
Plug 'pangloss/vim-javascript'          " JS syntax & indentation
Plug 'HerringtonDarkholme/yats.vim'     " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'         " JSX/TSX highlighting
Plug 'mattn/emmet-vim'                   " Emmet: expand JSX/HTML fast

" Completion / LSP (coc.nvim) — powers TS/JS IntelliSense, Tailwind, etc.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'       " Git integration
Plug 'tpope/vim-repeat'         " Repeat plugin mappings with .

" Linting
Plug 'dense-analysis/ale'

" UI
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'

" AI
Plug 'madox2/vim-ai'
Plug 'github/copilot.vim'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

filetype plugin indent on

" ---- Appearance ----
syntax on
set number
set relativenumber
set background=dark
set showcmd
set cursorline
set wildmenu
set title
set showmatch
set incsearch
set hlsearch
set laststatus=2               " Always show status line
set signcolumn=yes             " Always show sign column (prevents layout shift)
set termguicolors              " True color support

" ---- Indentation ----
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent

" ---- Behavior ----
set hidden                     " Switch buffers without saving
set clipboard=unnamedplus      " System clipboard
set scrolloff=8                " Keep 8 lines above/below cursor
set updatetime=300             " Faster updates (default 4000ms)
set timeoutlen=500             " Faster key sequence completion
set splitbelow                 " Open horizontal splits below
set splitright                 " Open vertical splits to the right
set equalalways                " Keep splits equal-sized when opening/closing
set eadirection=both           " Equalize width AND height, not just one axis
set winminheight=3             " Never let a split collapse below 3 lines
set winminwidth=10             " Never let a split collapse below 10 columns
" Auto re-balance all splits when the terminal resizes or a new split opens
augroup AutoBalanceSplits
  autocmd!
  autocmd VimResized * wincmd =
  autocmd WinNew * wincmd =
augroup END
" Manual re-balance shortcut (in addition to the default <C-w>=)
nnoremap <Leader>= <C-w>=
set ignorecase                 " Case insensitive search...
set smartcase                  " ...unless uppercase is used
set undofile                   " Persistent undo
set undodir=~/.vim/undodir
set noswapfile                 " No swap files
set nobackup                   " No backup files
set nowrap                     " No line wrapping

" ---- Ruby specific ----
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2

" ---- ALE Config ----
" coc.nvim owns JS/TS/TSX diagnostics, completion and formatting (via
" coc-tsserver / coc-eslint / coc-prettier). ALE is scoped to Ruby to avoid
" duplicate eslint diagnostics, and defers all LSP to coc.
let g:ale_disable_lsp = 'auto'
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}
let g:ale_fix_on_save = 1

" ---- NERDTree ----
nmap <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

" ---- FZF ----
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <Leader>b :Buffers<CR>

" ---- Key Mappings ----
" Use - as : for commands (your existing mapping)
nnoremap - :

" Yank to system clipboard
noremap yy "+yy

" Clear search highlight with Escape
nnoremap <silent> <Esc> :nohlsearch<CR>

" Quick save
nnoremap <Leader>w :w<CR>

" Quick quit
nnoremap <Leader>q :q<CR>

" Move between splits with Ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Format shortcut — coc (Prettier/ESLint) for JS/TS, ALEFix for Ruby/others
function! s:FormatBuffer() abort
  if index(['javascript', 'javascriptreact', 'typescript', 'typescriptreact',
        \   'json', 'jsonc', 'css', 'scss', 'html'], &filetype) >= 0
    call CocActionAsync('format')
  else
    ALEFix
  endif
endfunction
nnoremap <silent> <Leader>f :call <SID>FormatBuffer()<CR>

" ---- vim-ai ----
let g:vim_ai_roles_config_file = '~/.vim_ai_config/roles.ini'

" ---- Copilot ----
" Free Tab for the coc completion menu; accept Copilot suggestions with <C-l>.
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" ---- Emmet (JSX/HTML) ----
" Expand with <C-y>, (default). Scope to JS/TS/React + markup filetypes.
let g:user_emmet_settings = {
\   'javascript': {'extends': 'jsx'},
\   'typescript': {'extends': 'jsx'},
\ }
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,javascriptreact,typescript,typescriptreact EmmetInstall

" ---- coc.nvim (completion / LSP) ----
" Extensions installed via install/vim-plug.sh:
"   coc-tsserver coc-eslint coc-prettier coc-tailwindcss coc-json coc-css coc-html

" Tab / Shift-Tab to navigate the completion menu; <CR> confirms.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Trigger completion manually
inoremap <silent><expr> <C-space> coc#refresh()

" Navigation (LSP)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Diagnostics: jump between errors/warnings
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Hover docs with K
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>
function! s:ShowDocumentation() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol rename and code actions (imports, quick fixes)
nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>ca <Plug>(coc-codeaction-cursor)
xmap <Leader>ca <Plug>(coc-codeaction-selected)

" Highlight the symbol under the cursor and its references
autocmd CursorHold * silent call CocActionAsync('highlight')

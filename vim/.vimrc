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
let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
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

" ALE fix shortcut
nmap <silent> <Leader>f :ALEFix<CR>

" ---- vim-ai ----
let g:vim_ai_roles_config_file = '~/.vim_ai_config/roles.ini'

set shell=/bin/dash

call plug#begin(expand('~/.vim/plugged'))

Plug 'sheerun/vim-polyglot'
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'govim/govim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'matze/vim-move'
Plug 'inkarkat/vim-LineJuggler'
Plug 'inkarkat/vim-ingo-library'
Plug 'tomasr/molokai'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'machakann/vim-highlightedundo'
Plug 'machakann/vim-highlightedyank'
call plug#end()


imap <silent> jk <Esc>
noremap <silent> <S-J> :bp<CR>
noremap <silent> <S-K> :bn<CR>
noremap <silent> ,w :bd<CR>

vmap <S-l>   <Plug>(LineJugglerDupRangeUp)
vmap <S-h> <Plug>(LineJugglerDupRangeDown)

vmap <silent> J :t'><cr>

filetype plugin indent on
 " Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

 " Fix backspace indent
set backspace=indent,eol,start
set splitbelow
set splitright

set foldmethod=marker

" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Map leader to ,
 let mapleader=','

" Enable hidden buffers
set hidden

" Searching
set autoread
set hlsearch
set incsearch
set ignorecase
set smartcase

 " Directories for swp files
set nobackup
set nowritebackup
set noswapfile

set fileformats=unix,dos,mac

syntax on
set ruler
set number

 " Status bar
set laststatus=2
set noshowmode

 " Use modeline overrides
set modeline
set modelines=10

set title
" set titleold="Terminal"
set titlestring=%F

set background=dark
" set termguicolors

" mouse
set mouse=a
set number relativenumber
" set list

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
" set signcolumn=yes

" Disable visualbell
set noerrorbells visualbell t_vb=
set belloff+=ctrlg

" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

colorscheme molokai
" set list
let g:rehash256 = 1
set number relativenumber
nmap <silent> ,o :Files<CR>
nmap <silent> ,f :Rg<CR>
nmap <silent> ,a :Buf<CR>


noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Q1 q!
cnoreabbrev q1 q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

inoremap <silent><expr> <C-j>
            \ pumvisible() ? "\<C-n>" : "\<CR>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-]>"

nmap u     <Plug>(highlightedundo-undo)
nmap <C-r> <Plug>(highlightedundo-redo)
nmap U     <Plug>(highlightedundo-Undo)
nmap g-    <Plug>(highlightedundo-gminus)
nmap g+    <Plug>(highlightedundo-gplus)

set shell=/bin/dash

call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'tpope/vim-commentary'
Plug 'bronson/vim-trailing-whitespace'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'lilydjwg/colorizer'
" Plug 'mg979/vim-visual-multi'
" Plug 'https://github.com/lifepillar/vim-colortemplate' "Color generator (see later)
" Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'

" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'

" html
Plug 'hail2u/vim-css3-syntax'

" rust
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

"" Fix backspace indent
set backspace=indent,eol,start
set splitbelow

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set inccommand=nosplit

"" Directories for swp files
set nobackup
set nowritebackup
set noswapfile

set fileformats=unix,dos,mac

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1

colorscheme horizon "PaperColor

set mousemodel=popup
set t_Co=256

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
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

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake

let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif

augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Personal
let g:colorizer_startup = 0
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
imap <silent> jk <Esc>:FixWhitespace<CR>


" Disable <C-J> in c files
let g:C_Ctrl_j='off'
" Compile
map <leader>a :w<CR>:!compiler <c-r>%<CR>
set pyxversion=3
" mouse
set mouse=a
set number relativenumber

set list
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←

"" Split
noremap <silent>,h :<C-u>split<CR>
noremap <silent>,j :<C-u>vsplit<CR>


"" Tabs
nnoremap <silent> <S-t> :tabnew<CR>


"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"*****************************************************************************
" coc.nvim
"*****************************************************************************

inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <C-l> pumvisible() ? "\<C-y>" : "\<CR>"

let g:coc_snippet_next = "<C-e>"
let g:coc_snippet_prev = "<C-q>"

nnoremap <silent> <leader>o :CocList buffers<CR>
nnoremap <silent> <leader>f :CocList files<CR>
nnoremap <silent> <leader>gc :CocList bcommits<CR>
nnoremap <silent> <leader>y :CocList yank<CR>
nnoremap <silent> <leader>w :CocList files<cr>
nmap <silent> <C-[> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-]> <Plug>(coc-diagnostic-next)

nnoremap <silent> S :call <SID>show_documentation()<CR>

nmap <silent>gr <Plug>(coc-references)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>ge <Plug>(coc-definition)

set belloff+=ctrlg
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
" coc-snippets
imap <C-s> <Plug>(coc-snippets-expand)

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" coc-lists

let g:coc_git_status=1
nnoremap <silent> <space>s  :<C-u>CocList --normal gstatus<CR>
nmap gs <Plug>(coc-git-chunkinfo)
nmap gd <Plug>(coc-git-commit)
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction


" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>


"" Buffer nav
noremap <silent> ,q :bp<CR>
noremap <silent> ,e :bn<CR>
noremap <silent> ,c :bd<CR>
noremap <silent> <C-w> :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
" nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab

" go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" html
autocmd Filetype html setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" Syntax highlight
let g:polyglot_disabled = ['python']
let python_highlight_all = 1


" rust
" Vim racer
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"*****************************************************************************
"" Statusline Modifications
"*****************************************************************************

" Left side
set statusline=
set statusline+=%1*\ %{StatuslineMode()}\ %3*\ 
set statusline+=%2*%{get(g:,'coc_git_status')}%{get(b:,'coc_git_status')}%4*
set statusline+=%6*\ %f%m%r%h%w
set statusline+=%=
" Right side
set statusline+=%4*%2*%{&ff}\/%Y\ 
set statusline+=%3*%5*%3p%%,\ %3l:%-3c

hi User1 cterm=bold  ctermbg=25  ctermfg=189 guibg=#005faf guifg=#d7d7ff
hi User2 ctermbg=235 ctermfg=189 guibg=#f5f5f5 guifg=#d7d7ff
hi User3 ctermbg=235 ctermfg=25 guibg=#005faf guifg=#005faf
hi User4 ctermbg=0 ctermfg=235 guibg=#005faf guifg=#005faf
hi User5 ctermbg=25  ctermfg=189 guibg=#005faf guifg=#d7d7ff
hi User6 cterm=italic ctermbg=0  ctermfg=133 guibg=#005faf guifg=#d7d7ff


function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

set shell=/bin/dash

call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'tpope/vim-commentary'
Plug 'bronson/vim-trailing-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'vifm/vifm.vim'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/space-vim-theme'
Plug 'lifepillar/vim-colortemplate'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'
Plug 'ap/vim-buftabline'
Plug 'gregsexton/MatchTag'
Plug 'fremff/vim-css-syntax'
" Plug 'mg979/vim-visual-multi'

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

" colorscheme horizon "PaperColor

set mousemodel=popup
set t_Co=256
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

let g:vifm_embed_split = 1
let g:vifm_term = 'st -e'
let g:vifm_replace_netrw = 1


if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
imap <silent> jk <Esc>:FixWhitespace<CR>
imap <silent> kj <Esc>:FixWhitespace<CR>

" let g:space_vim_dark_background = 233
" color space-vim-dark
" hi Comment guifg=#5C6370 ctermfg=59
set termguicolors

set background=dark
colorscheme space_vim_theme
let g:space_vim_italicize_strings = 1
let g:space_vim_italic = 1



" Disable <C-J> in c files
let g:C_Ctrl_j='off'
" Compile
map <leader>a :w<CR>:!compiler <c-r>%<CR>
set pyxversion=3
" mouse
set mouse=a
set number relativenumber

augroup terminal-mode
    autocmd!
    au TermOpen * setlocal nonumber
    au TermOpen * setlocal norelativenumber
    au TermOpen * setlocal noshowmode
    au TermOpen * setlocal noruler
    au TermOpen * setlocal laststatus=0
    au TermOpen * setlocal noshowcmd

    au TermClose * setlocal number
    au TermClose * setlocal relativenumber
    au TermClose * setlocal noshowmode
    au TermClose * setlocal ruler
    au TermClose * setlocal laststatus=2
    au TermClose * setlocal showcmd
augroup end

set list
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←

"" Split
noremap <silent>,h :<C-u>split<CR>
noremap <silent>,j :<C-u>vsplit<CR>


"*****************************************************************************
" buftabline
"*****************************************************************************
nnoremap <silent> <S-t> :tabnew<CR>
let g:buftabline_numbers = 2
let g:buftabline_show = 1

nmap ,1 <Plug>BufTabLine.Go(1)
nmap ,2 <Plug>BufTabLine.Go(2)
nmap ,3 <Plug>BufTabLine.Go(3)
nmap ,4 <Plug>BufTabLine.Go(4)
nmap ,5 <Plug>BufTabLine.Go(5)
nmap ,6 <Plug>BufTabLine.Go(6)
nmap ,7 <Plug>BufTabLine.Go(7)
nmap ,8 <Plug>BufTabLine.Go(8)
nmap ,9 <Plug>BufTabLine.Go(9)
nmap ,0 <Plug>BufTabLine.Go(10)


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
nnoremap <silent> <space>r  :<C-u>CocList -A --normal yank<cr>
vmap <silent>f <Plug>(coc-format-selected)
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
nmap gN <Plug>(coc-git-prevchunk)
nmap gn <Plug>(coc-git-nextchunk)
nnoremap <silent> ,f :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
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
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab

" Syntax highlight
let g:polyglot_disabled = ['python']


" rust
autocmd BufNewFile,BufRead *.rs setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" Vim racer
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)



" Vista
let g:vista_sidebar_width = 40
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
autocmd BufRead,BufNewFile *.gohtml set filetype=html

let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

let g:vista_echo_cursor_strategy = 'floating_win'

"*****************************************************************************
"" Statusline Modifications
"*****************************************************************************

" Left side
set statusline=
set statusline+=%1*\ %{StatuslineMode()}\ 
set statusline+=%2*\ %{get(g:,'coc_git_status')}%{get(b:,'coc_git_status')}
set statusline+=%6*\ %f%m%r%h%w
set statusline+=%=
" Right side
set statusline+=%{NearestMethodOrFunction()}\ 
set statusline+=%2*%{&ff}\/%Y\ 
set statusline+=%5*%3p%%,\ %3l:%-3c
set statusline+=%7*%{Check_mixed_indent_file()}

hi User1 cterm=bold  ctermbg=25  ctermfg=189 gui=bold guibg=#6981c5 guifg=#262626
hi User2 ctermbg=235 ctermfg=189 guibg=#262626  guifg=#d7d7ff
hi User3 ctermbg=235 ctermfg=25 guibg=#262626 guifg=#6981c5
hi User4 ctermbg=0 ctermfg=235 guibg=#000000 guifg=#262626
hi User5 ctermbg=25  ctermfg=189 guibg=#6981c5 guifg=#262626
hi User6 cterm=italic ctermbg=0  ctermfg=133 guibg=#161616 guifg=#a15ea7
hi User7 cterm=bold ctermbg=209  ctermfg=0 guibg=#ca754b guifg=#000000

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

function! Check_mixed_indent_file()
  let head_spc = '\v(^ +)'
  let indent_tabs = search('\v(^\t+)', 'nw')
  let indent_spc  = search(head_spc, 'nw')
  if indent_tabs > 0 && indent_spc > 0
    return printf("Mix tab:%d spc:%d", indent_tabs, indent_spc)
  else
    return ''
  endif
endfunction

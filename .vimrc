set shell=/bin/dash

call plug#begin(expand('~/.vim/plugged'))

Plug 'sheerun/vim-polyglot'
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'govim/govim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'inkarkat/vim-LineJuggler'
Plug 'inkarkat/vim-ingo-library'
Plug 'matze/vim-move'
Plug 'tomasr/molokai'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'liuchengxu/vim-which-key'
Plug 'rhysd/clever-f.vim'
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-highlightedundo'
Plug 'machakann/vim-highlightedyank'
Plug 'cohama/lexima.vim'
Plug 'ap/vim-buftabline'

call plug#end()


imap <silent> jk <Esc>
noremap <silent> <S-J> :bp<CR>
noremap <silent> <S-K> :bn<CR>
noremap <silent> ,w :bd<CR>
let g:move_key_modifier = 'C'

vmap <S-l> <Plug>(LineJugglerDupRangeUp)
vmap <S-h> <Plug>(LineJugglerDupRangeDown)

" highlight the line in insert mode
autocmd InsertEnter,InsertLeave * set cul!

vmap <silent> J :t'><cr>
vmap <silent> K :t .-1<cr>
vnoremap p "_dP

" Move by line
nnoremap j gj
nnoremap k gk



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
nmap <silent> <buffer> <Leader>d : <C-u>call GOVIMHover()<CR>
command! Cnext try | cbelow | catch | cabove 9999 | catch | endtry
nnoremap <silent><leader>e :Cnext<CR>

nmap u     <Plug>(highlightedundo-undo)
nmap <C-r> <Plug>(highlightedundo-redo)
nmap U     <Plug>(highlightedundo-Undo)
nmap g-    <Plug>(highlightedundo-gminus)
nmap g+    <Plug>(highlightedundo-gplus)

autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu
" set wildmode=list:longest,list:full
set wildignore=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*

if has('nvim') && exists('&winblend') && &termguicolors

    let $FZF_DEFAULT_OPTS .= ' --inline-info'
    if exists('g:fzf_colors.bg')
        call remove(g:fzf_colors, 'bg')
    endif

    if stridx($FZF_DEFAULT_OPTS, '--border') == -1
        let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'
    endif

    function! FloatingFZF()
        let width = float2nr(&columns * 0.9)
        let height = float2nr(&lines * 0.6)
        let opts = { 'relative': 'editor',
                    \ 'row': (&lines - height) / 2,
                    \ 'col': (&columns - width) / 2,
                    \ 'width': width,
                    \ 'height': height }

        let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
    endfunction

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

command! -bang -nargs=* Buf
            \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'))

let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Label'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

nmap <silent> ,o :Files<CR>
nmap <silent> ,f :Rg<CR>
nmap <silent> ,a :Buf<CR>

" whichkey
nnoremap <silent> , :WhichKey ','<CR>
vnoremap <silent> , :WhichKeyVisual ','<CR>
set timeoutlen=500

" clever-f
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1

" buftabline
let g:buftabline_numbers = 2
let g:buftabline_show = 1
hi! BufTabLineCurrent ctermbg=233 ctermfg=242 guibg=#252525 guifg=#b877db
hi! link BufTabLineActive Normal
hi! link BufTabLineHidden Comment
hi! BufTabLineFill ctermbg=233 ctermfg=242 guibg=#151515 guifg=#b877db

" abbr
" using <C-l> to trigger abbr
inoremap <C-l> <C-]>

iabbrev wr w http.ResponseWriter, r *http.Request<right>
iabbrev iferr if err != nil {<CR>

set shell=/bin/zsh

" {{{ plug
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'lifepillar/vim-colortemplate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'ap/vim-buftabline'
Plug 'godlygeek/tabular'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'gregsexton/MatchTag'
Plug 'alok/notational-fzf-vim'
Plug 'plasticboy/vim-markdown'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'inkarkat/vim-LineJuggler'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-visualrepeat'
Plug 'matze/vim-move'
Plug 'jreybert/vimagit'
Plug 'junegunn/goyo.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'godoctor/godoctor.vim'
Plug 'sebdah/vim-delve'

" Plug 'liuchengxu/graphviz.vim'
" Plug 'machakann/vim-sandwich'
" Plug 'posva/vim-vue'
" Plug 'vifm/vifm.vim'
" Plug 'majutsushi/tagbar'
" Plug 'liuchengxu/vista.vim'
" Plug 'honza/vim-snippets'
" Plug 'fatih/vim-go'
" Plug 'SirVer/ultisnips'
" Plug 'mg979/vim-visual-multi'

call plug#end()
" }}}

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"{{{ set

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

"" Fix backspace indent
set backspace=indent,eol,start
set splitbelow
set splitright

set foldmethod=marker

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set autoread
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

syntax on
set ruler
set number

let no_buffers_menu=1

set mousemodel=popup
set t_Co=256
set scrolloff=3

"" Status bar
set laststatus=2
set noshowmode

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set background=dark
set termguicolors

" mouse
set mouse=a
set number relativenumber
set list

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Disable visualbell
set noerrorbells visualbell t_vb=
set belloff+=ctrlg

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" }}}

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"{{{ abbr

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

"  }}}

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
" {{{ autocmd

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


" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

"}}}

"*****************************************************************************
"" Mappings
"*****************************************************************************
"{{{ mappings
" Buffer nav
noremap <silent> <S-J> :bp<CR>
noremap <silent> <S-K> :bn<CR>
noremap <silent> ,w :bd<CR>

imap <silent> jk <Esc>:FixWhitespace<CR>
imap <silent> kj <Esc>:FixWhitespace<CR>


" floaterm
let g:floaterm_position = 'center'
let g:floaterm_keymap_toggle = ',s'
let g:floaterm_keymap_new    = ',t'
let g:floaterm_keymap_next   = ',n'
let g:floaterm_winblend = '10'
let g:floaterm_background = '#121212'


" whichkey
nnoremap <silent> , :WhichKey ','<CR>
vnoremap <silent> , :WhichKeyVisual ','<CR>
set timeoutlen=500


" clever-f
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1


" linejuggler
" duplicate selection to right or left without polluting the register
vmap <S-l>   <Plug>(LineJugglerDupRangeUp)
vmap <S-h> <Plug>(LineJugglerDupRangeDown)


" Clean search (highlight)
nnoremap <silent> ,, :noh<cr>


"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv


" duplicate selection to upper and down without polluting the register
vmap <silent> J :t'><cr>
vmap <silent> K :t .-1<cr>


"" Split
noremap <silent>,j :<C-u>split<CR>
noremap <silent>,h :<C-u>vsplit<CR>

" }}}

"" Personal
" Switch CWD to the directory of the open buffer:
map ,cd :cd %:p:h<cr>:pwd<cr>
nnoremap ,. :NV<cr>

let g:nv_use_ignore_files = 0
let g:nv_search_paths = ['~/Notes/Notes']
let g:move_key_modifier = 'C'


nnoremap ,cfv :vsplit ~/.config/nvim/init.vim <cr>
nnoremap ,ref :source ~/.config/nvim/init.vim <cr>

vnoremap <silent> ,r :call VisualSelection('replace')<CR>


"" Opens an edit command with the path of the currently edited file filled in

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

colorscheme horizon "  space_vim_themespacecamp srcery ayu one tequila-sunrise gruvbox-material horizon codedark
let g:space_vim_italicize_strings = 1
let g:space_vim_italic = 1
"


"*****************************************************************************
" buftabline
"*****************************************************************************
" {{{ buftabline

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

" hi! link BufTabLineCurrent TabLineSel
" hi! link BufTabLineActive PmenuSel
" hi! link BufTabLineHidden TabLine
" hi! link BufTabLineFill TabLineFill
" ----------------------------------------
hi! BufTabLineCurrent ctermbg=233 ctermfg=242 guibg=#252525 guifg=#b877db
hi! link BufTabLineActive Normal
hi! link BufTabLineHidden Comment
hi! BufTabLineFill ctermbg=233 ctermfg=242 guibg=#151515 guifg=#b877db

"}}}

"*****************************************************************************
" fzf.vim
"*****************************************************************************
" {{{ fzf
augroup terminal-mode
    autocmd!
    au TermOpen * setlocal nonumber
    au TermOpen * setlocal norelativenumber
    au TermOpen * setlocal noruler
    au TermOpen * setlocal noshowcmd
augroup end

autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu
" set wildmode=list:longest,list:full
set wildignore=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*

if has('nvim') && exists('&winblend') && &termguicolors
    set winblend=10

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
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Pmenu'],
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

" }}}

"*****************************************************************************
" coc.nvim
"*****************************************************************************
" {{{ coc

let g:coc_global_extensions = [
            \ 'coc-git',
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-emmet',
            \ 'coc-yank',
            \ 'coc-pairs',
            \ 'coc-eslint',
            \ 'coc-prettier',
            \ 'coc-css',
            \ 'coc-go',
            \ 'coc-highlight'
            \ ]
"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <C-j>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<C-j>" :
            \ coc#refresh()

let g:coc_snippet_next = '<C-e>'
let g:coc_snippet_prev = '<C-q>'

inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<TAB>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> <C-[> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-]> <Plug>(coc-diagnostic-next)

nmap <silent>gr <Plug>(coc-references)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>ge <Plug>(coc-definition)

nnoremap <silent> ,d :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

let g:coc_git_status=1
nmap gs <Plug>(coc-git-chunkinfo)
nmap gd <Plug>(coc-git-commit)
nmap gN <Plug>(coc-git-prevchunk)
nmap gn <Plug>(coc-git-nextchunk)

"}}}

"*****************************************************************************
"" Custom configs
"*****************************************************************************
" {{{ custom

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab


" go
autocmd BufNewFile,BufRead *.go setlocal listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
autocmd BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl
autocmd Filetype gohtmltmpl setlocal ts=2 sw=2 expandtab
autocmd Filetype template setlocal ts=2 sw=2 expandtab

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>

nnoremap ,gr :Rename<space>
vnoremap ,gv :Refactor var<space>
vnoremap ,gf :Refactor exatract<space>

" web
autocmd Filetype typescript,javascript,css,html,vue setlocal ts=2 sw=2 expandtab

" vue
let g:vue_pre_processors = 'detect_on_enter'

" md
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']


" Syntax highlight
let g:polyglot_disabled = ['python']

" }}}

"*****************************************************************************
"" Statusline Modifications
"*****************************************************************************
"{{{ statusline

" Left side
set statusline=
set statusline+=%1*\ %{StatuslineMode()}\ 
set statusline+=%2*\ %{get(g:,'coc_git_status')}%{get(b:,'coc_git_status')}
set statusline+=%6*\ %f%m%r%h%w
set statusline+=%=
" Right side
set statusline+=%2*\ %{&ff}\/%Y\ 
set statusline+=%5*%3p%%,\ %3l:%-3c
set statusline+=%7*%{Check_mixed_indent_file()}

hi User1 cterm=bold  ctermbg=25  ctermfg=189 gui=bold guibg=#853e64 guifg=#121212
hi User2 ctermbg=235 ctermfg=189 guibg=#262626  guifg=#d7d7ff
hi User3 ctermbg=235 ctermfg=25 guibg=#262626 guifg=#6981c5
hi User4 ctermbg=0 ctermfg=235 guibg=#000000 guifg=#262626
hi User5 ctermbg=25  ctermfg=189 guibg=#853e64 guifg=#121212
hi User6 cterm=italic ctermbg=0  ctermfg=133 guibg=#161616 guifg=#853e64
hi User7 cterm=bold ctermbg=209  ctermfg=0 guibg=#ca754b guifg=#121212
" }}}

"*****************************************************************************
"" Functions
"*****************************************************************************
"{{{ functions

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
        return printf(" Mix tab:%d spc:%d ", indent_tabs, indent_spc)
    else
        return ''
    endif
endfunction

" Create a dir if not exists
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" }}}


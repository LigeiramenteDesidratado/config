set shell=/bin/zsh
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'bronson/vim-trailing-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-buftabline'
Plug 'godlygeek/tabular'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
Plug 'gregsexton/MatchTag'
Plug 'alok/notational-fzf-vim'
Plug 'plasticboy/vim-markdown'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'inkarkat/vim-LineJuggler'
Plug 'inkarkat/vim-ingo-library'
Plug 'cohama/lexima.vim'
Plug 'morhetz/gruvbox'
" Plug 'matze/vim-move'
Plug 'jreybert/vimagit'
Plug 'mhinz/vim-signify'
Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'neovim/nvim-lsp'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
Plug 'machakann/vim-sandwich'
" Plug 'posva/vim-vue'
" Plug 'vifm/vifm.vim'
" Plug 'majutsushi/tagbar'
" Plug 'liuchengxu/vista.vim'
" Plug 'fatih/vim-go'
" Plug 'honza/vim-snippets'
" Plug 'fatih/vim-go'
" Plug 'SirVer/ultisnips'
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
set splitright

set nofoldenable

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
"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler

let no_buffers_menu=1

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
set mousemodel=popup
set guicursor=
" set number relativenumber
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



"*****************************************************************************
"" Mappings
"*****************************************************************************
"
"floaterm
let g:floaterm_position = 'center'
let g:floaterm_keymap_toggle = ',s'
let g:floaterm_keymap_new    = ',t'
let g:floaterm_keymap_next   = ',n'
let g:floaterm_winblend = 10
let g:floaterm_background = '#121212'


" clever-f
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1


"" Personal
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-l> <Right>

autocmd InsertEnter,InsertLeave * set cul!
nmap <silent>gs :SignifyHunkDiff<CR>
let g:signify_sign_add = "▏"
" let g:signify_sign_delete = "▏"
" let g:signify_sign_delete_first_line = "▏"
let g:signify_sign_change = "▏"
" let g:signify_sign_show_count = "▏"
" let g:signify_sign_show_text = "▏"
highlight link SignifyLineAdd             GitGutterAdd
highlight link SignifyLineChange          GitGutterChange
highlight link SignifyLineDelete          GitGutterDelete
highlight link SignifyLineDeleteFirstLine GitGutterDelete

highlight link SignifySignAdd             GitGutterAdd
highlight link SignifySignChange          GitGutterChange
highlight link SignifySignDelete          GitGutterDelete
highlight link SignifySignDeleteFirstLine GitGutterDelete

let g:LanguageClient_diagnosticsList = 'Disabled'
let g:LanguageClient_hoverPreview = 'always'
let g:LanguageClient_completionPreferTextEdit = 0
let g:LanguageClient_useVirtualText = 'All'
let g:LanguageClient_echoProjectRoot = 0
let g:LanguageClient_preferredMarkupKind = ['markdown', 'plaintext']
let g:LanguageClient_applyCompletionAdditionalTextEdits = 0
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_showCompletionDocs = 1
let g:LanguageClient_hideVirtualTextsOnInsert = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'go' : ['gopls'],
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call LanguageClient#textDocument_hover()
  endif
endfunction

nmap <silent> ,d :call <SID>show_documentation()<CR>

" nnoremap <silent> ,d :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> ,ge :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> ,gi :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> ,gr :call LanguageClient#textDocument_references()<CR>

nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

augroup markdown_language_client_commands
    autocmd!
    autocmd WinLeave __LanguageClient__ ++nested call <SID>fixLanguageClientHover()
augroup END

function! s:fixLanguageClientHover()
    setlocal modifiable
    setlocal conceallevel=2
    normal i
    setlocal nomodifiable
endfunction

set completeopt=menu

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <C-j>
            \ pumvisible() ? "\<C-n>" :
            \ "<Down>"

inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "<Up>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "<Right>"
inoremap <C-h> <Left>

" LineJuggler
vmap <S-l> <Plug>(LineJugglerDupRangeUp)
vmap <S-h> <Plug>(LineJugglerDupRangeDown)
nmap <A-k> <Plug>(LineJugglerBlankUp)
nmap <A-j> <Plug>(LineJugglerBlankDown)
vmap <A-k> <Plug>(LineJugglerBlankUp)
vmap <A-j> <Plug>(LineJugglerBlankDown)
imap <A-k> <Plug>(LineJugglerBlankUp)
imap <A-j> <Plug>(LineJugglerBlankDown)


"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv


" move a selection block up and down
vmap <silent><C-k> :m'<-2<CR>gv=gv
vmap <silent><C-j> :m'>+1<CR>gv=gv

" move a single line up and down
nmap <silent><C-k> :m-2=<CR>==
nmap <silent><C-j> :m+1<CR>==

" move a character left and right
nmap <silent><C-h> :call MoveCharLeft()<CR>
nmap <silent><C-l> :call MoveCharRight()<CR>

" paste in visual mode without polluting the register
vnoremap p "_dP

let g:markdown_fenced_languages = ['go=go', 'coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']
" Switch CWD to the directory of the open buffer:
map ,cd :cd %:p:h<cr>:pwd<cr>
nnoremap ,. :NV<cr>

let g:nv_use_ignore_files = 0
let g:nv_search_paths = ['~/Notes/Notes']
let g:move_key_modifier = 'C'
" let g:C_Ctrl_j='off'
" let g:notes_directories = ['~/Notes']
let g:vue_pre_processors = 'detect_on_enter'
" map j gj
" map k gk
nnoremap ,cfv :vsplit ~/.config/nvim/init.vim <cr>
nnoremap ,ref :source ~/.config/nvim/init.vim <cr>

vnoremap <silent> ,r :call VisualSelection('replace')<CR>


" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

"" Opens an edit command with the path of the currently edited file filled in

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
imap <silent> jk <Esc>:FixWhitespace<CR>
imap <silent> kj <Esc>:FixWhitespace<CR>

colorscheme gruvbox " space_vim_theme  hybrid_reverse  deep-space ayu spacecamp srcery one tequila-sunrise horizon gruvbox-material horizon  codedark
let g:space_vim_italicize_strings = 1
let g:space_vim_italic = 1
let g:gruvbox_italic=1
"
"" Split
noremap <silent>,j :<C-u>split<CR>
noremap <silent>,h :<C-u>vsplit<CR>


"*****************************************************************************
" buftabline
"*****************************************************************************
nnoremap <silent> <S-t> :tabnew<CR>
let g:buftabline_numbers = 2
let g:buftabline_show = 1

hi! link BufTabLineCurrent TabLineSel
hi! link BufTabLineActive PmenuSel
hi! link BufTabLineHidden TabLine
hi! link BufTabLineFill TabLineFill

"*****************************************************************************
" fzf.vim
"*****************************************************************************
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

    let $FZF_DEFAULT_OPTS .= '--bind alt-k:preview-up,alt-j:preview-down --height=70% --preview="ccat --color=always {}" --preview-window=right:60%:wrap --inline-info'
    if exists('g:fzf_colors.bg')
        call remove(g:fzf_colors, 'bg')
    endif

    if stridx($FZF_DEFAULT_OPTS, '--border') == -1
        let $FZF_DEFAULT_OPTS .= ' --border'
    endif

    function! FloatingFZF()
        let width = float2nr(&columns * 0.9)
        let height = float2nr(&lines * 0.6)
        let opts = { 'relative': 'editor',
                    \ 'row': (&lines - height) / 2,
                    \ 'col': &columns,
                    \ 'width': &columns,
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

" Custom statusline
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=0 ctermbg=15
  highlight fzf2 ctermfg=0 ctermbg=15
  highlight fzf3 ctermfg=0 ctermbg=15
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

nmap <silent> ,o :Files<CR>
nmap <silent> ,f :Rg<CR>
nmap <silent> ,a :Buf<CR>


noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>


"" Buffer nav
noremap <silent> <S-J> :bp<CR>
noremap <silent> <S-K> :bn<CR>
noremap <silent> ,w :bd<CR>

"" Clean search (highlight)
nnoremap <silent> ,, :noh<cr>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

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

function! g:IfErr() " go get -u github.com/koron/iferr
  let bpos = wordcount()['cursor_bytes']
  let out = systemlist('goret -pos ' . bpos, bufnr('%'))
  if len(out) == 0
    return
  endif
  return out[0]
endfunction

command! -buffer -nargs=0 IfErr call s:IfErr()

" web
autocmd Filetype typescript,javascript,css,html,vue setlocal ts=2 sw=2 expandtab

" Syntax highlight
let g:polyglot_disabled = ['python']

"*****************************************************************************
"" Statusline Modifications
"*****************************************************************************

" Left side
set statusline=
set statusline+=%1*\ %{StatuslineMode()}\ 
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


"*****************************************************************************
"" Functions
"*****************************************************************************

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

function! MoveCharLeft()
    let l:distance = v:count ? v:count : 1
    let s:default_register_value = @"
    if (virtcol('.') - l:distance <= 0)
        silent normal! x0P
    else
        silent normal! x1hP
    endif
    let @" = s:default_register_value
endfunction

function! MoveCharRight()
    let l:distance = v:count ? v:count : 1
    let s:default_register_value = @"
    if (virtcol('.') + l:distance >= virtcol('$') - 1)
        silent normal! x$p
    else
        silent normal! x1lP
    endif
    let @" = s:default_register_value
endfunction
" duplicate selection to upper and down without polluting the register
vmap <silent> <S-J> :t'><cr>
vmap <silent> <S-K> :t .0<cr>

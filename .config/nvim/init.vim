set shell=/bin/zsh

" {{{ plug
call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'bronson/vim-trailing-whitespace'
Plug 'sheerun/vim-polyglot'
" Plug 'neovim/nvim-lsp'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'ap/vim-buftabline'
Plug 'godlygeek/tabular'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'alok/notational-fzf-vim'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'tommcdo/vim-exchange'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'plasticboy/vim-markdown'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jreybert/vimagit'
Plug 'junegunn/goyo.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'godoctor/godoctor.vim'
" Plug 'romainl/vim-cool'
Plug 'cohama/lexima.vim'
Plug 'alvan/vim-closetag'
Plug 'andymass/vim-matchup'
Plug 'machakann/vim-highlightedundo'

" Line Move
Plug 'inkarkat/vim-LineJuggler'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-visualrepeat'
Plug 'matze/vim-move'

" Colorschemes
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'fmoralesc/molokayo'
Plug 'artanikin/vim-synthwave84'
Plug 'tomasr/molokai'
" Plug 'sebdah/vim-delve'
" Plug 'jaredgorski/spacecamp'
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
set spell

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
" set noswapfile
set dir=~/.cache/nvim

set fileformats=unix,dos,mac

syntax on
set ruler
" set number
" set number relativenumber
set nrformats=alpha,octal,hex,bin

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
" set list

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

" using <C-l> to trigger abbr
inoremap <C-l> <C-]>

iabbrev wr w http.ResponseWriter, r *http.Request<right>
iabbrev iferr if err != nil {<CR>

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
let g:floaterm_winblend = 10
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
set lazyredraw
set ttyfast
autocmd InsertEnter,InsertLeave * set cul!
set guicursor=
vnoremap p "_dP
"
" Move by line
nnoremap j gj
nnoremap k gk

nnoremap ,x *``cgn

" highlight last inserted text
nnoremap gV `[v`]

nnoremap <silent> ,cc :ColorizerToggle<cr>
let g:CoolTotalMatches = 1
let g:closetag_filetypes = 'html,vue'

" lua << EOF
" local nvim_lsp = require('nvim_lsp')
" local buf_set_keymap = vim.api.nvim_buf_set_keymap

" local on_attach = function(_, bufnr)
"   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

"     -- Mappings.
"     local opts = { noremap=true, silent=true }
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
"   end

"   local servers = {'gopls', 'rust_analyzer', 'sumneko_lua', 'tsserver',  'jsonls'}
"   for _, lsp in ipairs(servers) do
"     nvim_lsp[lsp].setup {
"       on_attach = on_attach,
"     }
"   end
" EOF
" let g:LspDiagnosticsErrorSign = '>'
" let g:LspDiagnosticsWarningSign = '>'
" let g:LspDiagnosticsInformationSign = '>'
" let g:LspDiagnosticsHintSign = '>'

" {{{ TextYankPost highlight
function! s:hl_yank(operator, regtype, inclusive) abort
    if a:operator !=# 'y' || a:regtype ==# ''
        return
    endif
    " edge cases:
    "   ^v[count]l ranges multiple lines

    " TODO:
    "   bug: ^v where the cursor cannot go past EOL, so '] reports a lesser column.

    let bnr = bufnr('%')
    let ns = nvim_create_namespace('')
    call nvim_buf_clear_namespace(bnr, ns, 0, -1)

    let [_, lin1, col1, off1] = getpos("'[")
    let [lin1, col1] = [lin1 - 1, col1 - 1]
    let [_, lin2, col2, off2] = getpos("']")
    let [lin2, col2] = [lin2 - 1, col2 - (a:inclusive ? 0 : 1)]
    for l in range(lin1, lin1 + (lin2 - lin1))
        let is_first = (l == lin1)
        let is_last = (l == lin2)
        let c1 = is_first || a:regtype[0] ==# "\<C-v>" ? (col1 + off1) : 0
        let c2 = is_last || a:regtype[0] ==# "\<C-v>" ? (col2 + off2) : -1
        call nvim_buf_add_highlight(bnr, ns, 'TextYank', l, c1, c2)
    endfor
    call timer_start(300, {-> nvim_buf_is_valid(bnr) && nvim_buf_clear_namespace(bnr, ns, 0, -1)})
endfunc
highlight default link TextYank MatchParen
augroup vimrc_hlyank
    autocmd!
    autocmd TextYankPost * call s:hl_yank(v:event.operator, v:event.regtype, v:event.inclusive)
augroup END
" }}}

" un-join (split) the current line at the cursor position
nnoremap gj i<c-j><esc>k$
let g:nv_use_ignore_files = 0
let g:nv_search_paths = ['~/Notes/Notes']
let g:move_key_modifier = 'C'


nnoremap ,cfv :vsplit ~/.config/nvim/init.vim <cr>
nnoremap ,ref :source ~/.config/nvim/init.vim <cr>

vnoremap <silent> ,r :call VisualSelection('replace')<CR>

nmap u     <Plug>(highlightedundo-undo)
nmap <C-r> <Plug>(highlightedundo-redo)
nmap U     <Plug>(highlightedundo-Undo)
nmap g-    <Plug>(highlightedundo-gminus)
nmap g+    <Plug>(highlightedundo-gplus)
"" Opens an edit command with the path of the currently edited file filled in

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

colorscheme  molokai " agila spacecamp space_vim_theme deep-space space_vim_theme molokayo horizon plastic srcery horizon spacecamp srcery ayu one tequila-sunrise gruvbox-material codedark
let g:space_vim_italicize_strings = 1
let g:space_vim_italic = 1
let g:deepspace_italics=1
"

hi MatchWordCur cterm=underline gui=underline
hi MatchParenCur cterm=underline gui=underline
hi MatchWord cterm=underline gui=underline
"*****************************************************************************
" buftabline
"*****************************************************************************
" {{{ buftabline

nnoremap <silent> <S-t> :tabnew<CR>
let g:buftabline_numbers = 2
let g:buftabline_show = 1

" nmap ,1 <Plug>BufTabLine.Go(1)
" nmap ,2 <Plug>BufTabLine.Go(2)
" nmap ,3 <Plug>BufTabLine.Go(3)
" nmap ,4 <Plug>BufTabLine.Go(4)
" nmap ,5 <Plug>BufTabLine.Go(5)
" nmap ,6 <Plug>BufTabLine.Go(6)
" nmap ,7 <Plug>BufTabLine.Go(7)
" nmap ,8 <Plug>BufTabLine.Go(8)
" nmap ,9 <Plug>BufTabLine.Go(9)
" nmap ,0 <Plug>BufTabLine.Go(10)

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

    let $FZF_DEFAULT_OPTS .= '--bind alt-k:preview-up,alt-j:preview-down --height=70% --preview="ccat --color=always {}" --preview-window=right:60%:wrap --inline-info'
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

" }}}

"*****************************************************************************
" coc.nvim
"*****************************************************************************
" {{{ coc

" if has("coc_status")
let g:coc_global_extensions = [
            \ 'coc-git',
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-emmet',
            \ 'coc-eslint',
            \ 'coc-prettier',
            \ 'coc-css',
            \ 'coc-go',
            \ 'coc-clangd',
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
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-]>"

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
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go nmap ,gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap ,gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap ,gtx :CocCommand go.tags.clear<cr>

" endif

"}}}

"*****************************************************************************
"" Custom configs
"*****************************************************************************
" {{{ custom

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab


" go
" autocmd BufNewFile,BufRead *.go setlocal listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
autocmd BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl
autocmd Filetype gohtmltmpl setlocal ts=2 sw=2 expandtab
autocmd Filetype template setlocal ts=2 sw=2 expandtab

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
set statusline+=%2*\ %<%{get(g:,'coc_git_status')}%{get(b:,'coc_git_status')}
set statusline+=%6*\ %<%f%m%r%h%w%<
set statusline+=%=
" Right side
set statusline+=%<ascii:%b%2*\ %{&ff}\/%Y\ 
set statusline+=%5*%3p%%,\ %3c:%3l\ of\ %-4L
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


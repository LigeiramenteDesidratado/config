
"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|


call plug#begin('~/.vim/plugged')

Plug 'vimwiki/vimwiki'
Plug 'jreybert/vimagit'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'flazz/vim-colorschemes'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sirver/ultisnips'
Plug 'yggdroot/indentline'
Plug 'jiangmiao/auto-pairs'
Plug 'lilydjwg/colorizer'
Plug 'matze/vim-move'

call plug#end()

" Some basics:
	let mapleader =" "
	let g:airline_theme='serene'
	set nocompatible
	syntax on
	set encoding=utf-8
	set fileencoding=utf-8
	colorscheme delek
	set hlsearch
	set incsearch
	set autoread
	set ignorecase
	set smartcase
	set number
	set relativenumber
	set clipboard=unnamedplus
	set nocindent

" Vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'


let g:SuperTabDefaultCompletionType    = '<C-a>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<C-l>'
let g:UltiSnipsJumpForwardTrigger      = '<C-l>'
let g:UltiSnipsJumpBackwardTrigger     = '<C-h>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" Splits open at the bottom and right, which is non-retarded, unlike vim de faults.
	set splitbelow
	set splitright


let g:move_key_modifier = 'C'

" Shortcutting split navigation, saving a keypress:
	map <C-n> gt
	imap jk <Esc>

" Compile document
	map <leader>a :w<CR>:!compiler <c-r>%<CR>


" Go imorts
	map <leader>i :GoImports<CR>
" Automatically deletes all tralling whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e



" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" C-T for new tab
        nnoremap <C-t> :tabnew<cr>

" vnoremap K xkP`[V`]
" vnoremap J xp`[V`]
" vnoremap L >gv
" vnoremap H <gv


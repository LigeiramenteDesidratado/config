
"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|


call plug#begin('~/.vim/plugged')

Plug 'jreybert/vimagit'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'flazz/vim-colorschemes'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'yggdroot/indentline'
Plug 'powerline/powerline'
Plug 'yuttie/comfortable-motion.vim'

call plug#end()

" Some basics:
	let mapleader =" "
	let g:airline_theme='serene'
	set nocompatible
	syntax on
	set encoding=utf-8
	set fileencoding=utf-8
	colorscheme putty

" Vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|||'
let g:airline#extensions#tabline#formatter = 'unique_tail'



let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"


let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']


" Splits open at the bottom and right, which is non-retarded, unlike vim de faults.
	set splitbelow
	set splitright


" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

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



  "____        _                  _
 "/ ___| _ __ (_)_ __  _ __   ___| |_ ___
 "\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
  "___) | | | | | |_) | |_) |  __/ |_\__ \
 "|____/|_| |_|_| .__/| .__/ \___|\__|___/
                "|_|   |_|


autocmd FileType go inoremap " ""<Esc>i
autocmd FileType go inoremap ( ()<Esc>i
autocmd FileType go inoremap { {<cr>}
autocmd FileType go inoremap [ []<Esc>i
" autocmd FileType go inoremap ,i if err != nil {<cr>return<cr>}
"autocmd FileType go inoremap ,f fmt.Println()<Esc>i

vnoremap K xkP`[V`]
vnoremap J xp`[V`]
vnoremap L >gv
vnoremap H <gv


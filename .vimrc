"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
let mapleader =" "
let g:airline_theme='wal'
" Load Pathogen for plugins:
	execute pathogen#infect()
	execute pathogen#helptags()
	colorscheme putty
" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number
	set relativenumber

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow
	set splitright

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Open the selected text in a split (i.e. should be a file).
	map <leader>o "oyaW:sp <C-R>o<CR>
	xnoremap <leader>o "oy<esc>:sp <C-R>o<CR>
	vnoremap <leader>o "oy<esc>:sp <C-R>o<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Open corresponding.pdf
	map <leader>p :!opout <c-r>%<CR><CR>

" Compile document
	map <leader>a :w<CR>:!compiler <c-r>%<CR>

" Go imorts
	map <leader>i :GoImports<CR>

" Interpret .md files, etc. as .markdown
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Spell-check set to F6:
	map <F6> :setlocal spell! spelllang=en_us<CR>

" Goyo plugin makes text more readable when writing prose:
	map <F10> :Goyo<CR>
	map <leader>f :Goyo \| set linebreak<CR>
	inoremap <F10> <esc>:Goyo<CR>a

" Automatically deletes all tralling whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" C-T for new tab
	nnoremap <C-t> :tabnew<cr>

" Navigating with guides
	inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	map <Space><Tab> <Esc>/<++><Enter>"_c4l

" For normal mode when in terminals (in X I have caps mapped to esc, this replaces it when I don't have X)
"	inoremap jw <Esc>
"	inoremap wj <Esc>

 "____        _                  _
"/ ___| _ __ (_)_ __  _ __   ___| |_ ___
"\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
 "___) | | | | | |_) | |_) |  __/ |_\__ \
"|____/|_| |_|_| .__/| .__/ \___|\__|___/
              "|_|   |_|

autocmd FileType go inoremap " ""<Esc>i
autocmd FileType go inoremap ( ()<Esc>i
autocmd FileType go inoremap { {}<Esc>i
autocmd FileType go inoremap [ []<Esc>i
autocmd FileType go inoremap ,i if err != nil {<cr><Tab><Tab>return<cr><Tab>}
autocmd FileType go inoremap ,f fmt.Println()<Esc>i

vnoremap K xkP`[V`]
vnoremap J xp`[V`]
vnoremap L >gv
vnoremap H <gv

map <enter><enter> yi[:e <c-r>"<cr>

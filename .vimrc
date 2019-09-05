set shell=/bin/dash

call plug#begin(expand('~/.vim/plugged'))

Plug 'sheerun/vim-polyglot'
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

call plug#end()



imap <silent> jk <Esc>
colorscheme horizon
set fillchars+=vert:\|
set list
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←
set number relativenumber

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


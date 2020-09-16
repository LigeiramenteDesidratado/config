let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1

luafile ~/.config/nvim/init.lua

"" Remember cursor position
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

filetype plugin indent on
filetype detect
syntax on

autocmd! FileType make setlocal noexpandtab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

function! New_cib()
    if search("(","bn") == line(".")
        sil exe "normal! f)ci("
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f(ci("
        sil exe "normal! l"
        startinsert
    endif
endfunction

" And for curly brackets
function! New_ciB()
    if search("{","bn") == line(".")
        sil exe "normal! f}ci{"
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f{ci{"
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci( :call New_cib()<CR>
nnoremap ci) :call New_cib()<CR>
nnoremap ci{ :call New_ciB()<CR>
nnoremap ci} :call New_ciB()<CR>


" inoremap <C-i> :call New_cib()<CR>

" STATUSLINE
set statusline=%#Folded#
set statusline+=\ [%#ShowMarksHLl#%t%#Folded#]
set statusline+=\ [%#ShowMarksHLl#%{FugitiveStatusline()}%#Folded#]
set statusline+=%m%r%h%w
set statusline+=%=
set statusline+=\ [%#ShowMarksHLl#%{&fileencoding?&fileencoding:&encoding}%#Folded#]
set statusline+=\ [%#ShowMarksHLl#%{&fileformat}%#Folded#]
set statusline+=\ [ROW:%#ShowMarksHLl#%-3l%#Folded#\ COL:%#ShowMarksHLl#%-2c%#Folded#]
set statusline+=\ [%#ShowMarksHLl#%-3p%#Folded#%%]

"*****************************************************************************
"" Statusline Modifications
"*****************************************************************************

" " Left side
" set statusline=
" set statusline+=%1*\ %{StatuslineMode()}\ 
" set statusline+=%6*\ %f%m%r%h%w
" set statusline+=%=
" " Right side
" set statusline+=%2*\ %{&ff}\/%Y\ 
" set statusline+=%5*%3p%%,\ %3l:%-3c
" set statusline+=%7*%{Check_mixed_indent_file()}

" hi User1 cterm=bold  ctermbg=25  ctermfg=189 gui=bold guibg=#853e64 guifg=#121212
" hi User2 ctermbg=235 ctermfg=189 guibg=#262626  guifg=#d7d7ff
" hi User3 ctermbg=235 ctermfg=25 guibg=#262626 guifg=#6981c5
" hi User4 ctermbg=0 ctermfg=235 guibg=#000000 guifg=#262626
" hi User5 ctermbg=25  ctermfg=189 guibg=#853e64 guifg=#121212
" hi User6 cterm=italic ctermbg=0  ctermfg=133 guibg=#161616 guifg=#853e64
" hi User7 cterm=bold ctermbg=209  ctermfg=0 guibg=#ca754b guifg=#121212

" function! StatuslineMode()
"   let l:mode=mode()
"   if l:mode==#"n"
"     return "NORMAL"
"   elseif l:mode==?"v"
"     return "VISUAL"
"   elseif l:mode==#"i"
"     return "INSERT"
"   elseif l:mode==#"R"
"     return "REPLACE"
"   elseif l:mode==?"s"
"     return "SELECT"
"   elseif l:mode==#"t"
"     return "TERMINAL"
"   elseif l:mode==#"c"
"     return "COMMAND"
"   elseif l:mode==#"!"
"     return "SHELL"
"   endif
" endfunction

" function! Check_mixed_indent_file()
"   let head_spc = '\v(^ +)'
"   let indent_tabs = search('\v(^\t+)', 'nw')
"   let indent_spc  = search(head_spc, 'nw')
"   if indent_tabs > 0 && indent_spc > 0
"     return printf(" Mix tab:%d spc:%d ", indent_tabs, indent_spc)
"   else
"     return ''
"   endif
" endfunction


#!/usr/bin/fish

function fish_prompt

	set foldername (basename $PWD)
   	set_color red --bold
    test "$USER" = 'root'
    and printf "[%s] # " $foldername

   # Main
   printf "[%s] " $foldername
   set_color normal
end

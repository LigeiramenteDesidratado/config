#! /bin/bash

#exec i3
#exec dwm &>> $HOME/dwmlogs
 > /home/machine/isdwmrunning
 rs&
 programming-mode&
 remaps&
 dunst&
 mpd&
 bardwm&
 /home/machine/dev/python/tarefas/./tarefas.py&

  while : ; do
  	dwm 2>> ~/dwmlogs
      c=$(cat /home/machine/isdwmrunning)
      if [[ "${c}" -eq 1 ]]; then
          break
     fi
     sleep 1
 done


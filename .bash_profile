[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx

export TERM=xterm-256color

[[ -f ~/.bashrc ]] && . ~/.bashrc

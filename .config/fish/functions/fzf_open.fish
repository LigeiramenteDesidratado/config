function fzf_open -d "Open files with xdg-open"
    eval "$FZF_OPEN_COMMAND |" (__fzfcmd) $FZF_DEFAULT_OPTS | xargs -r xdg-open
end

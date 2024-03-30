export NNN_PLUG="z:autojump;c:fzcd"
export NNN_FCOLORS="0d0c040200060508010b0903"

alias nnn="nnn -e"
set --export NNN_FIFO "/tmp/nnn.fifo"
set --export NNN_TMPFILE "$HOME/.config/nnn/.lastd"

function n --wraps nnn --description 'change directory on nnn quit'
    if test -n "$NNNLVL"
        if [ (expr $NNNLVL + 0) -ge 1 ]
            echo "nnn is already running"
            return
        end
    end

    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    nnn -d $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
end

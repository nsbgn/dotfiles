export HISTCONTROL=ignoreboth # ignore duplicates & spaces
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # update values of LINES and COLUMNS if winsize changes

# Show directory in title bar
if [ ! -z ${TERM} ]; then # -a $TERM == 'rxvt-unicode-256color'
    PROMPT_COMMAND='echo -ne "\033]0;$(dirs -0)\007"'
fi

# Git prompt. Wrap non-printables in \[\], see unix.stackexchange.com/q/105958
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
export PS1="\W\$(__git_ps1) > \[$(tput sgr0)\]" # [\u@\h]

source "$HOME/.bash_aliases"
source /etc/bash_completion
# eval "$(register-python-argcomplete3 pubs)" # ~/.local/bin/pubs adds layer of
# indirection, hiding "PYTHON_ARGCOMPLETE_OK" (kislyuk.github.io/argcomplete)

# <https://codeberg.org/dnkl/foot/wiki#user-content-bash>
osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd


# Vi editing mode
# set -o vi

# Change colors on tty
# if [ "$TERM" = "linux" ]; then
#     echo -en "\e]P0232323" #black
#     echo -en "\e]P82B2B2B" #darkgrey
#     echo -en "\e]P1D75F5F" #darkred
#     echo -en "\e]P9E33636" #red
#     echo -en "\e]P287AF5F" #darkgreen
#     echo -en "\e]PA98E34D" #green
#     echo -en "\e]P3D7AF87" #brown
#     echo -en "\e]PBFFD75F" #yellow
#     echo -en "\e]P48787AF" #darkblue
#     echo -en "\e]PC7373C9" #blue
#     echo -en "\e]P5BD53A5" #darkmagenta
#     echo -en "\e]PDD633B2" #magenta
#     echo -en "\e]P65FAFAF" #darkcyan
#     echo -en "\e]PE44C9C9" #cyan
#     echo -en "\e]P7E5E5E5" #lightgrey
#     echo -en "\e]PFFFFFFF" #white
#     clear #for background artifacting
# fi

# Change directory after browsing with file manager `lf`
function lf {
    $(which lf) -last-dir-path="/tmp/lfdir" "$@"
    dir="$(cat /tmp/lfdir)"
    [ -d "$dir" ] && [ "$PWD" != "$dir" ] && cd "$dir"
}

function j {
    cd $(fdfind . ~ --type d --exec stat --printf='%Y\t%n\n' \
        | sort --numeric --reverse \
        | cut -f2- \
        | fzf --reverse --header='Jump to location')
}

if which mcfly > /dev/null; then
    eval "$(mcfly init bash)"
fi

# source "$HOME/.local/share/nvim/plugged/gruvbox/gruvbox_256palette.sh"

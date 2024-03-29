export HISTCONTROL=ignoreboth # ignore duplicates & spaces
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # update values of LINES and COLUMNS if winsize changes

if [ -f ~/.sensible.bash ]; then
   source ~/.sensible.bash
fi

# Show directory in title bar
if [ ! -z ${TERM} ]; then # -a $TERM == 'rxvt-unicode-256color'
    PROMPT_COMMAND='echo -ne "\033]0; $(dirs -0)\007"'
    # Emoji: 💲
    # FA:   
fi

# Hook direnv; see <https://direnv.net/>
eval "$(direnv hook bash)"

# Git prompt. Wrap non-printables in \[\], see unix.stackexchange.com/q/105958
# 
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
# \D{%H:%M:%S}
export PS1="\[\033[1;34m\]\w\[\033[0;34m\]\$(__git_ps1) \[\033[1;32m\]\$\[\033[0m\] \[$(tput sgr0)\]" # [\u@\h]

source "$HOME/.bash_aliases"
source /etc/bash_completion
# eval "$(register-python-argcomplete3 pubs)" # ~/.local/bin/pubs adds layer of
# indirection, hiding "PYTHON_ARGCOMPLETE_OK" (kislyuk.github.io/argcomplete)

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

function jqs {
    MODULE="$1"
    FILTER="$2"
    shift
    shift
    swaymsg -t get_tree | jq -r "include \"i3/${MODULE}\"; ${FILTER}" --args "$@"
}

# Change directory after browsing with file manager `lf`
function lf {
    $(which lf) -last-dir-path="/tmp/lfdir" "$@"
    dir="$(cat /tmp/lfdir)"
    [ -d "$dir" ] && [ "$PWD" != "$dir" ] && cd "$dir"
}

function g {
    nvim "$(fzf-repo)"
    # F="$(fzf-repo)"
    # if [ -d "$F" ]; then
    #     cd "$F"
    # elif file --mime-type "$F" | grep -q ': text'; then
    #     nvim "$F"
    # else
    #     xdg-open "$F"
    # fi
}

if which mcfly > /dev/null; then
    eval "$(mcfly init bash)"
fi

# fshow - git commit browser
# https://gist.github.com/junegunn/f4fca918e937e6bf5bad
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

venv() {
    VENV="$HOME/.venv"
    if [ ! -d $VENV ]; then
        python -m venv "$VENV" --system-site-packages
        pip3 install -U python-lsp-server[all] pylsp-mypy mypy
    fi
    source $VENV/bin/activate
}
. "$HOME/.cargo/env"


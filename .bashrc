export HISTCONTROL=ignoreboth # ignore duplicates & spaces
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # update values of LINES and COLUMNS if winsize changes

# Disable Ctrl-s when running interactively
if [[ -t 0 && $- = *i* ]]; then
    stty -ixon
fi

if [ -f ~/.sensible.bash ]; then
   source ~/.sensible.bash
fi

# for __git_ps1 on Fedora
if [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Show directory in title bar
if [ ! -z ${TERM} ]; then # -a $TERM == 'rxvt-unicode-256color'
    PROMPT_COMMAND='echo -ne "\033]0;$(dirs -0)\007"'
    # FA:   
fi

# Hook direnv; see <https://direnv.net/>
eval "$(direnv hook bash)"

# Git prompt. Wrap non-printables in \[\], see unix.stackexchange.com/q/105958
# 
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
# \D{%H:%M:%S}
export PS1="\[\033[1;34m\]\w\[\033[0;34m\]\$(__git_ps1) \[\033[1;32m\]\$\[\033[0m\] \[$(tput sgr0)\]" # [\u@\h]

# Change directory after browsing with file manager `lf`
function lf {
    $(which lf) -last-dir-path="/tmp/lfdir" "$@"
    dir="$(cat /tmp/lfdir)"
    [ -d "$dir" ] && [ "$PWD" != "$dir" ] && cd "$dir"
}

if test -f "$HOME/.bash_aliases"; then
    source "$HOME/.bash_aliases"
fi

if test -f /etc/bash_completion; then
    source /etc/bash_completion
fi

# Fedora
if test -f /etc/profile.d/bash_completion.sh; then
    source /etc/profile.d/bash_completion.sh
fi

if test -f "$HOME/.cargo/env"; then
    source "$HOME/.cargo/env"
fi

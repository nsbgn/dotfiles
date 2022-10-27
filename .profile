# The ~/.profile file is a good place to put environment variables. This file
# is not read by bash if ~/.bash_profile or ~/.bash_login exists.

export PATH=/usr/local/go/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.go/bin:$HOME/.npm-global/bin:.luarocks/bin:$PATH
export PATH=$HOME/.scripts:$HOME/dotfiles/.scripts:$HOME/dotfiles/.scripts/private:$HOME/.local/bin:$PATH
export GOPATH=$HOME/.go
export EDITOR=nvim
export BROWSER=firefox
export PRINTER="HL1110"
export CLICOLOR=1
export MYPY_CACHE_DIR=/tmp/mypycache
export LEDGER=$HOME/notes/money/current.ledger
export FZF_DEFAULT_COMMAND='fdfind --type f'
export DMENU_OPTS="-l 20 -fn Inconsolata-13"
export BEMENU_OPTS="-p '' -l 10 -H 30 --fn 'Inconsolata 13' --scrollbar always"

# include .bashrc if running interactively
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

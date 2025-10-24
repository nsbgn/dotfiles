# The ~/.profile file is a good place to put environment variables. This file
# is not read by bash if ~/.bash_profile or ~/.bash_login exists.

export PATH=$HOME/.scripts:$HOME/.private/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.go/bin:$HOME/.npm-global/bin:.luarocks/bin:/usr/lib/go-1.21/bin/:$PATH
export PATH=/usr/local/go/bin:/usr/local/bin:$PATH

export PASSWORD_STORE_DIR=$HOME/.private/password-store
export VDIRSYNCER_CONFIG=$HOME/.private/vdirsyncer/config
export GNUPGHOME=$HOME/.private/gnupg

export ALACRITTY_SOCKET=/run/user/1000/alacritty
export GOPATH=$HOME/.go
export EDITOR=nvim
export BROWSER=firefox
export PRINTER="HL1110"
export CLICOLOR=1
export MYPY_CACHE_DIR=/tmp/mypycache
export LEDGER=$HOME/notes/money/current.ledger
export FZF_DEFAULT_COMMAND='fdfind --type f'
export DMENU_OPTS="-l 20 -fn Inconsolata-13"

export BAT_STYLE="changes"
export BAT_THEME="auto"
export BAT_THEME_LIGHT="gruvbox-light"
export BAT_THEME_DARK="gruvbox-dark"

export BEMENU_OPTS="\
    --grab -p '' -l 12 -H 30 --fn 'Inconsolata 15'\
    --no-overlap --scrollbar always\
     --nb #f0f0f0  --nf #000000 \
     --ab #ebebeb  --af #000000 \
     --hb #909090  --hf #ffffff \
    --scb #b0b0b0 --scf #303030 \
     --fb #303030  --ff #ffffff \
     --tb #303030  --tf #b0b0b0 \
     "

# include .bashrc if running interactively
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# The ~/.profile file is a good place to put environment variables. This file
# is not read by bash if ~/.bash_profile or ~/.bash_login exists.

export PATH=$HOME/.private/bin:$HOME/.scripts:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.go/bin:$HOME/.npm-packages/bin:$HOME/.npm-global/bin:.luarocks/bin:/usr/lib/go-1.21/bin/:/usr/local/go/bin:/usr/local/bin:$PATH
export PASSWORD_STORE_DIR=$HOME/.private/password-store
export VDIRSYNCER_CONFIG=$HOME/.private/vdirsyncer/config
export GNUPGHOME=$HOME/.private/gnupg
export GOPATH=$HOME/.go
export ALACRITTY_SOCKET=/run/user/1000/alacritty
export EDITOR=nvim
export BROWSER=firefox
export PRINTER="HL1110"
export CLICOLOR=1
export MYPY_CACHE_DIR=/tmp/mypycache
export FZF_DEFAULT_COMMAND='fdfind --type f'
export BAT_STYLE="changes"
export BAT_THEME="auto"
export BAT_THEME_LIGHT="gruvbox-light"
export BAT_THEME_DARK="gruvbox-dark"

# include .bashrc if running interactively
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

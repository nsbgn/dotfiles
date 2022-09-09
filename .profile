# The ~/.profile file is a good place to put environment variables. This file
# is not read by bash if ~/.bash_profile or ~/.bash_login exists.

export PATH=/usr/local/go/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.go/bin:$HOME/.npm-global/bin:.luarocks/bin:$PATH
export PATH=$HOME/.scripts:$HOME/dotfiles/.scripts:$HOME/dotfiles/.scripts/private:$HOME/.local/bin:$PATH
export GOPATH=$HOME/.go
export EDITOR=nvim
export BROWSER=vimb
export PRINTER="HL1110"
export CLICOLOR=1
export MYPY_CACHE_DIR=/tmp/mypycache
export LEDGER=$HOME/notes/money/current.ledger
export FZF_DEFAULT_COMMAND='fdfind --type f'
export DMENU_OPTS="-l 20 -fn Inconsolata-13"
export BEMENU_OPTS="-p '' -l 10 -H 30 --fn 'Cascadia Code 12' --scrollbar always"

# For polybar
export ADAPTER="$(find -L /sys/class/power_supply -mindepth 1 -maxdepth 1 \
    -exec grep -qw {}/type -e Mains \; -print | head -n1 | cut -d'/' -f5)"
export BATTERY="$(find -L /sys/class/power_supply -mindepth 1 -maxdepth 1 \
    -exec grep -qw {}/type -e Battery \; -print | head -n1 | cut -d'/' -f5)"


# cf https://man.sr.ht/%7Ekennylevinsen/greetd/
# When using Wayland

export XKB_DEFAULT_OPTIONS="compose:menu"
export XDG_SESSION_TYPE=wayland
# export XDG_RUNTIME_DIR=/run/user/$(id -u)/
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
export CLUTTER_BACKEND=wayland
# export QT_QPA_PLATFORM=wayland-egl
# export ECORE_EVAS_ENGINE=wayland-egl
# export ELM_ENGINE=wayland_egl
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1
# systemd-cat --identifier=sway sway $@

export GDK_BACKEND=wayland,x11

# export XDG_SESSION_TYPE=x11
# export GDK_BACKEND=x11
export MOZ_USE_XINPUT2=1  # Enable touch scrolling on firefox


# if [ -n "$BASH_VERSION" -a -e "$HOME/.bashrc" ]; then
#     source "$HOME/.bashrc"
# fi

# Autostart X on login, but only if system has just booted, to avoid loops
if [ "$(tty)" == '/dev/tty1' -a $(awk '{print int($1)}' /proc/uptime) -le 60 ]; then
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        exec river
        # exec sway
        # exec dbus-run-session gnome-session
    else
        [ -f "/usr/bin/startx" -a -z "$DISPLAY$SSH_TTY$(pgrep xinit)" ] && exec /usr/bin/startx
    fi
fi
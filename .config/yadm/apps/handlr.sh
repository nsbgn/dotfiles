# Source: https://github.com/Anomalocaridid/handlr-regex
# Alpine: https://pkgs.alpinelinux.org/package/edge/community/x86_64/handlr

DIR="$HOME/.local/bin"
BIN="$DIR/handlr"

if [ ! -f "$BIN" ]; then
    # URL="$(curl -sfL 
    # 'https://api.github.com/repos/Anomalocaridid/handlr-regex/releases/latest' 
    # | jq -r 'first(.assets[] | .browser_download_url)')"
    # wget -O ~/.local/bin/handlr "$URL"
    # chmod +x ~/.local/bin/handlr
    cargo install handlr-regex
fi

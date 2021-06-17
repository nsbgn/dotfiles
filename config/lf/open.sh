#!/bin/bash
# Open a file. `xdg-open` and `mailcap` are too much hassle.

# Test if we are running within an X session; if so, fork the process and
# redirect the output so the terminal is available for other tasks.
function gui {
    if xset q &>/dev/null; then
        ("$@" > /dev/null 2>&1 ) &
    else
        "$@"
    fi
}

LIBRETRO="/usr/lib/x86_64-linux-gnu/libretro"

[ -z "${1:-}" ] && exit 1

F="${1}"
case $(file --dereference --mime-type "$F" -b):"${F,,}" in
    *.gpg|*.vim)
        nvim "$F" ;;
    *.xoj|*.xopp)
        xournalpp "$F" ;;
    inode/directory:*) 
        lf "$F" ;;
    inode/x-empty:*) 
        nvim "$F" ;;
    text/html:*) 
        gui firefox "$F" ;;
    text/*) 
        nvim "$F" ;;
    video/*) 
        gui mpv --no-terminal "$F" ;; # use --vo=gpu --gpu-context=drm if no X server
    audio/midi:*) 
        timidity "$F" ;;
    audio/*) 
        mpv --no-audio-display "$F" ;;
    image/*) 
        # gui mirage "$F" ;; #gui sxiv -a "$F" "$(dirname "$F")"
        # --geometry 1000x1000 \
        feh \
            --borderless \
            --scale-down \
            --image-bg '#ffffee' \
            --caption-path '.' \
            --font 'Anonymous Pro/13' \
            --fontpath '/usr/share/fonts/truetype/anonymous-pro/' \
            --draw-tinted \
            --draw-filename \
            --draw-actions \
            --info "exiv2 %F | grep -v ':\s*$'; echo Size: %w×%h - %Sb; echo -n Modification:; date -r %F '+%%Y-%%m-%%d %%R'" \
            --auto-rotate \
            --edit \
            --sort filename \
            --start-at "$F" \
            --action1 '[rename]zenity --entry --text "Rename:" --entry-text %F | xargs mv %F' \
            --action9 '[remove]zenity --question && gio trash %F' \
            "$(dirname "$F")"
        ;;
    application/epub+zip:*) 
        gui mupdf -r 70 "$F" ;; #epr "$F" within terminal
    application/zip:*) 
        gui xdg-open "$F" ;;
    application/zip:*.cbz) 
        gui zathura "$F" ;;
    application/x-rar:*.cbr) 
        gui zathura "$F" ;;
    application/x-rar:*.cbr) 
        gui xdg-open "$F" ;;
    application/pdf:*) 
        gui zathura "$F" ;;
        #gui mupdf "$F" ;;
    message/rfc822:*) 
        gui kmail --view "$F" ;;
    application/x-wii-rom:*|application/x-gamecube-rom:*) 
        gui dolphin-emu --exec="$F" ;;
    application/x-gba-rom:*|application/x-gameboy-rom:*) 
        gui retroarch -L "$LIBRETRO/mgba_libretro.so" "$F" ;;
    application/x-n64-rom:*) 
        gui retroarch -L "$LIBRETRO/mupen64plus_libretro.so" "$F" ;;
    application/x-nintendo-ds-rom:*)
        gui retroarch -L "$LIBRETRO/desmume_libretro.so" "$F" ;;
    application/x-nes-rom:*) 
        gui retroarch -L "$LIBRETRO/nestopia_libretro.so" "$F" ;;
    *.smc|*.sfc)
        gui retroarch -L "$LIBRETRO/bsnes_mercury_balanced_libretro.so" "$F" ;;
    *.zim) 
        gui kiwix-desktop "$F" ;;
    *.mts) 
        gui mpv "$F" ;;
    *) 
        echo "Falling back to xdg-open..." >&2
        gui xdg-open "$F" ;;
esac


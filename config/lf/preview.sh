#!/bin/sh
# Shows a text preview of a file.

F="$1"
EXT="$(echo "${F##*.}" | tr '[:upper:]' '[:lower:]' )"
case "$EXT" in
    md|mkd)
        sed 's/\ $//g' "$F" | lowdown -Tterm --term-shortlinks --term-width=50;;
        # glow "$F" --style light;;
    epub) unzip -p "$F" "$(zipinfo -1 "$F" | grep .opf$)" \
            | xmlstarlet sel \
            -N dc="http://purl.org/dc/elements/1.1/" \
            -N opf="http://www.idpf.org/2007/opf" -T -t \
            -m '/opf:package/opf:metadata' \
            -o 'Title: ' -v 'dc:title' -n \
            -o 'Author: ' -v 'dc:creator' -n \
            -o 'Publisher: ' -v 'dc:publisher' -n \
            -o 'Subject: ' -v 'dc:subject' -n \
            -n -v 'dc:description' -n \
            | sed 's/<[^>]*>//g' \
            | lowdown -Tterm
        ;;
    a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rpm|rz|\
    t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip) atool --list -- "$F";;
    rar) unrar lt -p- -- "$F";;
    7z) 7z l -p -- "$F";;
    htm|html|xhtml) elinks -dump "$F";;
    odt|ods|odp|sxw) odt2txt "$F" | fmt --width=72;;
    docx) docx2txt < "$F" | fmt --width=72;;
    doc) catdoc "$F" | fmt --width=72;;
    pdf) pdftotext -l 10 -nopgbrk "$F" - | fmt --width=72;;
    torrent) transmission-show "$F";;
    jpg|jpeg|gif|png|tiff|bmp|svg)
        #/usr/bin/w3m -o 'ext_image_viewer=off' "$F";;
        chafa --work=1 --symbols=block --fill=block --stretch --colors=256 --size "$(expr $(tput cols) \* 2 / 5)x" "$F";;
        #exiftool "$F" ;;
    mkv|mp4|mka|mp3|mp4|wav|flac|webm) 
        exiftool "$F"
        #ffmpegthumbnailer -q0 -i "$F" -o - -c png -f \
        #    | chafa  --work=1 --symbols=block --fill=block --stretch --colors=256 --size "$(expr $(tput cols) \* 2 / 5)x" -
        ;;
    gpg)
        gpg --quiet --decrypt "$F" | bat --style=plain --italic-text=always --decorations=always --color=always ;;
    *)
        if [ "$(file --brief --mime-encoding "$F")" = "binary" ]; then
            hexyl --length 768 "$F"
        else
            bat --theme=OneHalfLight --style=plain --italic-text=always --decorations=always --color=always "$F"
        fi
        ;;
esac

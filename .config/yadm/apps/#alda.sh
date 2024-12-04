#!/bin/bash
# Text-based music composition
# https://github.com/alda-lang/alda
#
# See also: https://github.com/ccrma/chuck (in Debian)
# See also: https://gitlab.com/lilypond/lilypond (in Debian)

set -euo pipefail

wget -P ~/.local/bin/ "$( \
    curl -s 'https://api.github.com/repos/alda-lang/alda/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | select(endswith("alda")))'\
)"
chmod +x ~/.local/bin/alda

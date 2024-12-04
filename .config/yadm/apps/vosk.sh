#!/bin/sh
# Vosk - Speech recognition
# https://alphacephei.com/vosk/
#
# See also:
# - https://fosspost.org/open-source-speech-recognition/
# - https://openai.com/research/whisper
# - https://github.com/julius-speech/julius
# - http://kaldi-asr.org/
# - https://github.com/athena-team/athena
# - https://espnet.github.io/espnet/
# - https://styletts2.github.io/

set -e

if ! which vosk-transcriber; then
    pipx install vosk
    MODEL=vosk-model-en-us-0.22-lgraph
    TMPDIR="$(mktemp -d /tmp/vosk-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    curl -fLo "$TMPDIR/$MODEL.zip" "https://alphacephei.com/vosk/models/$MODEL.zip"
    unzip "$TMPDIR/$MODEL.zip" -d "$HOME/.cache"
else
    echo "Vosk is already installed." >&2
fi

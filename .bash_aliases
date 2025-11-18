
alias d="docker"
alias dc="docker compose"

# cf. <https://unix.stackexchange.com/questions/4219/how-do-i-get-bash-completion-for-command-aliases>
source /usr/share/bash-completion/completions/docker
complete -F _docker d
complete -F _docker dc

# alias sudo="doas"
alias dp="swaymsg -t send_tick doublepaned"
alias thumb="gm convert cover.* -resize 96x96! -quality 65% folder.jpg"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias t="nvim $HOME/notes/todo/todo.md"
alias u="sudo apt update; sudo apt upgrade"
#alias c="kalk_cli"
alias c="calcurse"
alias fin="ledger --market balance ^assets ^liabilities"
alias trash="gio trash"
alias trash-more="srm -l"
alias ledger="ledger --strict -f $LEDGER"
alias ls="ls --color=always"
alias du="ncdu"
alias yt="yt-dlp --embed-metadata --embed-subs --embed-thumbnail"
alias yt-sub="yt-dlp --all-subs --convert-subs srt --skip-download"
alias yt-audio="yt-dlp -f 'ba[acodec=opus]' -S +size"
alias flac2mp3="parallel ffmpeg -i {} -qscale:a 2 {.}.mp3 ::: ./*.flac"
alias rss="newsboat -r -u <(gojq --yaml-input -r '.content[].rss // empty' $HOME/notes/web/*.yaml)"
alias vosk="vosk-transcriber -m $HOME/.cache/vosk-model-en-us-0.22-lgraph"

# https://www.techspeak.dev/2019/01/14/improve-your-git-flow-with-fuzzy-find.html
alias gfzf="git ls-files -m -o --exclude-standard | fzf --print0 -m -1 | xargs -0 -t -o"

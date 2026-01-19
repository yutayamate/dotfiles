typeset -g MUSIC_INFO_MSG=""
typeset -g MUSIC_INFO_PID=""

function music_info_async() {
    [[ -n $MUSIC_INFO_PID ]] && kill -0 $MUSIC_INFO_PID 2>/dev/null && return

    (
        local track=""
        if pgrep -x "Music" >/dev/null 2>&1; then
            track=$(osascript <<'EOF' 2>/dev/null
                tell application "Music"
                    if player state is playing then
                        return name of current track
                    end if
                end tell
EOF
            )
        fi

        if [[ -n $track ]]; then
            MUSIC_INFO_MSG="[♫:${track}]"
        else
            MUSIC_INFO_MSG=""
        fi
        zle reset-prompt 2>/dev/null
    ) &

    MUSIC_INFO_PID=$!
}

function music_info_precmd() {
    music_info_msg=$MUSIC_INFO_MSG
}

add-zsh-hook precmd music_info_precmd
add-zsh-hook precmd music_info_async

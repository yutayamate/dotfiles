function music_info() {
    local _track_name
    music_info_msg=
    if [[ $(pgrep -f Music.app) ]]; then
        _track_name=$(
            command -v osascript > /dev/null 2>&1 && \
            osascript -e '''
                try
                    tell application "Music" to get name of current track
                end try
            '''
        )
    fi
    if [[ -n $_track_name ]]; then
        music_info_msg="[♫:$_track_name]"
    fi
}

add-zsh-hook precmd music_info

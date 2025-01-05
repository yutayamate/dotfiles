function music_info() {
    local _track_name
    music_info_msg=
    _track_name=$(
        command -v osascript > /dev/null 2>&1 && \
        osascript \
            -e 'if application "Music" is running then' \
            -e 'try' \
            -e 'tell application "Music" to get name of current track' \
            -e 'end try' \
            -e 'end if'
    )
    if [[ -n $_track_name ]]; then
        music_info_msg="[♫:$_track_name]"
    fi
}

add-zsh-hook precmd music_info

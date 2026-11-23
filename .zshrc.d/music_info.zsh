function music_info() {
    # Refresh at most once every five seconds, keeping the previous message.
    if (( ${+_music_info_last_refresh} && SECONDS - _music_info_last_refresh < 5 )); then
        return 0
    fi
    typeset -g _music_info_last_refresh=$SECONDS
    local _track_name
    music_info_msg=
    command -v osascript > /dev/null 2>&1 || return
    if pgrep -x "Music" > /dev/null 2>&1; then
        _track_name=$(
            osascript <<'EOF' 2>/dev/null
                tell application "Music"
                    if player state is playing then
                        return name of current track
                    end if
                end tell
EOF
        )
    fi
    if [[ -n $_track_name ]]; then
        music_info_msg="[♫:$_track_name]"
    fi
}

add-zsh-hook precmd music_info

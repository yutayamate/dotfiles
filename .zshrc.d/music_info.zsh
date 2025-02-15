function music_info() {
    local _track_name
    music_info_msg=
    _track_name=$(
        command -v osascript > /dev/null 2>&1 && \
        osascript -e '''
            if application "Music" is running then
                try
                    tell application "Music" to get name of current track
                end try
            end if
        '''
        # osascript -l JavaScript -e '''
        #     var app = Application("Music");
        #     if (app.running()) {
        #         var track = app.currentTrack()
        #         console.log(track.name())
        #     }
        # ''' 2>&1
    )
    if [[ -n $_track_name ]]; then
        music_info_msg="[♫:$_track_name]"
    fi
}

add-zsh-hook precmd music_info

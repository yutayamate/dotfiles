function container_info() {
    # Refresh at most once every five seconds, keeping the previous message.
    if (( ${+_container_info_last_refresh} && SECONDS - _container_info_last_refresh < 5 )); then
        return 0
    fi
    typeset -g _container_info_last_refresh=$SECONDS
    container_info_msg=
    if pgrep -f podman-machine > /dev/null 2>&1; then
        container_info_msg+="[podman:running]"
    fi
}

add-zsh-hook precmd container_info

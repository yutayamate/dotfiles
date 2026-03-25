function container_info() {
    container_info_msg=
    if pgrep -f podman-machine >/dev/null 2>&1; then
        container_info_msg+="[podman:running]"
    fi
}

add-zsh-hook precmd container_info

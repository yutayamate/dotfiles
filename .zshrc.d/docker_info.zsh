function docker_info() {
    docker_info_msg=
    if pgrep -x podman-machine >/dev/null 2>&1; then
        docker_info_msg+="[podman:running]"
    fi
}

add-zsh-hook precmd docker_info

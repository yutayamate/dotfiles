function docker_info() {
    docker_info_msg=
    if [[ $(pgrep -f podman-machine) ]]; then
        docker_info_msg+="[podman:running]"
    fi
}

add-zsh-hook precmd docker_info

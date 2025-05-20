function docker_info() {
    docker_info_msg=
    if [[ -e $HOME/.colima/default/docker.sock ]]; then
        docker_info_msg+="[colima:running]"
    fi
    if [[ -e $HOME/.orbstack/run/docker.sock ]]; then
        docker_info_msg+="[orbstack:running]"
    fi
}

add-zsh-hook precmd docker_info

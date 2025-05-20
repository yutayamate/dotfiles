function colima_info() {
    colima_info_msg=
    if [[ -e $HOME/.colima/default/docker.sock ]]; then
        colima_info_msg="[colima:running]"
    fi
}

add-zsh-hook precmd colima_info

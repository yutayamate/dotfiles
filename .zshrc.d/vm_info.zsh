function vm_info() {
    # Refresh at most once every five seconds, keeping the previous message.
    if (( ${+_vm_info_last_refresh} && SECONDS - _vm_info_last_refresh < 5 )); then
        return 0
    fi
    typeset -g _vm_info_last_refresh=$SECONDS
    vm_info_msg=
    if pgrep -f vmware-vmx > /dev/null 2>&1; then
        vm_info_msg+="[vmware:running]"
    fi
}

add-zsh-hook precmd vm_info

function vm_info() {
    vm_info_msg=
    if pgrep -f vmware-vmx > /dev/null 2>&1; then
        vm_info_msg+="[vmware:running]"
    fi
}

add-zsh-hook precmd vm_info

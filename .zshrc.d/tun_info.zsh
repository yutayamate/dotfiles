function tun_info() {
    local _addr_num
    tun_info_msg=
    if ifconfig | grep -A2 -E '^(u?tun|wg)[0-9]' | grep -qE 'inet [0-9]+\.'; then
        tun_info_msg="[tun:enabled]"
    fi
}

add-zsh-hook precmd tun_info

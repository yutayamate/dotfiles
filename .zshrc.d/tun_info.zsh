function tun_info() {
    local _addr_num
    tun_info_msg=
    _addr_num=$(
        ifconfig | \
        grep -E '^(tun|utun)[0-9]+' -A2 | \
        awk '{ if (NR % 3) ORS=","; else ORS="\n"; print; }' | \
        grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}' | \
        wc -l
    )
    if [[ $_addr_num -gt 0 ]]; then
        tun_info_msg="[tun:enabled]"
    fi
}

add-zsh-hook precmd tun_info

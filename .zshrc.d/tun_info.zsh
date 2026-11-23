function tun_info() {
    # Refresh at most once every five seconds, keeping the previous message.
    if (( ${+_tun_info_last_refresh} && SECONDS - _tun_info_last_refresh < 5 )); then
        return 0
    fi
    typeset -g _tun_info_last_refresh=$SECONDS
    tun_info_msg=
    if ifconfig | grep -A3 -E '^(u?tun|wg)[0-9]' | grep -qE 'inet [0-9]+\.'; then
        tun_info_msg="[tun:enabled]"
    fi
}

add-zsh-hook precmd tun_info

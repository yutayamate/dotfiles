export LANG=en_US.UTF-8
export EDITOR=nano
export PAGER=less

typeset -U path
typeset -U fpath
path=(
    ~/.cargo/(s|)bin(N-/)
    ~/.opt/*/(s|)bin(N-/)
    ~/.local/(s|)bin(N-/)
    ~/.(s|)bin(N-/)
    /snap/(s|)bin(N-/)
    /opt/homebrew/opt/*/(s|)bin(N-/)
    /opt/homebrew/(s|)bin(N-/)
    /usr/local/opt/*/(s|)bin(N-/)
    /usr/local/*/(s|)bin(N-/)
    /usr/local/(s|)bin(N-/)
    /opt/*/(s|)bin(N-/)
    /usr/(s|)bin(N-/)
    /(s|)bin(N-/)
    $path
)
fpath=(
    /opt/homebrew/share/zsh/site-functions(N-/)
    /usr/local/share/zsh/site-functions(N-/)
    $fpath
)

setopt always_to_end
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt correct
setopt correct_all
setopt extended_history
setopt glob_subst
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt interactive_comments
setopt list_packed
setopt list_rows_first
setopt list_types
setopt magic_equal_subst
setopt no_nomatch
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history
setopt transient_rprompt

autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz select-word-style && select-word-style bash
autoload -Uz vcs_info && add-zsh-hook precmd vcs_info

bindkey -e
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

zstyle ":completion:*:default" menu select=2
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"
zstyle ":vcs_info:*" formats "[%b]"
zstyle ":vcs_info:*" actionformats "[%b|%a]"
zstyle ":vcs_info:git:*" check-for-changes false

add-zsh-hook precmd tun_info() {
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

if [[ -n $SSH_CONNECTION ]]; then
    prompt fade red && setopt prompt_sp
else
    prompt fade blue && setopt prompt_sp
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
RPS1='%F{yellow}${vcs_info_msg_0_}${tun_info_msg}'

alias grep="grep --color=auto"
alias cargo-binstall-get='mkdir -p ~/.cargo/bin && curl -L --proto "=https" --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash && source ~/.zshrc'
case "$OSTYPE" in
    darwin*)
        alias ls="ls -G"
        # alias tar="COPYFILE_DISABLE=1 tar"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac

command -v sheldon > /dev/null 2>&1 && eval "$(sheldon source)" && source <(sheldon completions --shell zsh)
command -v mise > /dev/null 2>&1 && eval "$(mise activate zsh)" && source <(mise completions zsh)
command -v fzf > /dev/null 2>&1 && export FZF_DEFAULT_OPTS="--reverse"
command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh)
command -v vctl > /dev/null 2>&1 && [ $(uname -m) = "amd64" ] && source <(vctl completion zsh) && compdef _vctl vctl
command -v minikube > /dev/null 2>&1 && source <(minikube completion zsh)
command -v pomerium-cli > /dev/null 2>&1 && source <(pomerium-cli completion zsh) && compdef _pomerium-cli pomerium-cli
command -v syft > /dev/null 2>&1 && source <(syft completion zsh) && compdef _syft syft
command -v grype > /dev/null 2>&1 && source <(grype completion zsh) && compdef _grype grype
command -v trivy > /dev/null 2>&1 && source <(trivy completion zsh)
command -v gobuster > /dev/null 2>&1 && source <(gobuster completion zsh) && compdef _gobuster gobuster
command -v roc > /dev/null 2>&1 && source <(roc completion zsh) && compdef _roc roc
if [[ -z $SSH_CONNECTION && $TERM_PROGRAM != "vscode" ]]; then
  command -v zellij > /dev/null 2>&1 && export ZELLIJ_AUTO_ATTACH=true && export ZELLIJ_AUTO_EXIT=true && eval "$(zellij setup --generate-auto-start zsh)"
fi

test -e ~/.zshrc.local && source ~/.zshrc.local

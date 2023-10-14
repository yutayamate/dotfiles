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

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz select-word-style && select-word-style bash
autoload -Uz vcs_info && precmd () { vcs_info }

bindkey -e
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

zstyle ":completion:*:default" menu select=2
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"
zstyle ":vcs_info:*" formats "[%b]"
zstyle ":vcs_info:*" actionformats "[%b|%a]"
zstyle ":vcs_info:git:*" check-for-changes false

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

alias grep="grep --color=auto"
case "$OSTYPE" in
    darwin*)
        alias ls="ls -G"
        # alias tar="COPYFILE_DISABLE=1 tar"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac

if [[ -n $SSH_CONNECTION ]]; then
    prompt fade red && setopt prompt_sp
else
    prompt fade blue && setopt prompt_sp
fi
RPROMPT='%F{yellow}${vcs_info_msg_0_}'

alias cargo-binstall-get='curl -L --proto "=https" --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash && source ~/.zshrc'

command -v sheldon > /dev/null 2>&1 && eval "$(sheldon source)" && source <(sheldon completions --shell zsh) && compdef _sheldon sheldon
command -v xclip > /dev/null 2>&1 && alias pbcopy="xclip -selection primary" && alias pbpaste="xclip -selection primary -o"
command -v fzf > /dev/null 2>&1 && export FZF_DEFAULT_OPTS="--reverse"
command -v pyenv > /dev/null 2>&1 && eval "$(pyenv init - zsh)"
command -v rbenv > /dev/null 2>&1 && eval "$(rbenv init - zsh)"
command -v minikube > /dev/null 2>&1 && source <(minikube completion zsh)
command -v pomerium-cli > /dev/null 2>&1 && source <(pomerium-cli completion zsh) && compdef _pomerium-cli pomerium-cli
command -v syft > /dev/null 2>&1 && source <(syft completion zsh) && compdef _syft syft
command -v grype > /dev/null 2>&1 && source <(grype completion zsh) && compdef _grype grype
command -v gobuster > /dev/null 2>&1 && source <(gobuster completion zsh) && compdef _gobuster gobuster
command -v roc > /dev/null 2>&1 && source <(roc completion zsh) && compdef _roc roc

test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh
test -e ~/.zshrc.local && source ~/.zshrc.local

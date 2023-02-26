export LANG=en_US.UTF-8
export EDITOR=nano
export PAGER=less

typeset -U path
path=(
    ~/.tools/*(N-/)
    ~/.opt/*/(s|)bin(N-/)
    ~/.local/(s|)bin(N-/)
    ~/.(s|)bin(N-/)
    /opt/homebrew/opt/*/(s|)bin(N-/)
    /usr/local/opt/*/(s|)bin(N-/)
    /usr/local/(s|)bin(N-/)
    /opt/*/(s|)bin(N-/)
    /usr/(s|)bin(N-/)
    /(s|)bin(N-/)
    $path
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

ZPLUG_HOME=~/.zplug
if [[ -d $ZPLUG_HOME ]]; then
    source $ZPLUG_HOME/init.zsh
    zstyle ":zplug:tag" depth 1
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-autosuggestions"
    zplug "plugins/docker", from:oh-my-zsh
    zplug "plugins/gcloud", from:oh-my-zsh
    zplug "yutayamate/bin", as:command, use:"bin/*"
    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi
    zplug load
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
fi
alias get-zplug="git clone https://github.com/zplug/zplug $ZPLUG_HOME && source .zshrc"

command -v xclip > /dev/null 2>&1 && alias pbcopy="xclip -selection primary" && alias pbpaste="xclip -selection primary -o"
command -v fzf > /dev/null 2>&1 && export FZF_DEFAULT_OPTS="--reverse"
command -v pyenv > /dev/null 2>&1 && eval "$(pyenv init --path)" && eval "$(pyenv init -)"
command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh)
command -v minikube > /dev/null 2>&1 && source <(minikube completion zsh)
command -v pomerium-cli > /dev/null 2>&1 && source <(pomerium-cli completion zsh) && compdef _pomerium-cli pomerium-cli
command -v syft > /dev/null 2>&1 && source <(syft completion zsh) && compdef _ syft
command -v gobuster > /dev/null 2>&1 && source <(gobuster completion zsh) && compdef _gobuster gobuster
command -v roc > /dev/null 2>&1 && source <(roc completion zsh) && compdef _roc roc

test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh
test -e ~/.zshrc.local && source ~/.zshrc.local

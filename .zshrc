export LANG=en_US.UTF-8
export EDITOR=nano
export PAGER=less

typeset -U path
path=(
    ~/.tools/*(N-/)
    ~/.opt/*/(s|)bin(N-/)
    ~/.local/(s|)bin(N-/)
    ~/.(s|)bin(N-/)
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
setopt pushd_ignore_dups
setopt share_history
setopt transient_rprompt

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz select-word-style && select-word-style bash

bindkey -e
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

zstyle ":completion:*:default" menu select=2
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

alias grep="grep --color=auto"
case "$OSTYPE" in
    darwin*)
        alias ls="ls -G"
        alias tar="COPYFILE_DISABLE=1 tar" ;;
    linux*)
        alias ls="ls --color=auto" ;;
esac

if [[ -n $SSH_CONNECTION ]]; then
    prompt fade red && setopt prompt_sp
else
    prompt fade blue && setopt prompt_sp
fi

alias install_zplug="git clone https://github.com/zplug/zplug ~/.zplug && source .zshrc"
if [[ -d ~/.zplug ]]; then
    source ~/.zplug/init.zsh
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

builtin command -v fzf > /dev/null 2>&1 && export FZF_DEFAULT_OPTS='--reverse'
builtin command -v pyenv > /dev/null 2>&1 && eval "$(pyenv init --path)" && eval "$(pyenv init -)"
builtin command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh)

test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh
test -e ~/.zshrc.local && source ~/.zshrc.local

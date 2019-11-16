export LANG=en_US.UTF-8
export EDITOR=vi
export PAGER=less

typeset -U path
path=(~/.tools/*(N-/) ~/.opt/*/(s|)bin(N-/) ~/.local/(s|)bin(N-/) ~/.(s|)bin(N-/) /usr/local/sbin(N-/) $path)

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

case "$OSTYPE" in
    darwin*)
        alias ls="ls -G" ;;
    linux*)
        alias ls="ls --color=auto" ;;
esac

if [[ -n $SSH_CONNECTION ]]; then
    prompt fade red
else
    prompt fade blue
fi

if [[ -d ~/.zplug ]]; then
    source ~/.zplug/init.zsh
    zstyle ":zplug:tag" depth 1
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "docker/cli", use:contrib/completion/zsh
    zplug "docker/compose", use:contrib/completion/zsh
    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi
    zplug load
fi

builtin command -v pyenv > /dev/null 2>&1 && eval "$(pyenv init -)"
builtin command -v gcloud > /dev/null 2>&1 && source $(dirname $(command -v gcloud))/../completion.zsh.inc
builtin command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh)

test -e ~/.zshrc.local && source ~/.zshrc.local

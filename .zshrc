export LANG=en_US.UTF-8
export EDITOR=vi
export PAGER=less

typeset -U path
path=(~/opt/*/(s|)bin(N-/) ~/local/bin(N-/) ~/bin(N-/) ~/.pyenv/bin(N-/) $path)

setopt always_last_prompt
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
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt interactive_comments
setopt list_packed
setopt list_rows_first
setopt list_types
setopt magic_equal_subst
setopt pushd_ignore_dups
setopt share_history

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit

prompt fade cyan

bindkey -e
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

zstyle ":completion:*:default" menu select=2
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

case "$OSTYPE" in
    darwin*)
        alias ls="ls -G" ;;
    linux*)
        alias ls="ls --color=auto" ;;
esac
if command -v pyenv &> /dev/null; then eval "$(pyenv init -)"; fi
if command -v VBoxManage &> /dev/null; then alias startvm='(){ VBoxManage startvm $1 --type headless }'; fi

test -e ~/.zshrc.local && source ~/.zshrc.local

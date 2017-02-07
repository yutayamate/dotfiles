export LANG=ja_JP.UTF-8
export EDITOR=vi
export PAGER=less

typeset -U path
path=(~/opt/*/(s|)bin(N-/) ~/local/bin(N-/) ~/bin(N-/) ~/.nodebrew/current/bin(N-/) $path)

setopt always_to_end        # 補完の後、カーソルを末尾に移動する
setopt auto_cd              # ディレクトリ名でcdする
setopt auto_list            # TABを入力後、補完候補を表示する
setopt auto_menu            # TABで補完候補を選択する
setopt auto_param_keys      # 括弧の対応などを補完する
setopt auto_pushd           # cdでpushdする
setopt correct              # コマンドのスペルチェックを行う
setopt correct_all          # ファイル名などについてスペルチェックを行う
setopt extended_history     # ヒストリに時刻を付加する
setopt glob_subst           # コマンドライン引数を補完する
setopt hist_expand          # 補完にヒストリを利用する
setopt hist_ignore_dups     # 直前と同一のコマンドをヒストリに追加しない
setopt list_packed          # 補完候補を可能な限り詰めて表示する
setopt list_types           # 補完候補にファイルの種類を表示する
setopt list_rows_first      # 補完候補を横方向に表示する
setopt magic_equal_subst    # コマンドライン引数での"="の後ろを補完する
setopt pushd_ignore_dups    # pushdで同じディレクトリを重複してpushdしない
setopt share_history        # 他のシェルとヒストリを共有する

bindkey -e                  # Emacsライクなキーバインドを使用する
bindkey "^p" history-beginning-search-backward

autoload -U compinit; compinit                          # 補完機能を使用する
autoload -U colors; colors                              # カラーで表示する

zstyle ":completion:*:default" menu select=2            # 補完候補をハイライトし、矢印キーで選択する
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"     # 補完時に大文字と小文字を区別しない

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

PROMPT="[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[green]%}%M%{$reset_color%}:%{$fg[green]%}%y%{$reset_color%}] [%U%{$fg[yellow]%}%~%{$reset_color%}%u]"$'\n'"%# "
RPROMPT="%B(%D %*)%b"
[ -n "$SSH_CONNECTION" ] &&
    PROMPT="[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[red]%}%M%{$reset_color%}:%{$fg[red]%}%y%{$reset_color%}] [%U%{$fg[yellow]%}%~%{$reset_color%}%u]"$'\n'"%# "

if builtin which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if builtin which docker-machine > /dev/null; then eval "$(docker-machine env 2> /dev/null)"; fi
if builtin which VBoxManage > /dev/null; then alias startvm='(){ VBoxManage startvm $1 --type headless }'; fi

case "$OSTYPE" in
    darwin*)
        alias ls="ls -G" ;;
    linux*)
        alias ls="ls --color=auto" ;;
esac

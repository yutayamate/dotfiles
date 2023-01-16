all: test install

test:
install: xdg emacs git matploitlib tmux vim sqlite screen zsh

.PHONY: xdg
xdg:
	mkdir -p ${HOME}/.config

.PHONY: emacs
emacs:
	ln -snFv ${PWD}/.config/emacs ${HOME}/.config/emacs

.PHONY: git
git:
	ln -snFv ${PWD}/.config/git ${HOME}/.config/git

.PHONY: matploitlib
matploitlib:
	ln -snFv ${PWD}/.config/matplotlib ${HOME}/.config/matplotlib

.PHONY: tmux
tmux:
	ln -snFv ${PWD}/.config/tmux ${HOME}/.config/tmux

.PHONY: vim
vim:
	mkdir -p ${HOME}/.vim
	ln -snfv ${PWD}/.vim/vimrc ${HOME}/.vim/vimrc

.PHONY: sqlite
sqlite:
	ln -snfv ${PWD}/.sqliterc ${HOME}/.sqliterc

.PHONY: screen
screen:
	ln -snfv ${PWD}/.screenrc ${HOME}/.screenrc

.PHONY: zsh
zsh:
	ln -snfv ${PWD}/.zshrc ${HOME}/.zshrc

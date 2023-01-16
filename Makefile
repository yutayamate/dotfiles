XDG_CONFIG_HOME = ${HOME}/.config
.DEFAULT_GOAL := help

all: install

install: xdg emacs git matploitlib tmux ssh vim sqlite screen zsh

.PHONY: xdg
xdg:
	@mkdir -p ${XDG_CONFIG_HOME}

.PHONY: emacs
emacs:
	@ln -snFv ${PWD}/.config/emacs ${XDG_CONFIG_HOME}/emacs

.PHONY: git
git:
	@ln -snFv ${PWD}/.config/git ${XDG_CONFIG_HOME}/git

.PHONY: matploitlib
matploitlib:
	@ln -snFv ${PWD}/.config/matplotlib ${XDG_CONFIG_HOME}/matplotlib

.PHONY: tmux
tmux:
	@ln -snFv ${PWD}/.config/tmux ${XDG_CONFIG_HOME}/tmux

.PHONY: ssh
ssh:
	@mkdir -p ${HOME}/.ssh
	@ln -snfv ${PWD}/.ssh/config ${HOME}/.ssh/config

.PHONY: vim
vim:
	@mkdir -p ${HOME}/.vim
	@ln -snfv ${PWD}/.vim/vimrc ${HOME}/.vim/vimrc

.PHONY: sqlite
sqlite:
	@ln -snfv ${PWD}/.sqliterc ${HOME}/.sqliterc

.PHONY: screen
screen:
	@ln -snfv ${PWD}/.screenrc ${HOME}/.screenrc

.PHONY: zsh
zsh:
	@ln -snfv ${PWD}/.zshrc ${HOME}/.zshrc

.PHONY: help
help:
	@echo "Usage: make all | make install | make help"

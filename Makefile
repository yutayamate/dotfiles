OS := $(shell uname -s)
XDG_CONFIG_HOME ?= ${HOME}/.config
.DEFAULT_GOAL := help

all: install

install: xdg git ssh vim zsh sheldon zellij alacritty

.PHONY: xdg
xdg:
	@mkdir -p ${XDG_CONFIG_HOME}

.PHONY: emacs
emacs:
	@ln -sFinv ${PWD}/.config/emacs ${XDG_CONFIG_HOME}/emacs

.PHONY: git
git:
	@ln -sFinv ${PWD}/.config/git ${XDG_CONFIG_HOME}/git

.PHONY: tmux
tmux:
	@ln -sFinv ${PWD}/.config/tmux ${XDG_CONFIG_HOME}/tmux

.PHONY: ssh
ssh:
	@mkdir -p ${HOME}/.ssh
	@ln -sinv ${PWD}/.ssh/config ${HOME}/.ssh/config

.PHONY: vim
vim:
	@mkdir -p ${HOME}/.vim
	@ln -sinv ${PWD}/.vim/vimrc ${HOME}/.vim/vimrc

.PHONY: groovy
groovy:
	@mkdir -p ${HOME}/.groovy
	@ln -sinv ${PWD}/.groovy/groovysh.rc ${HOME}/.groovy/groovysh.rc

.PHONY: sqlite
sqlite:
	@ln -sinv ${PWD}/.sqliterc ${HOME}/.sqliterc

.PHONY: screen
screen:
	@ln -sinv ${PWD}/.screenrc ${HOME}/.screenrc

.PHONY: zsh
zsh:
	@ln -sinv ${PWD}/.zshrc ${HOME}/.zshrc

.PHONY: sheldon
sheldon:
	@ln -sFinv ${PWD}/.config/sheldon ${XDG_CONFIG_HOME}/sheldon

.PHONY: zellij
zellij:
	@ln -sFinv ${PWD}/.config/zellij ${XDG_CONFIG_HOME}/zellij

.PHONY: alacritty
alacritty:
	@ln -sFinv ${PWD}/.config/alacritty ${XDG_CONFIG_HOME}/alacritty

.PHONY: help
help:
	@echo "Usage: make all | make install | make help"

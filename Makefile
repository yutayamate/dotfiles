XDG_CONFIG_HOME ?= ${HOME}/.config
.DEFAULT_GOAL := help

all: install

install: xdg emacs git tmux ssh vim groovy sqlite screen zsh

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
	@ln -sinv ${PWD}/.zshrc ${HOME}/.zsh_plugins.txt

.PHONY: help
help:
	@echo "Usage: make all | make install | make help"

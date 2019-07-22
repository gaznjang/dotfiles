init: neovim profile bashrc tmux ssh_config gitconfig

.PHONY: neovim
neovim:
ifeq ("$(wildcard /usr/local/bin/nvim.appimage)","")
	sudo wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -O /usr/local/bin/nvim.appimage
	sudo chmod a+x /usr/local/bin/nvim.appimage
	sudo ln -sf /usr/local/bin/nvim.appimage /usr/local/bin/nvim
endif
	rm -rf ~/.config/nvim
	mkdir -p ~/.config/nvim
	ln -sf `pwd`/config/nvim/init.vim ~/.config/nvim/init.vim

.PHONY: profile
profile:
	cp ~/.profile ~/.profile.old
	ln -sf `pwd`/profile ~/.profile

.PHONY: bashrc
bashrc:
	cp ~/.bashrc ~/.bashrc.old
	ln -sf `pwd`/bashrc ~/.bashrc

.PHONY: tmux
tmux:
ifeq ("$(wildcard `pwd`/.tmux/README.md)", "")
	git submodule init
	git submodule update
	cd .tmux
	git checkout master
endif
	ln -sf `pwd`/.tmux/.tmux.conf ~/.tmux.conf
	ln -sf `pwd`/.tmux/.tmux.conf.local ~/.tmux.conf.local

.PHONY: ssh_config
ssh_config:
ifneq ("$(wildcard ~/.ssh/config)", "")
	rm ~/.ssh/config
endif
	ln -sf `pwd`/ssh_config ~/.ssh/config

.PHONY: gitconfig
gitconfig:
ifneq ("$(wildcard ~/.gitconfig)", "")
	rm ~/.gitconfig
endif
	ln -sf `pwd`/gitconfig ~/.gitconfig

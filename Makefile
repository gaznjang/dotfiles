init: base neovim profile bashrc tmux ssh_config gitconfig vim

.PHONY: base
base:
	sudo aptitude install curl
	sudo aptitude install python-pip
	sudo aptitude install python3-pip
	sudo aptitude install htop
	sudo aptitude install build-essential
	sudo aptitude install cmake
	sudo aptitude install rsync
	sudo aptitude install meld
	sudo aptitude install git

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

.PHONY: screenrc
screenrc:
ifneq ("$(wildcard ~/.screenrc)", "")
	mv ~/.screenrc ~/.screenrc.old
endif
	ln -sf `pwd`/screenrc ~/.screenrc

.PHONY: vim
vim:
ifneq ("$(wildcard ~/.vim/bundle/Vundle.vim)", "")
	rm -rf ~/.vim/bundle/Vundle.vim
endif
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	ln -sf `pwd`/vimrc.txt ~/.vimrc
	vim +PluginInstall +qall
	python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

.PHONY: dropboxd
dropboxd:
ifneq ("$(wildcard ~/.dropbox-dist/dropboxd)", "")
	rm -rf ~/.dropbox-dist/dropboxd
endif
	cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
	~/.dropbox-dist/dropboxd

.PHONY: dropbox
dropbox:
ifneq ("$(wildcard /usr/local/bin/dropbox)", "")
	sudo rm -rf /usr/local/bin/dropbox
endif
	sudo wget -O /usr/local/bin/dropbox "https://www.dropbox.com/download?dl=packages/dropbox.py"
	sudo chmod a+x /usr/local/bin/dropbox
	dropbox

.PHONY: gnote
gnote:
ifneq ("$(wildcard ~/.local/share/gnote)", "")
	rm -rf ~/.local/share/gnote
endif
	ln -s ~/Dropbox/gnote ~/.local/share/

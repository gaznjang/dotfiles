init: base neovim profile bashrc tmux ssh_config gitconfig vim ime

.PHONY: base
base:
	sudo aptitude install curl
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
	sudo wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O /usr/local/bin/nvim.appimage
	sudo chmod a+x /usr/local/bin/nvim.appimage
	sudo ln -sf /usr/local/bin/nvim.appimage /usr/local/bin/nvim
endif

.PHONY: neovim-config
neovim-config:
ifneq ("$(wildcard ~/.config/nvim)", "")
	mv ~/.config/nvim ~/.config/nvim.old
endif
	mkdir -p ~/.config/nvim
	ln -sf `pwd`/config/nvim/init.vim ~/.config/nvim/init.vim
	ln -sf `pwd`/config/nvim/local_init.vim ~/.config/nvim/local_init.vim
	ln -sf `pwd`/config/nvim/local_bundles.vim ~/.config/nvim/local_bundles.vim

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

.PHONY: consolas
consolas:
	sudo cp -r ~/Dropbox/private/consolas /usr/share/fonts/truetype/
	sudo fc-cache
	fc-list | grep consola

.PHONY: ime
ime:
	sudo aptitude install ibus-table
	sudo aptitude install ibus-chewing

.PHONY: dayi3
dayi3:
	ibus-table-createdb -s ~/Dropbox/private/dayi3-ibus.txt -n /tmp/Dayi3.db -d
	sudo cp -v /tmp/Dayi3.db /usr/share/ibus-table/tables/
	sudo cp -v ~/Dropbox/private/Dayi.png /usr/share/ibus-table/icons/
	ibus-daemon -x -r -d
	ibus-setup

.PHONY: dict
dict:
	sudo tar xjf ~/Dropbox/books/dictionaryFiles/stardict-cdict-big5-2.4.2.tar.bz2 -C /usr/share/stardict/dic/
	sudo tar xjf ~/Dropbox/books/dictionaryFiles/stardict-cedict-big5-2.4.2.tar.bz2 -C /usr/share/stardict/dic/
	sudo tar xjf ~/Dropbox/books/dictionaryFiles/stardict-oxford-big5-2.4.2.tar.bz2 -C /usr/share/stardict/dic/
	sudo tar xjf ~/Dropbox/books/dictionaryFiles/stardict-oxford_collocations-2.4.2.tar.bz2 -C /usr/share/stardict/dic/
	sudo tar xjf ~/Dropbox/books/dictionaryFiles/stardict-xdict-ce-big5-2.4.2.tar.bz2 -C /usr/share/stardict/dic/
	sudo tar xjf ~/Dropbox/books/dictionaryFiles/stardict-xdict-ec-big5-2.4.2.tar.bz2 -C /usr/share/stardict/dic/

.PHONY: pyenv
pyenv:
	curl https://pyenv.run | bash

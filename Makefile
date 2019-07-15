init: neovim profile

.PHONY: neovim
neovim:
	mkdir -p ~/.config/nvim
	ln -sf `pwd`/config/nvim/init.vim ~/.config/nvim/init.vim

.PHONY: profile
profile:
	rm ~/.profile
	ln -sf `pwd`/profile ~/.profile

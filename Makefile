
SHELL:=/bin/bash

basics:
	sudo apt install -y vim
	sudo apt install -y tmux
	sudo apt install -y git
	sudo apt install -y stow

	stow bash
	stow tmux
	stow vim
	stow git

ssh_key:
	ssh-keygen -t ed25519 -C "zatari88@gmail.com"

git_distro_config:
	if [[ "$OSTYPE" == "linux-gnu" && "$(uname -r)" == *"Microsoft" ]]; then
		echo gitconfig for Linux on WSL
		git config --global core.autocrlf false
		git config --global core.filemode false
	elif [[ "$OSTYPE" == "linux-gnu" ]]; then
		echo gitconfig for Linux
		git config --global core.autocrlf false
		git config --global core.filemode true
	elif [[ "$OSTYPE" == "cygwin" ]]; then
		echo gitconfig for Cygwin
		git config --global core.autocrlf true
		git config --global core.filemode true
	fi

git_distro_config_windows_terminal:
	git config --global core.autocrlf false
	git config --global core.filemode false

git_distro_config_linux:
	git config --global core.autocrlf false
	git config --global core.filemode true

git_distro_config_cygwin:
	git config --global core.autocrlf true
	git config --global core.filemode true

colors:
	# clone base16-shell
	git clone https://github.com/chriskempson/base16-shell.git ~/.dotfiles/config/.config/base16-shell
	# clone base16-vim
	git clone https://github.com/chriskempson/base16-vim.git ~/.dotfiles/vim/.vim/colors/base16-vim
	# move the vim color files to the .vim color folder
	cp ~/.dotfiles/vim/.vim/colors/base16-vim/colors/*.vim ~/.dotfiles/vim/.vim/colors
	stow config
	base16_tomorrow-night

gef:
	pip3 install capstone unicorn keystone-engine ropper
	git clone https://github.com/hugsy/gef.git ~/.tools/gef
	stow gdb_gef

gef_delete:
	#including a delete isn't standard, just for switching between gef and pwndbg 
	rm -r ~/.tools/gef
	unstow gdb_gef

pwndbg:
	stow gdb_pwndbg
	git clone https://github.com/pwndbg/pwndbg.git ~/.tools/pwndbg
	cd ~/.tools/pwndbg/
	bash setup.sh

pwndbg_delete:
	#including a delete isn't standard, just for switching between pwndbg and gef
	unstow gdb_pwndbg
	rm -r ~/.tools/pwndbg

rizin: cutter
	# Current plan is to just always install cutter (the rizin GUI)
	# I probably am just going to get started with the GUI anyway, but
	# these might get broken out later?

cutter:
	#install cutter build reqs, install first to prevent failed reclone if
	#	deps cannot be found and apt update needs to be called
	sudo apt install -y build-essential
	sudo apt install -y cmake
	sudo apt install -y meson
	sudo apt install -y libzip-dev
	sudo apt install -y zlib1g-dev
	sudo apt install -y qt5-default
	#if qt5-default fails:
	#sudo apt install -y qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
	sudo apt install -y libqt5svg5-dev
	sudo apt install -y qttools5-dev
	sudo apt install -y qttools5-dev-tools
	#install optional deps
	## building with CUTTER_ENABLE_KSYNTAXHIGHLIGHTING (Default)
	sudo apt install -y libkf5syntaxhighlighting-dev
	## building with CUTTER_ENABLE_GRAPHVIZ (Default)
	sudo apt install -y libgraphviz-dev
	## building with CUTTER_ENABLE_PYTHON_BINDINGS
	#sudo apt install -y libshiboken2-dev
	#sudo apt install -y libpyside2-dev
	#sudo apt install -y qtdeclarative5-dev
	git clone --recurse-submodules https://github.com/rizinorg/cutter ~/.tools/cutter
	cd ~/.tools/cutter
	mkdir build
	cd build
	cmake ..
	cmake --build .
	echo 'export PATH=$PATH:~/.tools/cutter/build' >> ~/.bashrc

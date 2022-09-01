
SHELL:=/bin/bash

.PHONY: basics
basics: _basics colors private_variables passwords git_distro_config

.PHONY: _basics
_basics:
	sudo apt install -y vim
	sudo apt install -y tmux
	sudo apt install -y git
	sudo apt install -y stow
	sudo apt install -y taskwarrior
	stow bash
	stow tmux
	stow vim
	stow git

.PHONY: colors
colors:
	# clone base16-shell
	git clone https://github.com/chriskempson/base16-shell.git ~/.dotfiles/config/.config/base16-shell
	# clone base16-vim
	git clone https://github.com/chriskempson/base16-vim.git ~/.dotfiles/vim/.vim/colors/base16-vim
	# move the vim color files to the .vim color folder
	cp ~/.dotfiles/vim/.vim/colors/base16-vim/colors/*.vim ~/.dotfiles/vim/.vim/colors
	stow config
	base16_tomorrow-night

.PHONY: private_variables
private_variables:
	printf '# export VAR="/desired/path\"' >> ${HOME}/.private_variables

.PHONY: passwords
passwords:
	python3 -m pip install numpy
	stow passwords

ssh_key:
	ssh-keygen -t ed25519 -C "zatari88@gmail.com"

ssh_deamon:
	echo "This is untested... Hope it works!"
	sudo apt install -y openssh-server
	sudo systemctl enable ssh
	sudo systemctl enable sshd
	ssh-keygen -A
	sudo systemctl start ssh

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

apt_use_repos_over_HTTPS:
	sudo apt install -y apt-transport-https
	sudo apt install -y ca-certificates
	sudo apt install -y curl
	sudo apt install -y gnupg
	sudo apt install lsb-release

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

docker: apt_use_repos_over_HTTPS
	echo "You should probably create the prevent double invoke make system"
	# get rid of all the old bad docker stuff (not that it will be there)
	sudo apt remove docker docker-engine docker.io containerd runc
	# add docker's signing GPG key
	curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg \
	| sudo apt-key add -
	# add the docker official repos
	echo "deb [arch=$(dpkg --print-architecture)] \
	https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
	$(lsb_release -cs) stable" \
	| sudo tee /etc/apt/sources.list.d/docker.list
	sudo apt update
	sudo apt install -y --no-install-recommends docker-ce cgroupfs-mount
	sudo systemctl enable docker
	sudo systemctl start docker
	echo "Testing that Docker is running: "
	sudo docker run --rm hello-world

docker-compose: docker
	echo "You should probably create the prevent double invoke make system"
	sudo apt update
	sudo apt install -y python3-pip libffi-dev
	sudo pip3 install docker-compose

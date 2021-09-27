
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

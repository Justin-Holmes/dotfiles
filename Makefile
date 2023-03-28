brews = git ripgrep node
casks = insomnia rowanj-gitx rectangle
cocs = coc-css coc-eslint coc-html coc-json coc-go coc-lists coc-prettier coc-tsserver coc-prettier coc-tslint-plugin coc-sumneko-lua coc-solargraph coc-rust-analyzer coc-yaml
npms = @tailwindcss/language-server
dots = gitconfig vimrc zshrc
tmps = tmp/yankring
plug = https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# --------------------------------------

#/ help            Print this message (default)
help:
	@printf "%sUsage: make TARGET\n"
	@cat ./Makefile | grep '^#\/' | sed "s/#\//  /g"
	@printf "%s\nGlobal packages:\n"
	@printf "%sbrew: $(brews)\n"
	@printf "%scask: $(casks)\n"
	@printf "%scocs: $(cocs)\n"

#/ install         Installs homebrews, casks and dotfiles
install:
	sudo -v
	brew install $(brews)
	brew cask install $(casks)
	npm install -g $(npms)
	@for file in $(dots); do ln -sfv `pwd`/$$file $$HOME/.$$file; done
	@if [[ -d $$HOME/.vim ]]; then rm -rf $$HOME/.vim; fi
	@for tmp in $(tmps); do mkdir -pv $$HOME/.vim/$$tmp; done
	@ln -sfv `pwd`/coc-settings.json $$HOME/.vim/
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs $(plug)
	@printf "%s\nInstall vim plugins: :PlugInstall and :CocInstall $(cocs)"
	@printf "%s\nSetup macOS defaults: make macos\n"

#/ uninstall       Removes homebrews, casks and dotfiles
uninstall:
	sudo -v
	brew uninstall $(brews) macvim
	brew cask uninstall $(casks)
	@rm -rfv $$HOME/.vim
	@for file in $(dots); do rm -v $$HOME/.$$file; done

#/ update          Updates homebrews and casks
update:
	brew update
	@printf "%s----\n"
	brew outdated
	@printf "%s----\n"
	brew upgrade
	@printf "%s----\n"
	brew cleanup
	@printf "%s----\n"
	brew doctor
	@printf "%s----\n"
	npm update -g $(npms)
	@printf "%sUpdate vim plugins: :PlugUpgrade, :PlugUpdate, :CocUpdate\n"

.PHONY: help install uninstall update

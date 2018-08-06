#!/usr/bin/env bash

set -e

# Install brew if it doesn't already exist
command -v brew > /dev/null 2>&1  || (yes '' | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)")

# Install all things brew related
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew bundle

# Setup fish
echo "Setting up fish..."
grep -q -F '/usr/local/bin/fish' /etc/shells || echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
test $SHELL = "/usr/local/bin/fish" || chsh -s /usr/local/bin/fish

echo "Setting up fisher..."
# Install fisher
fish -c 'fisher' || curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# Stow fisher
stow fisher

# Run fisher
fish -c 'fisher'

# Change settings for fish plugins
fish -c 'set -U fish_operator " ⟩ "'

# Other stow files
stow git pep ssh vim fish

# Install vim-sensible
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
(cd ~/.vim/bundle && git clone https://github.com/tpope/vim-sensible.git)


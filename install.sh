#!/bin/zsh

set -o pipefail
set -o errexit

DOTFILES_DIR=~/.dotfiles
REPO=https://github.com/guilhermohounie/dotfiles.git


# Install xcode
if ! xcode-select -p &> /dev/null; then
    echo "Installing xcode command line tools..."
    xcode-select --install
    echo "✨ xcode command line tools are installed"
else
    echo "✨ xcode command line tools are installed"
fi

# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✨ oh-my-zsh is installed"
else
    echo "✨ oh-my-zsh is installed"
fi


# Install homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✨ homebrew is installed"
else
    echo "✨ homebrew is installed"
fi


# Install brew packages
echo "Installing brew packages..."

brew bundle --file=Brewfile

echo "✨ Brew packages installed"


# Install zsh-autosuggestions and zsh-syntax-highlighting
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "✨ zsh-autosuggestions is installed"
else
    echo "✨ zsh-autosuggestions is installed"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "✨ zsh-syntax-highlighting is installed"
else
    echo "✨ zsh-syntax-highlighting is installed"
fi

# link dotfiles to home directory
echo "Linking dotfiles to home directory..."
ln ".zshrc" ~
ln ".gitconfig" ~
ln ".hushlogin" ~
ln ".zprofile" ~
ln ".aliases" ~

# Install nodejs
if ! command -v node &> /dev/null; then
    echo "Installing nodejs..."
    asdf plugin add nodejs
    asdf install nodejs 16
    asdf global nodejs 16
    npm install --location=global yarn
    asdf reshim nodejs 16
else
    echo "✨ nodejs is installed"
fi

# Install ruby
if ! command -v ruby &> /dev/null; then
    echo "Installing ruby..."
    asdf plugin add ruby
    asdf install ruby 3.1.2
    asdf global ruby 3.1.2
    asdf reshim ruby 3.1.2
else
    echo "✨ ruby is installed"
fi

# Check if ruby version is 3.1.2
if [ "$(ruby -v)" != "ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [arm64-darwin21]" ]; then
    echo "Ruby version is not 3.1.2"
else
    echo "✨ Ruby version is 3.1.2"
    echo "Installing gems..."
    gem install rails rake bundler
fi

true

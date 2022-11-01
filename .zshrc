# Exports
export ZSH=$HOME/.oh-my-zsh
export EDITOR=code

# Paths
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
export PATH="$PATH:$HOME/.yarn/bin"

# Theme
ZSH_THEME="theunraveler"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# asdf version Manager
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Sources
source $ZSH/oh-my-zsh.sh
[[ -f ~/.aliases ]] && source ~/.aliases

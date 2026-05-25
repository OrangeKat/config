# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# OhMyPosh theme
eval "$(oh-my-posh init zsh --config '~/ohmyposh-theme.omp.json')"

# Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/thomas/go:$PATH"

# Env Variables

# zsh themes
source ~/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
export EZA_COLORS="$(vivid generate catppuccin-mocha)"
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Oh My Zsh plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
alias ls='eza --icons --color=always --group-directories-first'
alias gr='gr'
alias dcu='docker compose up'
alias dcb='docker compose build'
alias dcud='docker compose up -d'
alias de='docker exec'
alias dcd='docker compose down'
alias dcp='docker container prune'
alias dip='docker image prune'
alias dvp='docker volume prune'

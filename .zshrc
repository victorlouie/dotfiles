# .zshrc [Load when interactive]
#   - PRIORITY: 3
#   - interactive usage
#       - prompt
#       - command completion
#       - command correction
#       - command highlighting
#       - command history management
#       - command suggestion
#       - output colouring
#       - aliases
#       - functions
#       - keybindings

# Move over words with alphanumeric characters as "words"
#  man zshall - ZLE FUNCTIONS
autoload -U select-word-style
select-word-style bash

# Tab completion with arrow keys
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

export STARSHIP_CACHE=~/.starship/cache
eval "$(starship init zsh)"

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')


# User configuration

# Aliases
#
alias hc="history -c"
alias hg="history | grep "
alias list="ls -al"
alias reload="source ~/.zshrc"
alias x="exit"

# Functions
#
vscode () { 
  VSCODE_CWD="$PWD"
  /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code "$@" --new-window
}
subl() {
  SUBLIME_CWD="$PWD"          # Set the current working directory to the present working directory
  /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$@" --new-window  # Open Sublime Text with specified arguments
}

# Installed via brew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Key Bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
#bindkey "e[5~" beginning-of-history
#bindkey "e[6~" end-of-history
#bindkey "e[3~" delete-char
#bindkey "e[2~" quoted-insert
#bindkey "e[5C" forward-word
#bindkey "eOc" emacs-forward-word
#bindkey "e[5D" backward-word
#bindkey "eOd" emacs-backward-word
#bindkey "ee[C" forward-word
#bindkey "ee[D" backward-word
#bindkey "^H" backward-delete-word

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

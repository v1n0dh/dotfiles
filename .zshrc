
# Enable colors and chage prompt
autoload -U colors && colors
PS1="┌─[%{$fg[green]%}%n@%M%{$reset_color%}]-[%{$fg[blue]%}%~%{$reset_color%}]
└─ $ "

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/zsh_history

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)			# Include hidden files

# vi mode
bindkey -v

# Use vim keys in tab completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Load aliases if existent
[ -f "$HOME/.config/zsh/zsh_aliases" ] && source "$HOME/.config/zsh/zsh_aliases"

# Load zsh-syntax-highlighting; should be last
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null

PATH="$PATH:/usr/sbin"
export GOPATH=~/go
PATH="$PATH:$GOPATH/bin"

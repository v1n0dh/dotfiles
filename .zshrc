# Enable colors and chage prompt
autoload -U colors && colors
#PS1="[%B%F{green}%n@%M%f%b %B%F{blue}%1~%f%b] $ "
PS1="%F{cyan}[%n@%M%{$reset_color%} %F{blue}%1~%{$reset_color%}%F{cyan}]%# %{$reset_color%}"

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
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null

export LC_COLLATE="C"
export PATH="${PATH}":"${HOME}"/.bin

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias lls='ls -lah'
alias grep='grep --color=auto'
alias vim='nvim'
alias emacs='emacs -q --load ~/.emacs.d/init.el'
alias nnn='[ -n "$TMUX" ] && nnn -dH -Pp $@ || tmux new-session -s nnn "nnn -dH -Pp \"$@\"; tmux kill-session -tnnn"'

export NNN_FIFO='/tmp/nnn.fifo'
export NNN_TERMINAL='st'
export NNN_PLUG='p:preview-tui;f:fzcd'

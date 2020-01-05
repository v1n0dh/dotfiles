#
# ~/.bashrc
#

# PS1='[\u@\h \W]\$ '
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ `id -u` == 0 ]];then
	PS1='\[\e[1;31m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]\$ '
else
	PS1='\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]\$ '
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -alF'
alias ~='cd ~'
PS1='[\u@\h \W]\$ '

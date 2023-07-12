# .bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

export EDITOR="vim"
export PATH="$HOME/.local/bin:$PATH"
PS1='[\u@\h \W] λ '

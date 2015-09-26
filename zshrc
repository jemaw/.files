source $HOME/.aliases


# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=2000
SAVEHIST=2000
setopt autocd
bindkey -e


#completion--------------------------------------------------------- 
zstyle :compinstall filename '/home/jean/.zshrc'

autoload -Uz compinit
compinit
#------------------------------------------------------------------- 

#Prompt-------------------------------------------------------------
autoload -U promptinit
promptinit

#export PS1="%~ %» "
#export PS1=" %~   [λ] "
#PROMPT='[%~]──╼ '
#PROMPT='%b──╼ '
#PROMPT=' ─── '
#PROMPT=' λ ~ '
#PROMPT=' %F{red}» %f%b'
#RPROMPT='%b%B%F{black}%~ %B%F{white}%#'
#PROMPT="%{$fg[black]%(! $fg[red] )-$fg[black]%(1j $fg[green] )-$fg[black]%(?  $fg[red])-$reset_color%} "
PROMPT="%{$fg_bold[yellow]%} »  "
#RPROMPT="%{$fg[black]%}%M:%{$fg_bold[yellow]%}%~%{$reset_color%}   "
RPROMPT="%{$fg[red]%}%(?  ━)%{$reset_color%}"
 #Color command correction promt
#autoload -U colors && colors
#export SPROMPT="$fg[cyan]Correct $fg[red]%R$reset_color $fg[magenta]to $fg[green]%r?$reset_color ($fg[white]YES :: NO :: ABORT :: EDIT$fg[white])"
#---------------------------------------------------------------------


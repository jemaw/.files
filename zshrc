source $HOME/.aliases


# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

bindkey -v
export KEYTIMEOUT=1
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

#ls after cd
setopt autocd
function chpwd() {
    emulate -L zsh
    ls 
}

#syntax highlight:
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#zstyle :compinstall filename '/home/jean/.zshrc'

#completion--------------------------------------------------------- 
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
#------------------------------------------------------------------- 

# enable coloring
#autoload -U colors && colors

#Prompt{{{-------------------------------------------------------------
autoload -U promptinit
promptinit

#PROMPT=" %» "
#PROMPT="%{$fg_bold[yellow]%} »  "
#RPROMPT="%{$fg[black]%}%M:%{$fg_bold[yellow]%}%~%{$reset_color%}   "
#RPROMPT="%{$fg[red]%}%(?  ━)%{$reset_color%}"
#export PS1=" %» "
#export PS1=" %~   [λ] "
#PROMPT='[%~]──╼ '
#PROMPT='%b──╼ '
#PROMPT=' ─── '
#PROMPT=' λ '
PROMPT=' %F{white}» %f%b'
#PROMPT=' %c'
#RPROMPT='%b%B%F{black}%~ %B%F{white}%#'
#PROMPT="%{$fg[black]%(! $fg[red] )-$fg[black]%(1j $fg[green] )-$fg[black]%(?  $fg[red])-$reset_color%} "
#PROMPT="%{$fg_bold[yellow]%} »  "
#RPROMPT="%{$fg[black]%}%M:%{$fg_bold[yellow]%}%~%{$reset_color%}   "
#RPROMPT="%{$fg[red]%}%(?  ━)%{$reset_color%}"
 #Color command correction promt
#autoload -U colors && colors
#export SPROMPT="$fg[cyan]Correct $fg[red]%R$reset_color $fg[magenta]to $fg[green]%r?$reset_color ($fg[white]YES :: NO :: ABORT :: EDIT$fg[white])"
#}}}---------------------------------------------------------------------

#  functions {{{1 # 

function twitchl(){

livestreamer -p mpv $1 source
}
function twitch(){

livestreamer -p mpv http://twitch.tv/${1} source
}


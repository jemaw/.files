source $HOME/.aliases

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

#completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select

zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2


#Prompt 
autoload -U promptinit
#PROMPT=" %» "
#PROMPT='%~ ── '
#PROMPT='%b──╼ '
PROMPT=' %─── '
#PROMPT=' λ '
#PROMPT=' %F{white}» %f%b'
#PROMPT=' %F{white}» %f%b'
#RPROMPT='%b%B%F{black}%~ %B%F{white}%#'
#PROMPT="%{$fg[black]%(! $fg[red] )-$fg[black]%(1j $fg[green] )-$fg[black]%(?  $fg[red])-$reset_color%} "
#PROMPT="%{$fg_bold[yellow]%} »  "
#RPROMPT="%{$fg[red]%}%(?  ━)%{$reset_color%}"
 #Color command correction promt

#functions 
function twitchl(){

livestreamer -p mpv $1 source
}
function twitch(){

livestreamer -p mpv http://twitch.tv/${1} source
}

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

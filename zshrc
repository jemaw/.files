source $HOME/.aliases
export KEYTIMEOUT=4
setopt autocd \
	correct

autoload -Uz edit-command-line compinit
zmodload zsh/complist
zle -N edit-command-line

# history {{{ 

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# }}}

# completion {{{
compinit
# Some verbosity for completions
zstyle ':completion:*:options' list-colors '=^(-- *)=34'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*' group-name

# Style.
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# }}}

# bindkeys {{{

#vim mode
bindkey -v

# Open in editor.
bindkey -M vicmd 'v' edit-command-line

#}}}

# Prompt {{{  
autoload -U promptinit
#PROMPT=" %» "
#PROMPT='%~ ── '
#PROMPT='%b──╼ '
#PROMPT=' %─── '
#PROMPT=' λ '
#PROMPT=' %F{white}» %f%b'
PROMPT=' %F{white}» %f%b'
RPROMPT='%b%B%F{black}%~' #' %B%F{white}%#'
#PROMPT="%{$fg[black]%(! $fg[red] )-$fg[black]%(1j $fg[green] )-$fg[black]%(?  $fg[red])-$reset_color%} "
#PROMPT="%{$fg_bold[yellow]%} » "
#RPROMPT="%{$fg[red]%}%(?  ━)%{$reset_color%}"

# }}}

# functions {{{ 
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

function chpwd() {
    emulate -L zsh
    ls 
}
# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim: fdm=marker:fdl=0

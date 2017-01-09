source $HOME/.aliases
export KEYTIMEOUT=1
setopt autocd \
	correct \
	prompt_subst \
    histignoredups  \
	transient_rprompt # rprompt only current prompt

autoload -Uz edit-command-line compinit vcs_info promptinit
zmodload zsh/complist
zle -N edit-command-line


# zgen {{{

# install zgen
if [[ ! -d "${HOME}/.zgen" ]]; then
    echo -n "cloning and sourcing github.com/tarjoilija/zgen.git (y/n)? "
    read answer
    if echo "$answer" | grep -iq "^y" ; then
        git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
    fi
fi

if [[ -d "${HOME}/.zgen" ]]; then

source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    # bulk load
    zgen loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    zgen load zsh-users/zsh-completions src
    zgen load bazelbuild/bazel scripts/zsh_completion/

    # save all to init script
    zgen save
fi


# plugin configuration:

# zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
typeset -g HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=white,bold'
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'

# zsh-users/zsh-autosuggestions
# bindkey '^ ' autosuggest-accept

fi

# }}}

# completion {{{
compinit
# Some verbosity for completions
zstyle ':completion:*:options' list-colors '=^(-- *)=34'
zstyle ':completion:*' verbose yes

zstyle ':completion:*:descriptions' format '%U%B%d%b%u' # shows group name
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'

zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on                     # completion caching, use rehash to clear
zstyle ':completion:*' rehash yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# }}}

# history {{{ 

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# }}}

# bindkeys {{{

# history search, already done by plugin substring search
# bindkey '^[[A' up-line-or-search
# bindkey '^[[B' down-line-or-search
# bindkey '^P' up-line-or-search
# bindkey '^N' down-line-or-search

#vim mode
bindkey -v

# Open in editor.
bindkey -M vicmd 'v' edit-command-line

# Avoid Esc
bindkey -M viins 'kj' vi-cmd-mode


#}}}

# Prompt {{{  

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " %{$fg[grey]%}%{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%}"

precmd () { vcs_info }

if [[ $USER == 'root' ]]; then
  PROMPT_SIGN='#'
else
  PROMPT_SIGN='»' #>
fi

PROMPT='%F{white}${vcs_info_msg_0_} % $PROMPT_SIGN %f%b'
RPROMPT='%b%B%F{black}%~'

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

#ls after cd
# function chpwd() {
#     emulate -L zsh
#     ls 
# }
# }}}

# fzf {{{ 

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
fe() {
	IFS='
	'
	local declare files=($(fzf-tmux --query="$1" --select-1 --exit-0))
	[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
	unset IFS
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
	local dir
	dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

#}}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim: fdm=marker:fdl=0

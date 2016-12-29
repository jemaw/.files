source $HOME/.aliases
export KEYTIMEOUT=1
setopt autocd \
	correct \
	prompt_subst \
	transient_rprompt # rprompt only current prompt

autoload -Uz edit-command-line compinit vcs_info promptinit
zmodload zsh/complist
zle -N edit-command-line

# plug {{{
#really ugly, but fast
export zplugs=~/.zsh/plugins
mkdir -p $zplugs/local
fpath=( $zplugs/local "${fpath[@]}" )
pl_locals=()

function pl_load_git()
{
    if [[ -d $zplugs/$pl_git[-2] ]];then
        return 0
    fi
    git clone $pl_url $zplugs/$pl_git[-2]
}
function pl_fpath_git()
{
    fpath=( $zplugs/$pl_git[-2]/$1 "${fpath[@]}" )
}
function pl_load_wget()
{
    local filepath=$zplugs/local/$pl_url_lst[-1]

    #add to wanted local plugins
    pl_locals=($pl_url_lst[-1] $pl_locals)

    if [[ -a $filepath ]]; then
        return 0
    fi
    wget $pl_url -O $filepath

}
# $1 url,
# $2 optional for git repositories, where to find plugin
function pl_load()
{
    pl_url=$1
    pl_url_lst=(${(s:/:)pl_url})
    pl_git=(${(s:.:)pl_url_lst[-1]})

    if [[ "${pl_git[-1]}" == "git" ]];then
        pl_load_git
        pl_fpath_git $2
    else
        pl_load_wget
    fi
}
function pl_clean_locals()
{
    # get outputs of ls in array
    local files=("${(@f)$(ls $zplugs/local)}")
    # loop over all files in local
    for fil in $files; do
        # check if file is in wanted plugins
        if [[ ! ${pl_locals[(r)$fil]} == $fil ]]; then
            rm $zplugs/local/$fil
        fi
    done
}

pl_load https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
pl_load https://github.com/zsh-users/zsh-completions.git src

pl_clean_locals
# }}}

# history {{{ 

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

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
# export FZF_DEFAULT_OPTS="--exact"

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

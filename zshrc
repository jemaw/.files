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
# TODO clean everythong
# TODO update plugins
#really ugly, but fast
export zplugs=~/.zsh/plugins
mkdir -p $zplugs/local
fpath=( $zplugs/local "${fpath[@]}" )
pl_locals=()

function pl_load_git()
{
    if [[ -d $pl_folder ]];then
        return 0
    fi
    git clone $1 $pl_folder
}

function pl_fpath_git()
{
    fpath=( ${pl_folder}/$1 "${fpath[@]}" )
}

# $1 url
# $2 filepath
function pl_load_wget()
{
    local url=$1
    local filepath=$2

    #add to wanted local plugins
    pl_locals=($pl_url_lst[-1] $pl_locals)

    if [[ -a $filepath ]]; then
        return 0
    fi
    wget $url -P $pl_folder
}

# $1 url or git repository
function pl_load()
{
    pl_url=$1
    # url_lst url split at /
    pl_url_lst=(${(s:/:)pl_url})
    # pl_git last entry of url_lst split at .
    # local pl_git=(${(s:.:)pl_url_lst[-1]})
    # if [[ "${pl_git[-1]}" == "git" ]];then
    if [[ ! "${pl_url_lst[1]}" == "https:" ]]; then
        pl_git=true
        pl_folder=${zplugs}/${pl_url_lst[-1]}
        local pl_url=https://github.com/${pl_url}.git
        pl_load_git $pl_url
    else
        pl_git=false
        pl_folder=${zplugs}/local
        local filepath=${pl_folder}/$pl_url_lst[-1]
        pl_load_wget $pl_url $filepath
    fi
}

function pl_source_plug()
{
    source ${pl_folder}/$1
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

# clone plugins and source specific file
function plug()
{
    # download plugin
    pl_load $1
    # source
    pl_source_plug $2
}

# clone or wget completion files and setup fpath
# $1 git repository or url
# $2 folder of completion files inside git rep (optional)
function comp()
{
    # download completion file
    pl_load $1
    # setup fpath if necessary
    if [[ ${pl_git} == true ]];then
        pl_fpath_git $2
    fi
}

# }}}
# {{{ plugins
comp https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
comp zsh-users/zsh-completions src
plug zsh-users/zsh-autosuggestions zsh-autosuggestions.plugin.zsh
    bindkey '^ ' autosuggest-accept

pl_clean_locals
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

# history {{{ 

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

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

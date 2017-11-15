source $HOME/.aliases

autoload -Uz edit-command-line compinit vcs_info promptinit
zmodload zsh/complist
zle -N edit-command-line

# cd movement {{{

# use cd -<TAB> and cd +<TAB> to navigate dir stack
setopt autocd autopushd pushdminus pushdsilent pushdtohome
DIRSTACKSIZE=5

# }}}

# history {{{ 

# no duplicates in history
setopt histignorealldups

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# }}}

# completion {{{

compinit

# enable menu completion
zstyle ':completion:*' menu select

# option colors
zstyle ':completion:*:options' list-colors '=^(-- *)=34'
# verbose Output
zstyle ':completion:*' verbose yes

# group completion candidates in groups (example no<TAB>)
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' # shows group name
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'

# completion caching for speedup
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes

# kill completions
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER --forest -o pid,%cpu,tty,cputime,cmd'
# show kill completion even when there is only one match
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

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
# Time in ms to wait for sequences
KEYTIMEOUT=30


#}}}

# prompt {{{

# command substitution (needed for vcs prompt)
setopt prompt_subst
# rprompt only current prompt
setopt transient_rprompt

zstyle ':vcs_info:*' enable git svn
# zstyle ':vcs_info:git*' formats " %{$fg[grey]%}%{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%}"
zstyle ':vcs_info:git*' formats " %b%m%u%c% "
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'

PROMPT_SIGN='»'

precmd () { vcs_info }
# PROMPT='%F{white}${vcs_info_msg_0_} % $PROMPT_SIGN %f%b'
PROMPT='${vcs_info_msg_0_} % $PROMPT_SIGN %f%b'
RPROMPT='%b%B%F{black}%~'

# }}}

# termite colorscheme {{{

if [ $TERM = "xterm-termite" ]
then
    if [ $(readlink -f $HOME/.config/termite/config) = $HOME/.files/termite/.config/termite/config_light ]
    then
        export TERM_BG=light
    else 
        export TERM_BG=dark
    fi
fi

# }}}

# global aliases {{{

# Automatically Expanding Global Aliases (Space key to expand)
# references: http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html 
globalias() {
  if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
    zle _expand_alias
    zle expand-word
  fi
  zle self-insert
}
zle -N globalias
bindkey " " globalias                 # space key to expand globalalias
bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches

# global aliases
alias -g T='| tail'
alias -g G='| grep'
alias -g C='| wc -l'
alias -g L='| less'

# }}}

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
        zsh-users/zsh-autosuggestions
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
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=fg,bold'
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'

# zsh-users/zsh-autosuggestions
bindkey '^ '  autosuggest-accept      # accept on ctrl space
bindkey '^J'  autosuggest-execute     # execute on c-j

fi

# }}}

# functions {{{ 
switch () {
    ln -sf "$HOME/.config/termite/config_$1" "$HOME/.config/termite/config"
    killall -USR1 termite
    export TERM_BG=$1
}

extract () {
    local remove_archive
    local success
    local file_name
    local extract_dir
    if (( $# == 0 ))
    then
        echo "Usage: extract [-option] [file ...]"
        echo
        echo Options:
        echo "    -r, --remove    Remove archive."
        echo
        echo "Report bugs to <sorin.ionescu@gmail.com>."
    fi
    remove_archive=1 
    if [[ "$1" = "-r" ]] || [[ "$1" = "--remove" ]]
    then
        remove_archive=0 
        shift
    fi
    while (( $# > 0 ))
    do
        if [[ ! -f "$1" ]]
        then
            echo "extract: '$1' is not a valid file" >&2
            shift
            continue
        fi
        success=0 
        file_name="$( basename "$1" )" 
        extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )" 
        case "$1" in
            (*.tar.gz|*.tgz) tar xvzf "$1" ;;
            (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
            (*.tar.xz|*.txz) tar --xz --help &> /dev/null && tar --xz -xvf "$1" || xzcat "$1" | tar xvf - ;;
            (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null && tar --lzma -xvf "$1" || lzcat "$1" | tar xvf - ;;
            (*.tar) tar xvf "$1" ;;
            (*.gz) gunzip "$1" ;;
            (*.bz2) bunzip2 "$1" ;;
            (*.xz) unxz "$1" ;;
            (*.lzma) unlzma "$1" ;;
            (*.Z) uncompress "$1" ;;
            (*.zip|*.war|*.jar) unzip "$1" -d $extract_dir ;;
            (*.rar) unrar x -ad "$1" ;;
            (*.7z) 7za x "$1" ;;
            (*.deb) mkdir -p "$extract_dir/control"
                mkdir -p "$extract_dir/data"
                cd "$extract_dir"
                ar vx "../${1}" > /dev/null
                cd control
                tar xzvf ../control.tar.gz
                cd ../data
                tar xzvf ../data.tar.gz
                cd ..
                rm *.tar.gz debian-binary
                cd .. ;;
            (*) echo "extract: '$1' cannot be extracted" >&2
                success=1  ;;
        esac
        (( success = $success > 0 ? $success : $? ))
        (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
        shift
    done
}

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

# }}}

# fasd {{{
if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="$HOME/.zgen/fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
fi

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

# fe [FUZZY PATTERN] - Open the selected file with the default editor
dtf() {
    cd ~/.files
    IFS='
    '
    local declare files=($(fzf-tmux --query="$1" --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
    unset IFS
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-$HOME} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
    local dir
    dir=$(find ${1:-$HOME} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

v() {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}

unalias z
z() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

#}}}

# skim {{{

# fe [FUZZY PATTERN] - Open the selected file with the default editor
ke() {
    ${EDITOR:-vim} $(find ${1:-.} -type f 2> /dev/null | sk -m) && cd "$dir"
}

# fd - cd to selected directory
kd() {
  local dir
  dir=$(find ${1:-$HOME} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | sk -m) &&
  cd "$dir"
}

# fda - including hidden directories
kda() {
    local dir
    dir=$(find ${1:-$HOME} -type d 2> /dev/null | sk -m) && cd "$dir"
}

#}}}

# vim: fdm=marker:fdl=0

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

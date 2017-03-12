source $HOME/.aliases
export KEYTIMEOUT=1
setopt autocd \
	prompt_subst \
    histignorealldups  \
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

# functions {{{ 

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

#ls after cd
# function chpwd() {
#     emulate -L zsh
#     ls 
# }
# }}}

# fasd {{{
if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache=".zgen/fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache

  alias v="f -e $EDITOR"
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

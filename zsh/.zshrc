source $HOME/.aliases

autoload -Uz edit-command-line compinit vcs_info promptinit
zmodload zsh/complist
zle -N edit-command-line

export EDITOR='nvim'

# Paths {{{

#go
export GOPATH=$HOME/Projects/go
export GOROOT=/usr/local/go

#rust
#export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
#export CARGO_BIN="$HOME/.cargo/bin"

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path gopath

# Cuda
grep "Ubuntu" /etc/issue -i -q
if [ $? = '0' ];
then
	export CUDA_HOME='/usr/local/cuda'
    export CUDNN_HOME=$CUDA_HOME
else
	export CUDA_HOME='/opt/cuda'
    export CUDNN_HOME=$CUDA_HOME
fi

# ld_library_path
export TENSORRT_PATH=$HOME/Packages/TensorRT-7.2.3.4/lib
export CUBLAS_PATH=/usr/lib/x86_64-linux-gnu
export CUPTI_PATH=$CUDA_HOME/extras/CUPTI/lib64
export LD_LIBRARY_PATH=$CUDNN_HOME/lib64:$CUDA_HOME/lib64:$TENSORRT_PATH:$CUBLAS_PATH:$CUPTI_PATH:$LD_LIBRARY_PATH:/usr/local/cuda-11.1/lib64

# ml virtual env
export ML_ENV='/mnt/data/virtualenvs/ml'

# spark
export SPARK_BIN='/opt/apache-spark/bin'

# Set the list of directories that Zsh searches for programs.
path=(
		~/bin
        ~/.local/bin
		/usr/local/{bin,sbin}
		$path
		$CUDA_HOME/bin
		$GOPATH/bin
        $GOROOT/bin
        $SPARK_BIN
)

# }}}

# cd movement {{{

# use cd -<TAB> and cd +<TAB> to navigate dir stack
setopt autocd autopushd pushdminus pushdsilent pushdtohome
DIRSTACKSIZE=5

# }}}

# history {{{ 

# no duplicates in history
setopt histignorealldups
setopt INC_APPEND_HISTORY

HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=100000

# }}}

# completion {{{

compinit

# file paths are copmleted for command line arguments if there is an = in front: command -option=./file/..
setopt magicequalsubst

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
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

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
RPROMPT='%~'

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
if [ $TERM = "alacritty" ]
then
    if [ $(readlink -f $HOME/.config/alacritty/alacritty.yml) = $HOME/.files/alacritty/.config/alacritty/light.yml ]
    then
        export TERM_BG=light
    else 
        export TERM_BG=dark
    fi
fi


if [ $TERM = "xterm-256color" ]
then
    if [ $(readlink -f $HOME/.config/alacritty/alacritty.yml) = $HOME/.config/dotfiles/alacritty/.config/alacritty/light.yml ]
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

# install zgenom
if [[ ! -d "${HOME}/.zgenom" ]]; then
    echo -n "cloning and sourcing github.com/jandamm/zgenom.git (y/n)? "
    read answer
    if echo "$answer" | grep -iq "^y" ; then
        git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
    fi
fi

if [[ -d "${HOME}/.zgenom" ]]; then

source "${HOME}/.zgenom/zgenom.zsh"

# if the init scipt doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    zgenom load zsh-users/zsh-history-substring-search
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load mafredri/zsh-async

    # completions
    zgenom load zsh-users/zsh-completions src
    # zgen load bazelbuild/bazel scripts/zsh_completion/
    # zgen load esc/conda-zsh-completion 
    # save all to init script
    zgenom save
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
bindkey '^ '  autosuggest-execute
bindkey '^J'  autosuggest-execute

fi

# }}}

# functions {{{ 
switch () {
    ln -sf "$HOME/.config/termite/config_$1" "$HOME/.config/termite/config"
    ln -sf "$HOME/.config/alacritty/$1.yml" "$HOME/.config/alacritty/alacritty.yml"
    # killall -USR1 termite
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
  dir=$(find ${1} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
    local dir
    dir=$(find ${1} -type d 2> /dev/null | fzf +m) && cd "$dir"
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

export PATH="$HOME/.poetry/bin:$PATH"

# vim: fdm=marker:fdl=0
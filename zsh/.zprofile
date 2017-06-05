# Browser
export BROWSER=firefox

# Editors
export EDITOR='nvim'
export VISUAL='vim'
export PAGER='less'

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Paths {{{

#go
export GOPATH=$HOME/Prog/go

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path gopath

# Cuda
grep "Ubuntu" /etc/issue -i -q
if [ $? = '0' ];
then
	export CUDA_HOME='/usr/local/cuda'
else
	export CUDA_HOME='/opt/cuda'
fi

# ld_library_path
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# Set the list of directories that Zsh searches for programs.
path=(
		~/bin/
		/usr/local/{bin,sbin}
		$path
		$CUDA_HOME/bin
		$GOPATH/bin
)

# }}}

# Less {{{

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# }}}

# Temporary Files

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# vim: fdm=marker:fdl=0

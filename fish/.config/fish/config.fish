# Variables
set PATH ~/bin ~/.local/bin /usr/local/bin $PATH
set LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH

# Aliases

# programs
alias vi=nvim
alias ra=ranger-cd

# python
alias py=python3
alias py2=python2
alias tf=python3.6


# arch
alias pacu="sudo pacman -Syu"
alias paci="sudo pacman -S" 

# ls
alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -la'

# git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gp='git push'
alias glog='git log --decorate --graph --oneline'


# configs
alias vconf="nvim ~/.config/nvim/init.vim"
alias aconf="nvim ~/.config/awesome/rc.lua"
alias zconf="nvim ~/.zshrc"

alias q=exit


# functions
function ranger-cd -w 'ranger' -d 'Automatically change the directory in fish after closing ranger'
    set -l tempfile (mktemp -t tmp.XXXXXX)

    ranger --choosedir=$tempfile $argv

    if [ -f $tempfile ]
        cd (cat $tempfile)
    end
    rm -f $tempfile
end

function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
    bind -M insert -m default jk backward-char force-repaint
    bind -M insert -m default kj backward-char force-repaint
    bind -M insert -k nul accept-autosuggestion execute
end
set -g fish_key_bindings fish_hybrid_key_bindings


# vim: fdm=marker:fdl=0

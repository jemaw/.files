#!/bin/bash
#
# Small shell script that creates symlinks for config files
#

set -e

defaultdots=(awesome ranger nvim vim zsh aliases vimperator qutebrowser)
TARGETDIR="$HOME"

main(){
    while [[ $# -gt 0 ]]
    do
        key="$1"
        case $key in
            -h|--help)
                usage
                exit 0
                ;;
            -t|--target)
                setTargetDir "$2"
                shift
                ;;
            *)
                addToDots "$1"
                ;;
        esac
        shift
    done

    # use defaults if nothing else is provided
    if [ ${#dots[@]} -eq 0 ]; then
        dots=(${defaultdots[*]})
    fi

    info
    install
}

usage(){
    echo "Usage: ./worstinstallscript2.sh [Options] args [Folders]"
    echo "Options:"
    echo -e "\t -h --help         Display help message"
    echo -e "\t -t --target arg   Change Targetdirectory (Default: \$HOME)"
    echo "Folders (Default specified in defaultdots array at the beginning of the script)"
    echo -e "\t vim         Folder containing vim config"
    echo -e "\t zsh         Folder containing zsh config"
    echo -e "\t ..."
}

setTargetDir(){
    if [ ! -d "$1" ]; then
        echo "$1" does not exist
        exit 0
    else
        TARGETDIR="$1"
    fi
}

addToDots(){
    local folder=$PWD/$1
    if [ -e "$folder" ] ; then
        dots+=($1)
    else
        echo "Unknown option or folder $1, ignoring."
    fi
}

info(){
    echo ""
    echo "Chosen Configs: ${dots[*]}"
    echo "Target Directory: $TARGETDIR"
    echo ""
}

remove() {
    local targetfile=$1
    while true; do
        read -rp "File already exists: $targetfile, overwrite? [Y/n] " yn
        case $yn in
            [Nn]* ) break;;
            * ) rm "$targetfile"; echo "Removed: $targetfile"; break;;
        esac
    done
}

symlink() {
    local targetfile
    for file in "${files[@]}";do
        targetfile="$TARGETDIR/.$file"
        if [ "$(readlink "$targetfile")" == "$PWD/$file" ]; then
            echo "Correct Symlink already exists: $file"
            continue
        fi
        if [ -e "$targetfile" ] || [ -h "$targetfile" ]; then
            remove "$targetfile"
        fi
        if [ ! -e "$targetfile" ] && [ ! -h "$targetfile" ]; then
            ln -s "$PWD/$file" "$targetfile"
            echo "Symlink created: $file"
        else
            echo "Skipping: $file"
        fi
    done
}

makesubdirs() {
    local targetdir
    local targetfile
    for file in "${files[@]}";do
        targetfile="$TARGETDIR/.$file"
        targetdir=$(dirname "$targetfile")
        mkdir -p "$targetdir"
    done
}

install(){
    for dot in "${dots[@]}";do
        cd "$dot"
        echo "$dot"
        files=($(find * -type f) $(find * -type l))
        makesubdirs
        symlink
        cd ..
        echo ""
    done
}

main "$@"

#!/bin/bash
set -e

dots=(zsh aliases vimperator)
TARGETDIR="$HOME"

remove() {
    local targetfile=$1
    while true; do
        read -rp "$targetfile - already exists, overwrite? [y]es/[n]o " yn
        case $yn in
            [Yy]* ) rm "$targetfile"; echo "$targetfile removed."; break;;
            [Nn]* ) echo "$targetfile not removed"; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done	
}

symlink() {
    local targetfile
    for file in "${files[@]}";do
        targetfile="$TARGETDIR/.$file" 
        if [ -e "$targetfile" ] || [ -h "$targetfile" ]; then
            remove "$targetfile"
        fi
        if [ ! -e "$targetfile" ] && [ ! -h "$targetfile" ]; then
            ln -s "$PWD/$file" "$targetfile"
            echo "$targetfile symlink created"
        else
            echo "$targetfile skipping"
        fi
        echo "-------------------------------------"
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

for dot in "${dots[@]}";do
    pushd "$dot"
    files=($(find * -type f) $(find * -type l))
    makesubdirs
    symlink
    popd
done

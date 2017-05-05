#!/bin/bash

# worstinstallscript2 creates symlinks for config files
# use the dots array below to specify which configurations should be installed
# for every folder in the dots array the script first creates 
# the same directory structure  (with a prepended .) in the TRGETDIR
# and then symlinks all files

set -e

dots=(awesome nvim vim zsh aliases vimperator qutebrowser)
TARGETDIR="$HOME"

remove() {
    local targetfile=$1
    basename "$targetfile"
    while true; do
        read -rp "$targetfile - already exists, overwrite? [Y/n] " yn
        case $yn in
            [Nn]* ) echo "$targetfile not removed"; break;;
            * ) rm "$targetfile"; echo "$targetfile removed."; break;;
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
    cd "$dot"
    files=($(find * -type f) $(find * -type l))
    makesubdirs
    symlink
    cd ..
done

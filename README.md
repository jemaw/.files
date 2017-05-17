# Dotfiles
Personal configuration files for my linux systems.

## Installation
Installation is done by creating symlinks to the configuration files.
The small helper script `worstinstallscript2.sh` by default creates all symlinks in the `$HOME` directory and preserves the directory structure. However you can also install to a different location, example:
```
mkdir test
./worsinstallscript2.sh -t test
```
This should create hidden symlinks for most configuration files, but you can also just install specific configs:
```
./worsinstallscript2.sh -t test zsh vim
```
This should only create symlinks for the zsh and vim configuration.
For more options check out `./worstinstallscript.sh -h`

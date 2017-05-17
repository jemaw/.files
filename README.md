# Installation
Installation is done by creating symlinks to the configuration files.
This can either be done manually or by using the provided `install` script which by default creates all symlinks in the `$HOME` directory and preserves the directory structure.
However you can also install to a different location, example:
```
mkdir test
./install -t test
```
This should create hidden symlinks for most configuration files, but you can also just install specific configs:
```
./install -t test zsh vim
```
This should only create symlinks for the zsh and vim configuration.
For more options check out `./install -h`

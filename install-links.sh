#!/bin/bash
SRC_DIR=$(cd $(dirname $(readlink -e $BASH_SOURCE))/; pwd)

function do_install 
{
    src=$SRC_DIR/$1
    dst=$HOME/$2

    mkdir -p `dirname $dst` > /dev/null

    if [ -e $dst ]; then
        mv $dst ${dst}.backup
    fi
    ln -fs $src $dst
    echo "$src -> $dst"
}

do_install vim/dot.vimrc .vimrc
do_install vim/vim/colors .vim/colors
do_install bash/dot.bashrc .bashr

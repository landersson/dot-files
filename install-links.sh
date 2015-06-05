#!/bin/bash
SRC_DIR=$(cd $(dirname $(readlink -e $BASH_SOURCE))/; pwd)
echo $SRC_DIR

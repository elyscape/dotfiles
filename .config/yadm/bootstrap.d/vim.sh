#!/usr/bin/env bash

set -euo pipefail

if ! hash vim 2>/dev/null ||
	[[ -f ~/.vim/autoload/plug.vim ]]; then
	exit
fi

echo 'Bootstrapping Vim'

curl -fsSLo ~/.vim/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim '+PlugUpdate' '+qall' 2>/dev/null

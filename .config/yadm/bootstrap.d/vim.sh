#!/usr/bin/env bash

set -euo pipefail

if ! hash vim &>/dev/null || [[ -f "${HOME}/.vim/autoload/plug.vim" ]]; then
	exit
fi

echo 'Bootstrapping Vim'

curl -fsSL \
	-o "${HOME}/.vim/autoload/plug.vim" \
	--create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim '+PlugUpdate' '+qall' &>/dev/null <<< ''

#!/usr/bin/env bash
# shellcheck disable=SC1091

shopt -s histappend

export HISTCONTROL='ignoreboth'
export HISTTIMEFORMAT='%F %T | '

export HISTSIZE='-1'

if [[ -r /etc/bashrc ]]; then
	source /etc/bashrc
fi

shopt -s \
	checkhash \
	globstar \
	no_empty_cmd_completion

set -o ignoreeof

# Allow forward history search with ^S
if [[ "$-" == *i* ]]; then
	stty -ixon
fi

if [[ -r "${HOME}/.bashrc.os" ]]; then
	source "${HOME}/.bashrc.os"
fi

if [[ -r "${HOME}/.bashrc.local" ]]; then
	source "${HOME}/.bashrc.local"
fi

if [[ -r "${HOME}/.aliases" ]]; then
	source "${HOME}/.aliases"
fi

unset BASH_COMPLETION_DISABLE

if [[ -d "${HOME}/bin" ]]; then
	export PATH="${HOME}/bin${PATH+:$PATH}"
fi

#!/usr/bin/env bash
# shellcheck disable=SC1091

source "${HOME}/.bashrc"

if [[ -r "${HOME}/.bash_profile.local" ]]; then
	source "${HOME}/.bash_profile.local"
fi

export EDITOR='vim'

if [[ "$(id -u)" -ne 0 ]]; then
	if hash gvimf &>/dev/null; then
		EDITOR='gvimf'
	elif hash gvim &>/dev/null; then
		EDITOR='gvim -f'
	fi
fi

if [[ -x /usr/bin/dircolors && -r "${HOME}/.dircolors" ]]; then
	eval "$(dircolors -b "${HOME}/.dircolors")" || eval "$(dircolors -b)"
fi

# bash-preexec goes here
# preexec() { printf '\033]0;%s@%s:%s — %s\007' "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}" "${1}" ; }
# precmd() { printf '\033]0;%s@%s:%s — %s\007' "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}" "${0}" ; }

if [[ -r "${HOME}/.iterm2_shell_integration.bash" ]]; then
	. "${HOME}/.iterm2_shell_integration.bash"
fi

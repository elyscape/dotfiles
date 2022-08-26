#!/usr/bin/env bash
# shellcheck disable=SC1091

if [[ -r "${HOME}/.bash_logout.local" ]]; then
	source "${HOME}/.bash_logout.local"
fi

# Clear the terminal title on logout/ssh disconnect
printf '\033]0;\007'

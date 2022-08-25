#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -s)" != 'Darwin' ]]; then
	exit
fi

ITERM_DIR="${HOME}/.iterm2"
PREFS_PATH="$(defaults read com.googlecode.iterm2 PrefsCustomFolder || true)"

if [[ -d "$ITERM_DIR" && "$PREFS_PATH" = "$ITERM_DIR" ]]; then
	exit
fi

echo 'Bootstrapping iTerm'

if [[ ! -d "$ITERM_DIR" ]]; then
	curl -fsSL \
		'https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh' \
		| bash
fi

if [[ "$PREFS_PATH" != "$ITERM_DIR" ]]; then
	defaults write com.googlecode.iterm2 PrefsCustomFolder "${HOME}/.iterm2"
fi

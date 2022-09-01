#!/usr/bin/env bash

set -euo pipefail

cd "$HOME"

yadm submodule update --recursive --init

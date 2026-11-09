#!/bin/sh
# Apply these dotfiles from this clone. On a new Mac without a clone, use the
# one-liner in README.md instead.
set -e

if command -v chezmoi >/dev/null 2>&1; then
  chezmoi=chezmoi
else
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$bin_dir"
  elif command -v wget >/dev/null 2>&1; then
    sh -c "$(wget -qO- https://get.chezmoi.io)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
fi

# POSIX way to get this script's folder
script_dir="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
exec "$chezmoi" init --apply "--source=$script_dir"

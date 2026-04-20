#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.gx"
PLUGIN_FILE="gx.plugin.zsh"
SOURCE_LINE="source \"$INSTALL_DIR/$PLUGIN_FILE\""

# Resolve the directory this script lives in so it works from any cwd
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing gx to $INSTALL_DIR ..."

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_DIR/$PLUGIN_FILE" "$INSTALL_DIR/$PLUGIN_FILE"

for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
  if [[ -f "$rc" ]] && ! grep -qF "$SOURCE_LINE" "$rc"; then
    echo "$SOURCE_LINE" >> "$rc"
    echo "  Added source line to $rc"
  fi
done

echo "Done. Restart your shell or run:"
echo "  source \"$INSTALL_DIR/$PLUGIN_FILE\""

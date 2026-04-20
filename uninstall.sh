#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.gx"
PLUGIN_FILE="gx.plugin.zsh"
SOURCE_LINE="source \"$INSTALL_DIR/$PLUGIN_FILE\""

echo "Uninstalling gx ..."

if [[ -d "$INSTALL_DIR" ]]; then
  rm -rf "$INSTALL_DIR"
  echo "  Removed $INSTALL_DIR"
fi

for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
  if [[ -f "$rc" ]] && grep -qF "$SOURCE_LINE" "$rc"; then
    grep -vF "$SOURCE_LINE" "$rc" > "$rc.gx_tmp" && mv "$rc.gx_tmp" "$rc"
    echo "  Removed source line from $rc"
  fi
done

echo "Done. Restart your shell to complete the uninstall."

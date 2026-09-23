#!/usr/bin/env bash
#
# Symlink this repo's Ghostty config into place on a new machine.
# Existing files are backed up to <file>.bak-<timestamp> before linking.
#
# Usage: ./install.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

APP_SUPPORT="$HOME/Library/Application Support/com.mitchellh.ghostty"
XDG_CONFIG="$HOME/.config/ghostty"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  backing up existing $dst -> $dst.bak-$STAMP"
    mv "$dst" "$dst.bak-$STAMP"
  fi
  ln -sfn "$src" "$dst"
  echo "  linked $dst"
}

echo "Installing Ghostty config from $REPO_DIR"

# Standardize on this repo's "config" filename. Back up an existing
# "config.ghostty" so it cannot shadow or conflict with the linked config.
LEGACY="$APP_SUPPORT/config.ghostty"
if [ -e "$LEGACY" ] && [ ! -L "$LEGACY" ]; then
  echo "  moving stray $LEGACY -> $LEGACY.bak-$STAMP"
  mv "$LEGACY" "$LEGACY.bak-$STAMP"
fi

# ~/.config/ghostty/config
link "$REPO_DIR/dot-config-ghostty/config" "$XDG_CONFIG/config"

# App Support: main config + shaders (config references shaders/ relatively,
# so the shaders dir must sit next to it)
link "$REPO_DIR/app-support/config"  "$APP_SUPPORT/config"
link "$REPO_DIR/app-support/shaders" "$APP_SUPPORT/shaders"

GHOSTTY="$(command -v ghostty || true)"
if [ -z "$GHOSTTY" ] && [ -x /Applications/Ghostty.app/Contents/MacOS/ghostty ]; then
  GHOSTTY=/Applications/Ghostty.app/Contents/MacOS/ghostty
fi
if [ -n "$GHOSTTY" ]; then
  # Validate this repo's files on their own: the included cmux.conf carries cmux-only
  # keys (sidebar-font-size, ...) that plain Ghostty reports as unknown fields.
  "$GHOSTTY" +validate-config --config-file="$REPO_DIR/dot-config-ghostty/config"
  "$GHOSTTY" +validate-config --config-file="$REPO_DIR/app-support/config"
  echo "Ghostty configuration validated."
else
  echo "Ghostty is not installed yet; run ghostty +validate-config after installing it."
fi

echo "Done. Reload Ghostty with ⌘ + ⇧ + , (or restart it)."

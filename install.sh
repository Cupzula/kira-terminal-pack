#!/bin/bash

# =============================
# ☁️ KIRA Online Bootstrap Script
# =============================
# Install or update KIRA Premium Mode from GitHub

INSTALL_DIR="$HOME/.config/kira"
SCRIPT_FILE="$INSTALL_DIR/kira_greet.sh"
REPO_URL="https://github.com/Cupzula/kira-terminal-pack.git"

mkdir -p "$INSTALL_DIR"

if [ -d "$INSTALL_DIR/.git" ]; then
  echo "🔄 Updating KIRA from GitHub..."
  git -C "$INSTALL_DIR" pull --quiet
else
  echo "⬇️  Cloning KIRA repo..."
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

chmod +x "$SCRIPT_FILE"
echo "✅ KIRA Premium Mode ready at: $SCRIPT_FILE"
echo "📌 Add to ~/.zshrc if missing:"
echo "[ -f \"$SCRIPT_FILE\" ] && source \"$SCRIPT_FILE\""

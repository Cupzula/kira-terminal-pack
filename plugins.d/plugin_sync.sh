# kira_plugin_sync.sh — Pull latest plugin scripts from GitHub repo
# Usage: kira plugin sync

kira_plugin_sync() {
  local PLUGIN_REPO="https://raw.githubusercontent.com/Cupzula/kira-terminal-pack/main/plugins.d"
  local PLUGIN_DIR="$HOME/.config/kira/plugins.d"

  echo "🔄 Syncing KIRA plugins from $PLUGIN_REPO..."

  mkdir -p "$PLUGIN_DIR"
  for plugin in weather.sh mood.sh syslog.sh example_plugins.sh; do
    curl -sSf "$PLUGIN_REPO/$plugin" -o "$PLUGIN_DIR/$plugin" \
      && echo "✅ Pulled $plugin"
  done

  echo "📦 Re-sourcing plugins..."
  source "$HOME/.config/kira/plugin_loader.sh"

  echo "🎉 Plugin sync complete. Run kira_plugin_help to see what’s available."
}

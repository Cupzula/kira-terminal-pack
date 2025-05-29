# kira_plugin_loader.sh — Automatically load all KIRA plugin scripts
# Drop this into kira_greet.sh or source it in install.sh

KIRA_PLUGIN_DIR="$HOME/.config/kira/plugins.d"

if [ -d "$KIRA_PLUGIN_DIR" ]; then
  for plugin in "$KIRA_PLUGIN_DIR"/*.sh; do
    [ -f "$plugin" ] && source "$plugin" && echo "🔌 Loaded plugin: $(basename "$plugin")"
  done
else
  mkdir -p "$KIRA_PLUGIN_DIR"
  echo "📁 Created plugin directory: $KIRA_PLUGIN_DIR"
fi


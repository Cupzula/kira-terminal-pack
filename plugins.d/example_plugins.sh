# 🔌 Example Plugin: kira weather (fake data, API-ready structure)
kira_weather() {
  echo "🌦️  Current forecast: 66°F, light rain, syslogs 80% saturated."
}

# 🔌 Example Plugin: kira mood (AI-powered vibe check)
kira_mood() {
  local message="My logs are clean, my deps are pinned, and life is good."
  echo "🧘 Mood: $message"
}

# 🔌 Example Plugin: kira syslog (tail syslog for macOS/Linux)
kira_syslog() {
  echo "📜 Tailing recent syslog entries (10 lines)..."
  if command -v log &>/dev/null; then
    log show --style syslog --last 1m | tail -n 10
  else
    sudo tail -n 10 /var/log/syslog
  fi
}

# Optional command help entries
kira_plugin_help() {
  echo "\n📦 Plugin Commands Available:"
  echo "  kira weather   – Show fake weather for terminal mood"
  echo "  kira mood      – Report KIRA's current operational vibe"
  echo "  kira syslog    – Tail system log (last 1m)"
}

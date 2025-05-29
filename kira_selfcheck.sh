#!/bin/bash

# kira_selfcheck.sh — Diagnose your terminal’s readiness for KIRA Premium Mode
# Drop in ~/.config/kira/kira_selfcheck.sh and source from kira_greet.sh or call with: kira self-check

kira_selfcheck() {
  echo "🔍 Running KIRA system self-check..."
  echo

  # Shell info
  echo "🌀 Shell: $SHELL"

  # OS info
  echo -n "🧠 OS: "
  uname -a

  # Check memory
  echo -n "🧮 Memory: "
  free -h 2>/dev/null || vm_stat | awk '/free/ {printf "%.1f GB\n", $3 * 4096 / 1024 / 1024 / 1024}'

  # cowsay & fortune
  for cmd in cowsay fortune jq curl; do
    if ! command -v $cmd &>/dev/null; then
      echo "❌ $cmd not found. Run: brew install $cmd"
    else
      echo "✅ $cmd found"
    fi
  done

  # AI key check
  if [ -z "$OPENAI_API_KEY" ]; then
    echo "❌ OPENAI_API_KEY not set. Export in ~/.zshrc or ~/.config/kira/.env"
  else
    echo "✅ OPENAI_API_KEY is set"
    echo -n "🌐 Testing OpenAI API... "
    local check=$(curl -s https://api.openai.com/v1/models \
      -H "Authorization: Bearer $OPENAI_API_KEY" | jq -r '.data[0].id' 2>/dev/null)
    if [[ "$check" == *"gpt"* ]]; then
      echo "✅ OK"
    else
      echo "❌ Failed to reach OpenAI API"
    fi
  fi

  echo
  echo "🧯 Done. If you're seeing ❌, patch it up and rerun this with: kira self-check"
}

# Optional CLI bind:
#   self-check)
#     kira_selfcheck
#     ;;

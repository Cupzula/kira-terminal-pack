#!/bin/bash

# kira_ai.sh — AI-enhanced shell assistant powered by OpenAI
# Drop this in ~/.config/kira/kira_ai.sh
# Requires: curl, jq, OPENAI_API_KEY env var

kira_ai() {
  if [ -z "$OPENAI_API_KEY" ]; then
    echo "❌ OPENAI_API_KEY is not set. Export it to use kira ai."
    return 1
  fi

  local task="$1"
  shift
  local prompt="$*"

  if [ -z "$task" ] || [ -z "$prompt" ]; then
    echo "Usage: kira ai [summarize|alias|explain] <text>"
    return 1
  fi

  local system_prompt=""

  case "$task" in
    summarize)
      system_prompt="Summarize the following shell log or text snippet:"
      ;;
    alias)
      system_prompt="Suggest a shell alias for this command description:"
      ;;
    explain)
      system_prompt="Explain the following shell command in plain English:"
      ;;
    *)
      echo "Unsupported task. Use summarize, alias, or explain."
      return 1
      ;;
  esac

  local request_body=$(jq -n \
    --arg prompt "$system_prompt $prompt" \
    '{model: "gpt-3.5-turbo", messages: [{role: "user", content: $prompt}], temperature: 0.7}')

  local response=$(curl -s https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$request_body")

  echo "$response" | jq -r '.choices[0].message.content' 2>/dev/null
}



# Add to kira()
#   ai)
#     shift
#     kira_ai "$@"
#     ;;

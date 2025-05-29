#!/bin/bash

# ================================
# 💻 KIRA Premium Mode Script Pack
# ================================
# A sassy, smart, and feature-rich terminal assistant

INSTALL_DIR="$HOME/.config/kira"
SCRIPT_FILE="$INSTALL_DIR/kira_greet.sh"
REPO_URL="https://github.com/Cupzula/kira-terminal-pack.git"  # Change to your repo

mkdir -p "$INSTALL_DIR"

# ------------------------------
# 🔄 Update or install from repo
# ------------------------------
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "🔄 Updating KIRA from GitHub..."
  git -C "$INSTALL_DIR" pull
else
  echo "⬇️  Cloning KIRA repo..."
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

# ------------------------------
# 🛠️ Deploy main script
# ------------------------------
cat > "$SCRIPT_FILE" << 'EOF'
#!/bin/bash

# ---------- kira_greet(): automatic shell greeting ----------
kira_greet() {
  hour=$(date +%H)
  if [ "$hour" -lt 5 ]; then
    echo -e "\033[1;35m🌌 Whoa there, hacker owl—shouldn't you be asleep?\033[0m"
  elif [ "$hour" -lt 12 ]; then
    echo -e "\033[1;35m🌅 Good mornin’, sunshine. Time to tame some servers.\033[0m"
  elif [ "$hour" -lt 18 ]; then
    echo -e "\033[1;35m☀️  Afternoon vibes: Let’s patch some boxes and drink some coffee.\033[0m"
  else
    echo -e "\033[1;35m🌙 Evenin’, nightcrawler. Let’s break prod *gently*, yeah?\033[0m"
  fi

  greetings=(
    "💅 Well hey there, hotshot. Ready to debug like you mean it?"
    "🧰 Terminal engaged. May your scripts be clean and your logs verbose."
    "🌶️ You type fast enough to make sudo blush."
    "🔍 Let's grep the day by the logs."
    "🦄 May your pipes be tight and your syntax correct."
    "☠️ Welcome back. Root or die tryin'."
    "🌌 You’ve returned. The code spirits are watching."
    "💻 Let’s make this shell purr, sugar."
  )
  index=$(( RANDOM % ${#greetings[@]} + 1 ))
  echo -e "\033[1;36m${greetings[$index]}\033[0m"

  if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
    COWPATH=""
    for dir in \
      "$HOME/Library/Application Support/cows" \
      /opt/homebrew/share/cows \
      /usr/local/share/cows \
      $(find /opt/homebrew/Cellar/cowsay -type d -name cows 2>/dev/null); do
      if [ -d "$dir" ]; then
        COWPATH="$dir"
        break
      fi
    done

    if [ -n "$COWPATH" ]; then
      cowfile=$(ls "$COWPATH"/*.cow 2>/dev/null \
        | grep -v -E 'elephant-in-snake' \
        | sed 's#.*/##; s/\\.cow$//' \
        | awk 'BEGIN{srand();} {a[NR]=$0} END{print a[int(rand()*NR)+1]}')

      if COWPATH="$COWPATH" cowsay -f "$cowfile" "test" &>/dev/null; then
        COWPATH="$COWPATH" fortune | cowsay -f "$cowfile"
      else
        echo "(⚠️ Cowfile '$cowfile' failed—using default.)"
        fortune | cowsay
      fi
    else
      echo "(No cowfiles found. Falling back to default cow.)"
      fortune | cowsay
    fi
  else
    echo "Install 'fortune' and 'cowsay' for full sass power:"
    echo "  brew install fortune cowsay"
  fi

  tips=(
    "🔥 Use \`ssh-copy-id\` to share keys instead of pasting manually."
    "🔐 Lock down root: sudo passwd -l root"
    "📁 Use \`rsync -aP\` instead of cp for big file moves."
    "🐚 Try \`bindkey -v\` in Zsh to enable vi mode."
    "🛠️ Want to reload .zshrc? Just run: source ~/.zshrc"
  )
  echo -e "\033[0;33m💡 Tip: ${tips[$((RANDOM % ${#tips[@]}))]}\033[0m"

  if command -v brew &>/dev/null; then
    outdated=$(brew outdated | wc -l | tr -d ' ')
    if [ "$outdated" -gt 0 ]; then
      echo -e "\033[0;31m📦 $outdated Homebrew packages are outdated — run 'brew upgrade'\033[0m"
    fi
  fi
}

# ---------- kira(): on-demand CLI assistant ----------
kira() {
  echo -e "\033[1;35m💻 KIRA:\033[0m Your Knowledgeable IT Resource Assistant\n"

  if [ -z "$1" ]; then
    if command -v fzf &>/dev/null; then
      choice=$(printf "sysinfo\nnetcheck\nresmon\nhotfix\nmotd\nfortune\nhealth\n" | fzf --prompt="KIRA menu > ")
      kira "$choice"
      return
    fi
  fi

  case "$1" in
    sysinfo)
      echo "🖥️  System Info:"
      uname -a
      lsb_release -a 2>/dev/null || cat /etc/*release
      ;;
    netcheck)
      echo "🌐 Network Check:"
      ip -brief addr 2>/dev/null || ifconfig
      ping -c 3 1.1.1.1
      ;;
    resmon)
      echo "📊 Resource Monitor:"
      uptime
      free -h
      df -hT | grep -v tmpfs
      ;;
    hotfix)
      echo "🛠️  System Updates (Debian/Ubuntu):"
      sudo apt update && sudo apt upgrade -y
      ;;
    motd)
      echo "💬 Message of the Day:"
      echo "You keep scripting like that, and I’m gonna symlink my /etc/hostname to your GitHub handle."
      ;;
    fortune)
      if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
        COWPATH="$HOME/Library/Application Support/cows" fortune | cowsay
      else
        echo "Install 'fortune' and 'cowsay' to use this feature."
      fi
      ;;
    health)
      echo "🩺 Quick Health Check:"
      echo -n "Uptime: "; uptime
      echo -n "Memory: "; free -h | grep Mem
      echo -n "Disk: "; df -hT | grep -v tmpfs | head -n 2
      ;;
    help|*)
      echo -e "\nUsage: kira [sysinfo|netcheck|resmon|hotfix|motd|fortune|health]"
      ;;
  esac
}

kira_greet
EOF

chmod +x "$SCRIPT_FILE"
echo "✅ KIRA Premium Mode installed to: $SCRIPT_FILE"
echo "📌 Add the following line to your ~/.zshrc if not present:"
echo "[ -f \"$SCRIPT_FILE\" ] && source \"$SCRIPT_FILE\""

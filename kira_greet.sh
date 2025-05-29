#!/bin/bash

KIRA_VERSION="1.0.0"
INSTALL_DIR="$HOME/.config/kira"
VERSION_FILE="$INSTALL_DIR/.kira-version"
CHANGELOG_FILE="$INSTALL_DIR/.kira-changelog"

kira_greet() {
  echo "KIRA: Your Knowledgeable IT Resource Assistant"

  hour=$(date +%H)
  if [ "$hour" -lt 5 ]; then
    echo "Whoa there, hacker owl—shouldn't you be asleep?"
  elif [ "$hour" -lt 12 ]; then
    echo "Good mornin’, sunshine. Time to tame some servers."
  elif [ "$hour" -lt 18 ]; then
    echo "Afternoon vibes: Let’s patch some boxes and drink some coffee."
  else
    echo "Evenin’, nightcrawler. Let’s break prod *gently*, yeah?"
  fi

  echo ""
  echo "KIRA Version: $KIRA_VERSION"

  if [ -f "$VERSION_FILE" ]; then
    INSTALLED_VERSION=$(cat "$VERSION_FILE")
    if [ "$KIRA_VERSION" != "$INSTALLED_VERSION" ]; then
      echo ""
      echo "A new version of KIRA is available!"
      echo "Run 'kira update' to get the latest version."
    fi
  else
    echo "$KIRA_VERSION" > "$VERSION_FILE"
  fi
}

kira() {
  case "$1" in
    sysinfo)
      uname -a
      if command -v lsb_release &>/dev/null; then
        lsb_release -a
      elif [ -f /etc/os-release ]; then
        cat /etc/os-release
      elif [ "$(uname)" = "Darwin" ]; then
        sw_vers
      else
        echo "Unknown OS"
      fi
      ;;
    netcheck)
      ip -brief addr 2>/dev/null || ifconfig
      ping -c 3 1.1.1.1
      ;;
    resmon)
      uptime
      free -h 2>/dev/null || vm_stat
      df -hT 2>/dev/null || df -h
      ;;
    hotfix)
      sudo apt update && sudo apt upgrade -y
      ;;
    motd)
      echo "You keep scripting like that, and I’m gonna symlink my /etc/hostname to your GitHub handle."
      ;;
    fortune)
      if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
        fortune | cowsay
      else
        echo "'fortune' and/or 'cowsay' not installed."
      fi
      ;;
    health)
      echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
      free -h 2>/dev/null || vm_stat
      df -hT 2>/dev/null || df -h
      ;;
    update)
      git -C "$INSTALL_DIR" pull
      echo "✅ KIRA has been updated. Restart your terminal to reload."
      ;;
    version)
      echo "KIRA Version: $KIRA_VERSION"
      ;;
    changelog)
      echo "KIRA Changelog:"
      [ -f "$CHANGELOG_FILE" ] && cat "$CHANGELOG_FILE" || echo "No changelog found."
      ;;
      
    ai)
      shift
      kira_ai "$@"
      ;;
      
    self-check)
      kira_selfcheck
      ;;
      
    plugin)
      case "$2" in
        sync) kira_plugin_sync ;;
        *) echo "Usage: kira plugin sync" ;;
      esac
    ;;
    
    help)
      echo "KIRA Command Reference"
      echo "  kira sysinfo     - Show OS and kernel version"
      echo "  kira netcheck    - Show IP info and ping test"
      echo "  kira resmon      - Uptime, memory, and disk stats"
      echo "  kira hotfix      - Run system updates (Linux only)"
      echo "  kira motd        - Show Message of the Day"
      echo "  kira fortune     - Show random fortune with a cow"
      echo "  kira health      - Show system health summary"
      echo "  kira version     - Show current version"
      echo "  kira changelog   - View changelog entries"
      echo "  kira update      - Pull latest KIRA update"
      echo "  kira help        - Show this help screen"
      ;;
    *)
      echo "Usage: kira [sysinfo|netcheck|resmon|hotfix|motd|fortune|health|update|version|changelog|help]"
      ;;
  esac
}

kira_greet

[ -f "$HOME/.config/kira/plugin_loader.sh" ] && source "$HOME/.config/kira/plugin_loader.sh"

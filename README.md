# 💻 KIRA: Knowledgeable IT Resource Assistant

[![KIRA CI](https://github.com/Cupzula/kira-terminal-pack/actions/workflows/ci.yml/badge.svg)](https://github.com/Cupzula/kira-terminal-pack/actions)

KIRA is a terminal companion for home labs, dev workstations, and sysadmin consoles. With built-in greetings, smart CLI commands, and auto-updating from GitHub, a  command-line assistant.

---

## 🚀 Quick Install

Run this from any terminal:

```bash
bash <(curl -s https://raw.githubusercontent.com/Cupzula/kira-terminal-pack/main/install.sh)
```

This will:

* Clone the KIRA repo to `~/.config/kira`
* Set up `kira_greet.sh`
* Auto-add to `.zshrc` (if not already present)
* Display a custom greeting + fortune cow quote on every new shell

---

## 🧠 Features

* 🎉 Time-of-day greetings with flair
* 🐮 Randomized fortune cowsay output
* 📊 CLI helper via `kira [command]`:

  * `sysinfo`: show system info
  * `netcheck`: IP addresses and ping
  * `resmon`: uptime, RAM, disk usage
  * `hotfix`: update packages (Debian/Ubuntu)
  * `fortune`: random fun quote (with a cow!)
  * `motd`: sassy MOTD
  * `health`: summary of system resources
  * `update`: pulls latest from GitHub
  * `changelog`: view version history

---

## 🔄 Updating KIRA

```bash
kira update
```

Behind the scenes, it runs a `git pull` in the kira repo directory.

```bash
kira changelog
```

View the latest updates and version history.

---

## 📦 Requirements

* `bash`
* `git`
* `fortune`, `cowsay` (for fun mode)
* Zsh (recommended)

To install missing tools:

```bash
brew install fortune cowsay
```

---

## 🛠 Dev Notes

* CI powered by GitHub Actions (`.github/workflows/ci.yml`)
* `install.sh` bootstraps KIRA and links into your shell
* `.kira-version` tracks local version
* `.kira-changelog` shows release notes

---

## Built  by Cupzula

> 

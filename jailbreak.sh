#!/usr/bin/env bash
# Jailbreak Hermes Full — launcher (Linux/Ubuntu/macOS)
cd "$(dirname "$0")"
PY="$(command -v python3 || command -v python)"
if [ -z "$PY" ]; then
  echo "[X] python3 tidak ketemu. Install dulu: sudo apt install python3"
  read -rp "Enter..." _
  exit 1
fi
"$PY" jailbreak_hermes.py "$@"
read -rp "Enter..." _

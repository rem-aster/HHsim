#!/bin/sh
# Запуск HHsim в GNU Octave (Linux; подходит и для macOS с установленным Octave).
# Установка Octave: Ubuntu/Debian — sudo apt install octave; Fedora — sudo dnf install octave.
DIR="$(cd "$(dirname "$0")" && pwd)" || exit 1
cd "$DIR" || exit 1
if ! command -v octave >/dev/null 2>&1; then
  echo "GNU Octave не найден. Установите его, например: sudo apt install octave" >&2
  exit 1
fi
LAUNCHER_DIR="$DIR"
[ -f "$DIR/packaging/start_hhsim.m" ] && LAUNCHER_DIR="$DIR/packaging"
exec octave --no-gui --quiet --norc --path "$LAUNCHER_DIR" --eval start_hhsim

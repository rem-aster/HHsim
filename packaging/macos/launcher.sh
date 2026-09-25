#!/bin/bash
# Запуск HHsim на macOS. Нужен GNU Octave (Homebrew: brew install octave).
RES="$(cd "$(dirname "$0")/../Resources" && pwd)"
VERSION="$(cat "$RES/VERSION" 2>/dev/null)"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

find_octave() {
  if command -v octave >/dev/null 2>&1; then command -v octave; return; fi
  for f in /Applications/Octave*.app/Contents/Resources/usr/bin/octave \
           "$HOME"/Applications/Octave*.app/Contents/Resources/usr/bin/octave; do
    [ -x "$f" ] && { echo "$f"; return; }
  done
}

OCTAVE="$(find_octave)"
if [ -z "$OCTAVE" ]; then
  if command -v brew >/dev/null 2>&1; then
    ANSWER=$(osascript -e 'button returned of (display dialog "Для работы HHsim нужна свободная программа GNU Octave, но она не найдена.\n\nУстановить её сейчас через Homebrew? Откроется окно Терминала; установка займёт 5–15 минут. Когда она закончится, запустите HHsim снова." buttons {"Отмена", "Установить"} default button "Установить" with title "HHsim" with icon caution)' 2>/dev/null)
    if [ "$ANSWER" = "Установить" ]; then
      osascript -e 'tell application "Terminal" to activate' \
                -e 'tell application "Terminal" to do script "brew install octave && echo && echo \"Готово. Теперь можно запустить HHsim.\""'
    fi
  else
    ANSWER=$(osascript -e 'button returned of (display dialog "Для работы HHsim нужна свободная программа GNU Octave, но она не найдена.\n\n1. Установите Homebrew (инструкция на https://brew.sh).\n2. В Терминале выполните: brew install octave\n3. Запустите HHsim снова." buttons {"Закрыть", "Открыть brew.sh"} default button "Открыть brew.sh" with title "HHsim" with icon caution)' 2>/dev/null)
    [ "$ANSWER" = "Открыть brew.sh" ] && open "https://brew.sh/ru/"
  fi
  exit 1
fi

# Программа сохраняет файлы (положение окон и т. п.) рядом с кодом,
# поэтому запускаем её из копии в папке пользователя.
DATA="$HOME/Library/Application Support/HHsim/$VERSION"
if [ ! -f "$DATA/code/hhsim.m" ]; then
  mkdir -p "$DATA"
  cp -R "$RES/hhsim/" "$DATA/"
fi
cd "$DATA" || exit 1
exec "$OCTAVE" --no-gui --quiet --norc --eval start_hhsim

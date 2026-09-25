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
  ANSWER=$(osascript -e 'button returned of (display dialog "Для работы HHsim нужна бесплатная программа GNU Octave. Её нужно установить один раз.\n\nНажмите «Установить» — откроется окно Терминала. Если там попросят пароль, введите пароль от вашего Mac (символы при вводе не отображаются — это нормально) и нажмите Return. Если попросят «Press RETURN», нажмите Return. Установка займёт 10–20 минут.\n\nКогда в Терминале появится слово «Готово», закройте его и снова откройте HHsim." buttons {"Отмена", "Установить"} default button "Установить" with title "HHsim" with icon note)' 2>/dev/null)
  if [ "$ANSWER" = "Установить" ]; then
    SCRIPT="${TMPDIR:-/tmp}/hhsim-install-octave.command"
    cat > "$SCRIPT" <<'INSTALL'
#!/bin/bash
echo "Установка GNU Octave для HHsim..."
if ! command -v brew >/dev/null 2>&1 && [ ! -x /opt/homebrew/bin/brew ] && [ ! -x /usr/local/bin/brew ]; then
  echo "Сначала устанавливается Homebrew (менеджер программ для macOS)."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Не удалось установить Homebrew."; exit 1; }
fi
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
brew install octave || { echo "Не удалось установить Octave."; exit 1; }
echo
echo "Готово. Закройте это окно и снова откройте HHsim."
INSTALL
    chmod +x "$SCRIPT"
    open -a Terminal "$SCRIPT"
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

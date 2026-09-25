#!/bin/bash
# Запуск HHsim на macOS.
#
# HHsim работает в GNU Octave. Если Octave на компьютере нет, при первом запуске
# программа сама скачивает его (из conda-forge с помощью micromamba) в папку
# пользователя ~/Library/HHsim — без Терминала, пароля и прав администратора.
#
#   HHsim.app/Contents/MacOS/HHsim                 обычный запуск
#   HHsim.app/Contents/MacOS/HHsim --install-only  только установить Octave (для проверки в CI)

OCTAVE_VERSION="10.3"
RES="$(cd "$(dirname "$0")/../Resources" && pwd)"
VERSION="$(cat "$RES/VERSION" 2>/dev/null)"
BASE="$HOME/Library/HHsim"          # без пробелов: так надёжнее для Octave
ENV_DIR="$BASE/octave-$OCTAVE_VERSION"
LOG="$BASE/install.log"
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

INTERACTIVE=1
[ "$1" = "--install-only" ] && INTERACTIVE=0

dialog() {   # dialog "текст" "кнопка1" "кнопка2" -> печатает нажатую кнопку
  [ $INTERACTIVE = 1 ] || { echo "${3:-$2}"; return; }
  local buttons="{\"$2\"}" default="$2"
  [ -n "$3" ] && buttons="{\"$2\", \"$3\"}" && default="$3"
  osascript - "$1" <<EOF 2>/dev/null
on run argv
  button returned of (display dialog (item 1 of argv) buttons $buttons default button "$default" with title "HHsim" with icon note)
end run
EOF
}

find_octave() {
  if [ -f "$ENV_DIR/.hhsim-installed" ] && [ -x "$ENV_DIR/bin/octave" ]; then echo "$ENV_DIR/bin/octave"; return; fi
  [ -n "$HHSIM_IGNORE_SYSTEM_OCTAVE" ] && return                               # для проверки установки
  if command -v octave >/dev/null 2>&1; then command -v octave; return; fi   # например, из Homebrew
}

install_octave() {
  mkdir -p "$BASE"
  : > "$LOG"
  case "$(uname -m)" in
    arm64) PLATFORM=osx-arm64 ;;
    *)     PLATFORM=osx-64 ;;
  esac
  PLATFORM="${HHSIM_PLATFORM:-$PLATFORM}"   # для проверки на других системах
  local tmp="$BASE/tmp"
  # окружение conda нельзя переносить после установки (в файлах зашит путь),
  # поэтому ставим сразу на место, а об успехе сообщает файл-метка
  rm -rf "$tmp" "$ENV_DIR" && mkdir -p "$tmp"
  {
    echo "Скачивание micromamba ($PLATFORM)..."
    curl -fsSL --retry 3 "https://micro.mamba.pm/api/micromamba/$PLATFORM/latest" -o "$tmp/micromamba.tar.bz2" &&
    tar -xjf "$tmp/micromamba.tar.bz2" -C "$tmp" bin/micromamba &&
    echo "Установка GNU Octave $OCTAVE_VERSION..." &&
    MAMBA_ROOT_PREFIX="$tmp/root" "$tmp/bin/micromamba" create -y -q \
        -p "$ENV_DIR" -c conda-forge --override-channels "octave=$OCTAVE_VERSION" &&
    echo "Проверка Octave..." &&
    OCTAVE_HOME="$ENV_DIR" "$ENV_DIR/bin/octave-cli" --norc --quiet --eval "disp(version)" &&
    touch "$ENV_DIR/.hhsim-installed"
  } >> "$LOG" 2>&1
  local status=$?
  rm -rf "$tmp"
  [ $status -eq 0 ] || rm -rf "$ENV_DIR"
  return $status
}

OCTAVE="$(find_octave)"
if [ -z "$OCTAVE" ]; then
  ANSWER=$(dialog "Добро пожаловать в HHsim!

Для работы программе нужна бесплатная среда GNU Octave. Её нужно один раз скачать (около 500 МБ). Это займёт 5–15 минут, нужен интернет.

Ничего вводить не придётся — просто подождите." "Отмена" "Скачать")
  [ "$ANSWER" = "Скачать" ] || exit 0

  PROGRESS_PID=""
  if [ $INTERACTIVE = 1 ]; then
    # окно «идёт установка»; закроем его сами, когда всё будет готово
    osascript -e 'display dialog "Идёт установка GNU Octave…

Это займёт 5–15 минут. Можно заниматься другими делами — HHsim откроется сам, когда всё будет готово." buttons {"Скрыть"} default button "Скрыть" with title "HHsim" with icon note giving up after 3600' >/dev/null 2>&1 &
    PROGRESS_PID=$!
  fi
  install_octave
  STATUS=$?
  [ -n "$PROGRESS_PID" ] && kill "$PROGRESS_PID" 2>/dev/null
  if [ $STATUS -ne 0 ]; then
    dialog "Не удалось установить GNU Octave. Проверьте подключение к интернету и попробуйте открыть HHsim ещё раз.

Подробности записаны в файле ~/Library/HHsim/install.log" "OK" >/dev/null
    exit 1
  fi
  [ $INTERACTIVE = 1 ] || { echo "$ENV_DIR/bin/octave"; exit 0; }
  OCTAVE="$ENV_DIR/bin/octave"
elif [ $INTERACTIVE = 0 ]; then
  echo "$OCTAVE"; exit 0
fi

# Octave из conda-forge ищет свои файлы по переменной OCTAVE_HOME
case "$OCTAVE" in
  "$ENV_DIR"/*) export OCTAVE_HOME="$ENV_DIR" ;;
esac

# Программа сохраняет файлы (положение окон) рядом с кодом,
# поэтому запускаем её из копии в папке пользователя.
DATA="$BASE/$VERSION"
if [ ! -f "$DATA/code/hhsim.m" ]; then
  mkdir -p "$DATA"
  cp -R "$RES/hhsim/" "$DATA/"
fi
cd "$DATA" || exit 1
exec "$OCTAVE" --no-gui --quiet --norc --eval start_hhsim

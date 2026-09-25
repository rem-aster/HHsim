#!/usr/bin/env bash
# Сборка HHsim для macOS.
#   packaging/macos/build.sh [каталог_вывода]
#
# На macOS получается образ HHsim-<версия>-macOS.dmg с привычным окном
# «перетащите HHsim в папку Программы» (нужен dmgbuild: pip3 install dmgbuild).
# На других ОС — только архив HHsim-<версия>-macOS.zip с HHsim.app.
#
# Приложение не содержит Octave: при первом запуске оно само скачивает
# GNU Octave из conda-forge в ~/Library/HHsim (без пароля и Терминала).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
OUT="$(mkdir -p "${1:-$ROOT/dist}" && cd "${1:-$ROOT/dist}" && pwd)"
VERSION="$(head -1 "$ROOT/code/VERSION" | sed 's/.*version //; s/\r//')"
WORK="${WORK:-$ROOT/build/macos}"

rm -rf "$WORK" && mkdir -p "$WORK"
APP="$WORK/HHsim.app/Contents"
mkdir -p "$APP/MacOS" "$APP/Resources/hhsim"
sed "s/@VERSION@/$VERSION/g" "$HERE/Info.plist" > "$APP/Info.plist"
cp "$HERE/launcher.sh" "$APP/MacOS/HHsim"
chmod 755 "$APP/MacOS/HHsim"
cp "$HERE/hhsim.icns" "$APP/Resources/"
echo "$VERSION" > "$APP/Resources/VERSION"
cp -R "$ROOT/code" "$APP/Resources/hhsim/code"
cp "$ROOT/packaging/start_hhsim.m" "$APP/Resources/hhsim/"

if [ "$(uname)" = "Darwin" ]; then
  OUTFILE="$OUT/HHsim-$VERSION-macOS.dmg"
  rm -f "$OUTFILE"
  (cd "$HERE" && dmgbuild -s dmg_settings.py \
      -D app="$WORK/HHsim.app" -D background="$HERE/dmg-background.png" \
      "HHsim" "$OUTFILE")
else
  OUTFILE="$OUT/HHsim-$VERSION-macOS.zip"
  rm -f "$OUTFILE"
  (cd "$WORK" && zip -qry "$OUTFILE" HHsim.app)
fi
ls -la "$OUTFILE"

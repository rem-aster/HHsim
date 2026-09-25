#!/usr/bin/env bash
# Сборка HHsim.app для macOS (работает на любой ОС; нужны bash и zip).
#   packaging/macos/build.sh [каталог_вывода]
# Результат: HHsim-<версия>-macOS.zip с приложением HHsim.app.
# Приложение использует GNU Octave, установленный через Homebrew
# (brew install octave); если Octave нет, оно предложит его установить.
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
cp "$HERE/README-macOS.txt" "$WORK/Прочтите.txt"

OUTFILE="$OUT/HHsim-$VERSION-macOS.zip"
rm -f "$OUTFILE"
(cd "$WORK" && zip -qry "$OUTFILE" HHsim.app "Прочтите.txt")
ls -la "$OUTFILE"

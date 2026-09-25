#!/usr/bin/env bash
# Сборка установщика HHsim для Windows со встроенным GNU Octave.
# Работает на Linux (и в Git Bash / MSYS2 на Windows): нужны curl, 7z, makensis.
#   Ubuntu/Debian: sudo apt install curl p7zip-full nsis
#
#   packaging/windows/build.sh [каталог_вывода]
#
# Переменные окружения:
#   OCTAVE_VERSION  версия Octave для Windows (по умолчанию 11.3.0)
#   OCTAVE_ARCHIVE  путь к уже скачанному octave-<версия>-w64.7z (чтобы не качать заново)
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
OUT="$(mkdir -p "${1:-$ROOT/dist}" && cd "${1:-$ROOT/dist}" && pwd)"
VERSION="$(head -1 "$ROOT/code/VERSION" | sed 's/.*version //; s/\r//')"
OCTAVE_VERSION="${OCTAVE_VERSION:-11.3.0}"
WORK="${WORK:-$ROOT/build/windows}"
ARCHIVE="${OCTAVE_ARCHIVE:-$WORK/octave-$OCTAVE_VERSION-w64.7z}"
URL="https://ftpmirror.gnu.org/gnu/octave/windows/octave-$OCTAVE_VERSION-w64.7z"

mkdir -p "$WORK"
if [ ! -f "$ARCHIVE" ]; then
  echo "Скачивание GNU Octave $OCTAVE_VERSION для Windows..."
  curl -fL --retry 3 -o "$ARCHIVE.part" "$URL"
  mv "$ARCHIVE.part" "$ARCHIVE"
fi

STAGE="$WORK/stage"
rm -rf "$STAGE" && mkdir -p "$STAGE"
echo "Распаковка Octave..."
# Не распаковываем то, что не нужно для запуска HHsim: компилятор, заголовки,
# статические библиотеки, документацию и дополнительные пакеты Octave.
P="octave-$OCTAVE_VERSION-w64"
7z x -y -bso0 -bsp0 -o"$STAGE" "$ARCHIVE" \
  -xr'!*.a' \
  -x"!$P/mingw64/include" \
  -x"!$P/mingw64/libexec/gcc" \
  -x"!$P/mingw64/share/doc" -x"!$P/mingw64/share/man" -x"!$P/mingw64/share/info" -x"!$P/mingw64/share/gtk-doc" \
  -x"!$P/usr/share/doc" -x"!$P/usr/share/man" -x"!$P/usr/share/info" \
  -x"!$P/mingw64/share/octave/packages" -x"!$P/mingw64/lib/octave/packages"
mv "$STAGE/octave-$OCTAVE_VERSION-w64" "$STAGE/octave"
test -f "$STAGE/octave/mingw64/bin/octave-gui.exe" || { echo "в архиве нет octave-gui.exe" >&2; exit 1; }

echo "Подготовка файлов HHsim..."
mkdir -p "$STAGE/hhsim"
cp -r "$ROOT/code" "$STAGE/hhsim/code"
cp "$ROOT/packaging/start_hhsim.m" "$ROOT/packaging/hhsim.ico" "$STAGE/hhsim/"
cp "$ROOT/code/COPYING" "$STAGE/hhsim/LICENSE.txt"

echo "Сборка установщика (сжатие занимает несколько минут)..."
OUTFILE="$OUT/HHsim-$VERSION-Windows-Installer.exe"
makensis -V2 -INPUTCHARSET UTF8 \
  -DVERSION="$VERSION" -DSTAGE="$STAGE" -DOUTFILE="$OUTFILE" \
  "$HERE/hhsim.nsi"
ls -la "$OUTFILE"

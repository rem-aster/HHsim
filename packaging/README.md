# Сборка пакетов HHsim

MATLAB и лицензии не нужны: программа работает в свободной среде GNU Octave.

| Файл | Что делает |
|---|---|
| `start_hhsim.m` | Загрузчик: запускает `hhsim` в Octave, ждёт закрытия главного окна и выходит |
| `windows/build.sh`, `windows/hhsim.nsi` | Установщик для Windows (NSIS) со встроенным GNU Octave для Windows |
| `macos/build.sh`, `macos/launcher.sh`, `macos/Info.plist` | `HHsim.app` для macOS; использует Octave из Homebrew и при его отсутствии предлагает установить |
| `hhsim.ico`, `hhsim.png`, `macos/hhsim.icns` | Значок программы |

## Windows

```sh
sudo apt install curl p7zip-full nsis     # или то же в MSYS2 на Windows
packaging/windows/build.sh                # -> dist/HHsim-3.7-ru-Windows-Installer.exe
```

Скрипт скачивает официальный архив Octave для Windows (`OCTAVE_VERSION`, по умолчанию 11.3.0)
и распаковывает его без компилятора, заголовков, статических библиотек, документации и
дополнительных пакетов (≈1,5 ГБ вместо 2,8 ГБ). Установщик ставит программу в `C:\HHsim`
(без прав администратора), запускает штатную настройку Octave (`post-install.bat`,
`fc_update.bat`) и создаёт ярлыки. Ярлык запускает
`octave.vbs --no-gui --eval start_hhsim` из каталога `C:\HHsim\hhsim`.

Тихая установка: `HHsim-3.7-ru-Windows-Installer.exe /S /D=C:\HHsim`.

## macOS

```sh
packaging/macos/build.sh                  # -> dist/HHsim-3.7-ru-macOS.zip
```

Собирать можно на любой ОС. Приложение не содержит Octave: собрать переносимый Octave для
macOS сложно, а Homebrew ставит его одной командой (`brew install octave`). При первом
запуске код копируется в `~/Library/Application Support/HHsim/<версия>`, потому что
программа сохраняет файлы рядом с кодом.

## Проверка

`tests/smoke_test.m` запускает программу, подаёт Стим1 и проверяет спайк, затем прогоняет
протокол фиксации потенциала. В CI (`.github/workflows/build.yml`) он выполняется в Octave
на Linux, во встроенном Octave после установки на Windows и в Octave из Homebrew на macOS.

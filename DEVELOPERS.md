# HHsim: для разработчиков

| Путь | Содержимое |
|---|---|
| [`code/`](code) | Исходный код (Octave/MATLAB) и встроенная справка `code/help/` |
| [`packaging/`](packaging) | Сборка установщиков: [`windows/build.sh`](packaging/windows/build.sh), [`macos/build.sh`](packaging/macos/build.sh), загрузчик `start_hhsim.m` |
| [`tests/smoke_test.m`](tests/smoke_test.m) | Автоматическая проверка: запуск, спайк после Стим1, фиксация потенциала |
| [`.github/workflows/build.yml`](.github/workflows/build.yml) | CI: проверка в Octave, сборка и проверка установщиков, публикация выпуска |

Установщики собираются без MATLAB и без лицензий:

```sh
# Windows-установщик (собирается и на Linux): нужны curl, 7z, makensis
sudo apt install curl p7zip-full nsis
packaging/windows/build.sh          # -> dist/HHsim-3.7-ru-Windows-Installer.exe

# macOS-приложение (собирается на любой ОС): нужен zip
packaging/macos/build.sh            # -> dist/HHsim-3.7-ru-macOS.zip

# проверка в Octave (на сервере без экрана — через xvfb-run)
xvfb-run octave --no-gui --eval "addpath('tests'); smoke_test"
```

Чтобы опубликовать выпуск, отправьте тег: `git tag v3.7-ru && git push origin v3.7-ru` —
workflow соберёт файлы и прикрепит их к GitHub Release.

Изменения относительно оригинальной версии 3.7 перечислены в [`code/CHANGES`](code/CHANGES).
Логика моделирования не менялась.

## Выпуски

Файлы для скачивания публикует workflow `.github/workflows/build.yml` при отправке тега `v*`:

```sh
git tag v3.7-ru && git push origin v3.7-ru
```

Имена файлов выпуска должны совпадать со ссылками в `README.md`
(`releases/latest/download/<имя файла>`): `HHsim-3.7-ru-Windows-Installer.exe`,
`HHsim-3.7-ru-macOS.zip`, `HHsim-3.7-ru-source.zip`. При смене версии обновите их.

# Сборка установщиков HHsim для Windows и macOS

Установщики собираются с помощью **MATLAB Compiler** из исходного кода в каталоге
[`code/`](../code). Готовое приложение работает без лицензии MATLAB — ему нужна только
бесплатная среда выполнения **MATLAB Runtime**, которую установщик скачивает и ставит сам.

| Платформа | Файл | Где собирать |
|---|---|---|
| Windows x86_64 | `HHsim-3.7-ru-Windows-Installer.exe` | Windows |
| macOS Apple Silicon | `HHsim-3.7-ru-macOS-AppleSilicon-Installer.zip` | Mac на Apple Silicon, MATLAB для Apple Silicon |
| macOS Intel | `HHsim-3.7-ru-macOS-Intel-Installer.zip` | Mac на Intel (или MATLAB для Intel под Rosetta) |

MATLAB Compiler не умеет собирать приложения для другой ОС, поэтому каждый установщик
собирается на своей платформе.

## Вариант 1. Локально, в своём MATLAB

Нужны MATLAB R2020b или новее и MATLAB Compiler (рекомендуется R2025a+, как и для
оригинальной версии 3.7).

```matlab
cd путь/к/HHsim
addpath packaging
build_installers            % результат появится в каталоге dist/
```

По умолчанию установщик скачивает MATLAB Runtime во время установки
(`RuntimeDelivery = 'web'`) и весит несколько мегабайт. Чтобы получить автономный
установщик со встроенным Runtime (несколько гигабайт, установка без Интернета):

```matlab
build_installers('dist', 'installer')
```

## Вариант 2. Автоматически, в GitHub Actions

Workflow [`.github/workflows/build-installers.yml`](../.github/workflows/build-installers.yml)
собирает все три установщика и архив исходного кода на виртуальных машинах GitHub:

* вручную — вкладка **Actions → «Сборка установщиков» → Run workflow**
  (файлы появятся в артефактах запуска);
* при push тега `v*` (например, `git tag v3.7-ru && git push origin v3.7-ru`) —
  файлы дополнительно публикуются в **GitHub Releases**, откуда на них ссылается
  страница загрузки (`index.html`).

Бесплатная лицензия MATLAB для публичных репозиториев на GitHub Actions **не включает
MATLAB Compiler**, поэтому нужен собственный токен:

1. Получите у MathWorks batch-токен (*MATLAB batch licensing token*) для лицензии,
   в которую входит MATLAB Compiler (подробности:
   <https://github.com/mathworks-ref-arch/matlab-dockerfile/blob/main/alternates/non-interactive/MATLAB-BATCH.md>).
2. В репозитории откройте **Settings → Secrets and variables → Actions → New repository secret**
   и создайте секрет `MLM_LICENSE_TOKEN` с этим токеном.

Без токена задание архива исходного кода выполнится, а задания установщиков завершатся
с понятной ошибкой.

## Примечания

* Все `.m`-файлы из `code/` добавляются в сборку явно: многие функции вызываются из
  строковых обратных вызовов интерфейса, которые анализ зависимостей не находит.
  Кроме того, они перечислены в директивах `%#function` в `hhsim.m`.
* Справка (`code/help/`) входит в сборку; кнопка «?» в программе открывает её в браузере.
* Приложения не подписаны сертификатами Microsoft/Apple, поэтому при первом запуске
  Windows SmartScreen и macOS Gatekeeper показывают предупреждение. Как его обойти,
  написано в инструкции по установке в [`index.html`](../index.html).

# HHsim — графический симулятор Ходжкина–Хаксли (русская версия)

Неофициальный русский перевод учебной программы **HHsim** и её сайта
<https://www.cs.cmu.edu/~dst/HHsim/>.
Авторы оригинала: David S. Touretzky, Mark V. Albert, Nathaniel D. Daw, Alok Ladsariya,
Mahtiyar Bonakdarpour (Carnegie Mellon University).

HHsim — графическая модель участка возбудимой мембраны нейрона на основе уравнений
Ходжкина–Хаксли с полным доступом к параметрам каналов, мембраны, стимулов и концентрациям
ионов. Программа создана для курсов нейрофизиологии.

## Что здесь

| Путь | Содержимое |
|---|---|
| [`index.html`](index.html) | Главная страница сайта (перевод), ссылки на загрузку и инструкции по установке |
| [`guide.html`](guide.html), [`cursor.html`](cursor.html), [`vclamp.html`](vclamp.html) | Руководство пользователя |
| [`exercises.html`](exercises.html) | Примеры упражнений |
| [`screenshots.html`](screenshots.html) | Снимки экрана |
| [`code/`](code) | Исходный код MATLAB (версия 3.7-ru) с русским интерфейсом и справкой в `code/help/` |
| [`packaging/`](packaging) | Сборка установщиков для Windows и macOS |

Сайт — статические HTML-файлы; его можно открыть локально или опубликовать, например, через
GitHub Pages (Settings → Pages → ветка с этими файлами, каталог `/`).

## Установка

Готовые файлы — на странице [Releases](https://github.com/rem-aster/HHsim/releases):

* **Windows:** `HHsim-3.7-ru-Windows-Installer.exe` — запустите и следуйте указаниям.
* **macOS:** `HHsim-3.7-ru-macOS-AppleSilicon-Installer.zip` (M1 и новее) или
  `HHsim-3.7-ru-macOS-Intel-Installer.zip` — распакуйте, откройте установщик через
  правый щелчок → «Открыть».
* **Linux и все, у кого есть MATLAB R2020a+:** исходный код — запустите MATLAB,
  перейдите в каталог `code` и введите `hhsim`.

Установщикам не нужна лицензия MATLAB: они сами устанавливают бесплатную среду MATLAB Runtime.
Подробные инструкции — в [`index.html`](index.html). Как собрать установщики самому —
в [`packaging/README.md`](packaging/README.md).

## Об исходном коде

Изменения относительно оригинальной версии 3.7 перечислены в [`code/CHANGES`](code/CHANGES).
Коротко: переведён весь интерфейс и справка, файлы переведены в UTF-8, некоторые элементы
интерфейса расширены под русские надписи, справка открывается и из скомпилированной версии.
Логика моделирования не менялась.

## Лицензия

GNU General Public License версии 2 или более поздней — см. [`code/COPYING`](code/COPYING)
(оригинальный английский текст лицензии).

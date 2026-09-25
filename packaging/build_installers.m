function build_installers(outDir, runtimeDelivery)
%BUILD_INSTALLERS  Собирает установщик русской версии HHsim для текущей ОС.
%
%   build_installers              - собрать в каталог dist/ рядом с репозиторием
%   build_installers(outDir)      - собрать в указанный каталог
%   build_installers(outDir, 'installer')
%                                 - встроить MATLAB Runtime в установщик
%                                   (по умолчанию 'web': установщик скачивает
%                                   Runtime из Интернета во время установки)
%
%   Нужны MATLAB R2020b или новее и MATLAB Compiler. Запускайте на той ОС,
%   для которой нужен установщик: на Windows получится .exe, на macOS -
%   архив .zip с приложением-установщиком (для Apple Silicon или Intel -
%   в зависимости от того, на каком Mac и в какой версии MATLAB идёт сборка).
%
%   Результат:
%     Windows: HHsim-<версия>-Windows-Installer.exe
%     macOS:   HHsim-<версия>-macOS-AppleSilicon-Installer.zip
%              HHsim-<версия>-macOS-Intel-Installer.zip

version = '3.7-ru';
installerVersion = '3.7';   % компилятор принимает только числа вида X.Y

root = fileparts(fileparts(mfilename('fullpath')));
codeDir = fullfile(root, 'code');
if nargin < 1 || isempty(outDir)
  outDir = fullfile(root, 'dist');
end
if nargin < 2 || isempty(runtimeDelivery)
  runtimeDelivery = 'web';
end
if ~exist(outDir, 'dir'), mkdir(outDir); end
outDir = char(java.io.File(outDir).getCanonicalPath());

if ispc
  platform = 'Windows';
elseif ismac
  if strcmp(computer('arch'), 'maca64')
    platform = 'macOS-AppleSilicon';
  else
    platform = 'macOS-Intel';
  end
else
  error('HHsim:build', ...
    'Установщики собираются только на Windows и macOS. На Linux запускайте HHsim из исходного кода.');
end
installerName = sprintf('HHsim-%s-%s-Installer', version, platform);

% Все .m-файлы добавляются явно: многие функции вызываются из строковых
% обратных вызовов (callbacks), которые анализ зависимостей не видит.
mfiles = dir(fullfile(codeDir, '*.m'));
skip = {'hhsim.m', 'hhsim_zoom.m', 'hhsim_zoom_old.m', 'run.m', 'Contents.m', 'test_name.m'};
mfiles = mfiles(~ismember({mfiles.name}, skip));
extra = [fullfile(codeDir, {mfiles.name}), ...
         {fullfile(codeDir, 'help'), fullfile(codeDir, 'windowpos.mat'), ...
          fullfile(codeDir, 'COPYING'), fullfile(codeDir, 'README')}];

buildDir = fullfile(tempdir, ['hhsim_build_' platform]);
if exist(buildDir, 'dir'), rmdir(buildDir, 's'); end
mkdir(buildDir);

fprintf('Сборка HHsim %s для %s...\n', version, platform);
opts = compiler.build.StandaloneApplicationOptions(fullfile(codeDir, 'hhsim.m'), ...
  'ExecutableName', 'HHsim', ...
  'AdditionalFiles', extra, ...
  'OutputDir', buildDir, ...
  'EmbedArchive', 'on', ...
  'Verbose', 'on');

if ispc
  % без консольного окна
  results = compiler.build.standaloneWindowsApplication(opts);
else
  results = compiler.build.standaloneApplication(opts);
end

fprintf('Создание установщика %s...\n', installerName);
pkgDir = fullfile(buildDir, 'installer');
compiler.package.installer(results, ...
  'ApplicationName', 'HHsim', ...
  'Version', installerVersion, ...
  'InstallerName', installerName, ...
  'OutputDir', pkgDir, ...
  'RuntimeDelivery', runtimeDelivery, ...
  'AuthorName', 'David S. Touretzky', ...
  'AuthorEmail', 'dst@cs.cmu.edu', ...
  'AuthorCompany', 'Carnegie Mellon University', ...
  'Summary', 'HHsim - графический симулятор Ходжкина-Хаксли (русская версия)', ...
  'Description', ['HHsim - графическая модель участка возбудимой мембраны нейрона, ' ...
                  'основанная на уравнениях Ходжкина-Хаксли. Учебная программа для ' ...
                  'курсов нейрофизиологии. Свободное ПО (GNU GPL).'], ...
  'InstallationNotes', ['Для работы HHsim нужна бесплатная среда MATLAB Runtime; ' ...
                        'установщик установит её автоматически.']);

if ispc
  src = fullfile(pkgDir, [installerName '.exe']);
  dst = fullfile(outDir, [installerName '.exe']);
  copyfile(src, dst, 'f');
else
  src = fullfile(pkgDir, [installerName '.app']);
  dst = fullfile(outDir, [installerName '.zip']);
  if exist(dst, 'file'), delete(dst); end
  % ditto сохраняет права и атрибуты пакета .app
  status = system(sprintf('ditto -c -k --sequesterRsrc --keepParent "%s" "%s"', src, dst));
  if status ~= 0
    error('HHsim:build', 'Не удалось упаковать %s', src);
  end
end
fprintf('Готово: %s\n', dst);

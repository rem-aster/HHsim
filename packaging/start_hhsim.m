function start_hhsim
%START_HHSIM  Запуск HHsim в GNU Octave из установленного пакета.
%   Ищет каталог code/ рядом с этим файлом, запускает симулятор и ждёт,
%   пока пользователь закроет главное окно, после чего завершает Octave.

warning('off', 'Octave:shadowed-function');
warning('off', 'all');   % не засорять окно сообщений предупреждениями совместимости
here = fileparts(mfilename('fullpath'));
codedir = fullfile(here, 'code');
if ~exist(fullfile(codedir, 'hhsim.m'), 'file')
  codedir = fullfile(fileparts(here), 'code');   % запуск из репозитория
end

try
  graphics_toolkit('qt');
  cd(codedir);
  hhsim;
  global handles
  waitfor(handles.mainwindow);
catch err
  disp(['Ошибка при запуске HHsim: ' err.message]);
  for k = 1:numel(err.stack)
    fprintf('  %s: строка %d\n', err.stack(k).name, err.stack(k).line);
  end
  input('Нажмите Enter, чтобы закрыть окно... ', 's');
end
exit(0);

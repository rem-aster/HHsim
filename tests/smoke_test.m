function smoke_test
%SMOKE_TEST  Автоматическая проверка HHsim в Octave/MATLAB.
%   Запускает симулятор, подаёт стимул Стим1, проверяет, что возник спайк,
%   прогоняет протокол фиксации потенциала и закрывает программу.
%   Завершает Octave с кодом 0 при успехе и 1 при ошибке.

logfile = getenv('HHSIM_LOG');   % для запуска без консоли (octave-gui.exe на Windows)
if ~isempty(logfile), diary(logfile); end
if exist('OCTAVE_VERSION', 'builtin')
  warning('off', 'all');
  graphics_toolkit('qt');
end
here = fileparts(mfilename('fullpath'));
codedir = getenv('HHSIM_CODE');
if isempty(codedir), codedir = fullfile(fileparts(here), 'code'); end
cd(codedir);
ok = false;
try
  hhsim;
  global handles vars
  drawnow;

  callbacks(5);   % Стим1
  vmax = 1000 * max(vars.Vtot_hist(1, 1:vars.iteration));
  fprintf('Стим1: %d шагов, пик потенциала %.1f мВ\n', vars.iteration, vmax);
  assert(vmax > 0, 'после Стим1 нет спайка');

  line_click(1);  % курсор
  assert(strcmp(get(handles.cursor, 'visible'), 'on'), 'курсор не появился');

  for w = {'memwindow', 'chanwindow', 'stimwindow', 'drugwindow', 'HH_Na_gates'}
    set(handles.(w{1}), 'Visible', 'on'); drawnow; set(handles.(w{1}), 'Visible', 'off');
  end

  set(handles.modebutton, 'Value', 2); callbacks(23); drawnow;   % фиксация потенциала
  callbacks(29);                                                  % Пуск
  n = vars.vc_iteration(1);
  imin = min(vars.vc_varplotdata(1, 1:n));
  fprintf('Фиксация потенциала: %d шагов, минимум тока %.1f нА\n', n, imin);
  assert(n > 100 && imin < -50, 'нет входящего Na-тока при фиксации потенциала');

  ok = true;
catch err
  fprintf(2, 'ОШИБКА: %s\n', err.message);
  for k = 1:numel(err.stack)
    fprintf(2, '  %s: строка %d\n', err.stack(k).name, err.stack(k).line);
  end
end
% закрыть окна, не сохраняя их положение
set(0, 'ShowHiddenHandles', 'on'); delete(get(0, 'Children'));
if ok, disp('SMOKE TEST OK'); end
if ~isempty(logfile), diary off; end
if exist('OCTAVE_VERSION', 'builtin'), exit(~ok); end

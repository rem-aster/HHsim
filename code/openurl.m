function [ret] = openurl(filename)
% Open an HTML help file from the HHsim directory in the system browser.
% Works both from the Matlab source and in the compiled (MATLAB Compiler)
% version, where the help files are packaged next to the code.

helpdir = fileparts(mfilename('fullpath'));
helpfile = fullfile(helpdir, filename);
if ~exist(helpfile, 'file') && isdeployed
  % compiled version: look for the file inside the extracted archive
  [~, name, ext] = fileparts(filename);
  found = dir(fullfile(ctfroot, '**', [name ext]));
  if ~isempty(found)
    helpfile = fullfile(found(1).folder, found(1).name);
  end
end
if ~exist(helpfile, 'file')
  helpfile = fullfile(pwd, filename);
end
helpurl = ['file:///' strrep(helpfile, '\', '/')];
helpurl = strrep(helpurl, 'file:////', 'file:///');

ret = 0;
try
  if ispc
    winopen(helpfile);
  elseif ismac
    ret = system(['open "' helpfile '"']);
  else
    ret = system(['xdg-open "' helpfile '" > /dev/null 2>&1 &']);
  end
catch
  ret = -1;
end

if ret ~= 0
  % fallback: let Matlab pick a browser
  try
    ret = web(helpurl, '-browser');
  catch
    ret = -3;
    warndlg(['Не удалось открыть руководство: ' helpfile], 'HHsim');
  end
end

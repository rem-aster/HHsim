function [ret] = openurl(filename)

unixbrowsers={'mozilla' 'netscape' 'galeon' 'phoenix'};
helpurl=['file://' pwd '/' filename];

if (strncmp(computer,'MAC',3))
  unix(['osascript -e ''open location "' helpurl '"''']);   
  ret=0;
elseif (isunix)
  found=0;
  shell = getenv('SHELL');
  [pathstr, shellname] = fileparts(shell);
  if isequal(shellname, 'tcsh') | isequal(shellname, 'csh')
    shellarg ='>& /dev/null';
  elseif isequal(shellname,'sh') | isequal(shellname, 'ksh') | isequal(shellname, 'bash')
    shellarg ='> /dev/null 2>&1';
  else
    shellarg ='';
  end

  for i=1:size(unixbrowsers,2)
    [stat]=unix(['which ' unixbrowsers{i} ' ' shellarg]);
    if (stat==0)
      found=i;
      break;
    end
  end

  if (found)
    ret=unix([unixbrowsers{found} ' ' helpurl ' ' shellarg ' & ']);
  else
    ret=-1;
  end
elseif (ispc)
  dos('start help/guide.html');
  ret=0;
else
  ret=-3; 
end


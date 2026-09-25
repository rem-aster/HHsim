function close_all

global vars

%session stuff
winloc_save;

if (vars.iterating)
  vars.quitflag=1;
  vars.stopflag=1;
else
  close_finally;
end


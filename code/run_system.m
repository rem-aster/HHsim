function run_system (mode)
% 0  run until done and stop
% 1  nudge for 2 ms
% 2  run forever
% 3  stop

global vars handles

if (mode==1)                             % nudge
  if (~vars.vclampmode)
    vars.nudge_time=vars.time+0.002;
    % vars.stimtimer = [0;Inf];
    if (vars.iterating==0)
      iterate;
    end
  else
    % cached voltage not good anymore
    vars.vc_cached_voltage=NaN;
  end
elseif (mode==2)                         % run
  vars.stopflag=Inf;
  if (vars.iterating==0)
    iterate;
  end
elseif (mode==3)
  set(handles.runbutton,'BackgroundColor',[0.4 1 0.4]);
  vars.stopflag=1;
  vars.nudge_time=0;
else                                     % default run
  if (vars.iterating==0)
    iterate;
  %  zoom on;
  %  zoom off;
  end
end

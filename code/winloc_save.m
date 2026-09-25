function winloc_save

global handles
if (strncmp(computer,'MAC',3))
  % doesn't work with OSX yet
else
  try
    windowpos=zeros(8,4);
    windowpos(1,:)=get (handles.mainwindow,'Position');
    windowpos(2,:)=get (handles.memwindow,'Position');
    windowpos(3,:)=get (handles.chanwindow,'Position');
    windowpos(4,:)=get (handles.stimwindow,'Position');
    windowpos(5,:)=get (handles.vclampwindow, 'Position');
    windowpos(6,:)=get (handles.drugwindow,'Position');
    windowpos(7,:)=get (handles.HH_Na_gates,'Position');
    windowpos(8,:)=get (handles.HH_K_gates,'Position');
    windowpos(9,:)=get (handles.HH_user1_gates,'Position');

    save 'windowpos.mat' windowpos;
  catch
    % ignore
  end
end

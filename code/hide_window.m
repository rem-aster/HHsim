function hide_window

global handles

switch gcf
  case handles.HH_Na_gates
     set_winvis(gcf, 0);
  case handles.HH_K_gates
  case handles.HH_user1_gates
  case handles.stimwindow
  case handles.memwindow
  case handles.chanwindow
end
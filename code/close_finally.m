function close_finally

global handles

% if an HH simulator is up and running - close it all
if figflag('HHsim Hodgkin-Huxley Simulator', 1) && length(handles) == 1 && length(fieldnames(handles)) > 50
 delete(handles.chanwindow);
 delete(handles.memwindow);
 delete(handles.HH_Na_gates);
 delete(handles.HH_user1_gates);
 delete(handles.HH_K_gates);
 delete(handles.stimwindow);
 delete(handles.vclampwindow);
 delete(handles.drugwindow);
 delete(handles.mainwindow);
end

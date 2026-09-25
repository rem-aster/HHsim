function close_finally

global handles

% if an HH simulator is up and running - close it all
if ~isempty(findall(0,'Type','figure','Name','HHsim - симулятор Ходжкина-Хаксли')) && length(handles) == 1 && length(fieldnames(handles)) > 50
 % stop callbacks that could touch windows while they are being deleted
 set(handles.mainwindow,'ResizeFcn','');
 if ishghandle(handles.chanwindow), delete(handles.chanwindow); end
 if ishghandle(handles.memwindow), delete(handles.memwindow); end
 if ishghandle(handles.HH_Na_gates), delete(handles.HH_Na_gates); end
 if ishghandle(handles.HH_user1_gates), delete(handles.HH_user1_gates); end
 if ishghandle(handles.HH_K_gates), delete(handles.HH_K_gates); end
 if ishghandle(handles.stimwindow), delete(handles.stimwindow); end
 if ishghandle(handles.vclampwindow), delete(handles.vclampwindow); end
 if ishghandle(handles.drugwindow), delete(handles.drugwindow); end
 if ishghandle(handles.mainwindow), delete(handles.mainwindow); end
end

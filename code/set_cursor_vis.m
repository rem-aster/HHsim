function set_cursor_vis (setstring)

global handles vars

if strcmp(setstring,'on')
  set(handles.zoominbutton, 'String', 'Zoom in*');
  set(handles.zoomoutbutton, 'String', 'Zoom out*');
  opp = 'off';
else
  set(handles.zoominbutton, 'String', 'Zoom in');
  set(handles.zoomoutbutton, 'String', 'Zoom out');
  opp = 'on';
end

set(handles.cursor_instruction, 'visible', opp);

set(handles.cursor, 'visible', setstring);
set(handles.cursor_text, 'visible', setstring);
set(handles.cursor_time_text, 'visible', setstring);
set(handles.cursor_label_text, 'visible', setstring);
if (vars.vclampmode==0)
  set(handles.storebutton, 'visible', setstring);
  set(handles.vc_delbutton, 'visible', 'off');
else
  set(handles.storebutton, 'visible', 'off');
  set(handles.vc_delbutton, 'visible', setstring);
end
set(handles.cursor_off, 'visible', setstring);
set(handles.farleftbutton, 'visible', setstring);
set(handles.leftbutton, 'visible', setstring);
set(handles.rightbutton, 'visible', setstring);
set(handles.farrightbutton, 'visible', setstring);
set(handles.changelinebutton, 'visible', setstring);


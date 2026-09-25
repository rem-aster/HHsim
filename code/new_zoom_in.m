function new_zoom_in(xmid)
global vars handles

xlims = get(handles.vc_vplot, 'XLim');
lower_bound = (xmid+xlims(1))/2;
upper_bound = (xmid+xlims(2))/2;


set(handles.vc_vplot,'XLim',[lower_bound upper_bound]);

set(handles.vc_mainplot,'XLim',[lower_bound upper_bound]);

if strcmp(get(handles.cursor, 'visible'),'on')
    userdata = get(handles.cursor, 'userdata');
    vc_reset_cursor_values(userdata.line_id, userdata.index);
end

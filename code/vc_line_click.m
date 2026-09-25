function vc_line_click (line_id)

global handles vars

if line_id <= vars.vc_maxc
    axes(handles.vc_mainplot);
    click_point = get(handles.vc_mainplot,'CurrentPoint');
    userdata = get(handles.vc_mainplot,'userdata');
    line_data = userdata.lines(line_id);
else
    axes(handles.vc_vplot);
    click_point = get(handles.vc_vplot,'CurrentPoint');
    userdata = get(handles.vc_vplot,'userdata');
    line_data = userdata.lines(line_id - vars.vc_maxc);
end

x_val = click_point(1,1);
xdata = get(line_data, 'Xdata');
index = 1;

while (xdata(index) < x_val)
    index = index + 1;
end

vc_reset_cursor_values(line_id, index);

set_cursor_vis('on');

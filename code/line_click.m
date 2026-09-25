function line_click (line_id)

global handles vars

if line_id <= 2
    axes(handles.mainplot);
    click_point = get(handles.mainplot,'CurrentPoint');
    userdata = get(handles.mainplot,'userdata');
    line_data = userdata.lines(line_id);
else
    axes(handles.varplot);
    click_point = get(handles.varplot,'CurrentPoint');
    userdata = get(handles.varplot,'userdata');
    line_data = userdata.lines(line_id - 2);
end

x_val = click_point(1,1);
xdata = get(line_data, 'Xdata');
index = 1;

while (xdata(index) < x_val)
    index = index + 1;
end

reset_cursor_values(line_id, index);

set_cursor_vis('on');

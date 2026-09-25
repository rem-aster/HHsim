function vc_reset_cursor_values(line_id, index)

global handles vars

line_color = [ [1 0 0]; [0 0 1]; [0 1 0]; [1 0 1]; [0 1 1]; [1 1 0]; [1 0.5 0]; [0 0.7 0]; [1 0 0]; [0 0 1]; [0 1 0]; [1 0 1]; [0 1 1]; [1 1 0]; [1 0.5 0]; [0 0.7 0] ]; 
line_color = (1 - line_color)/2 + line_color;

if line_id <= vars.vc_maxc
    axes(handles.vc_mainplot);
    userdata = get(handles.vc_mainplot,'userdata');
    line_data = userdata.lines(line_id);
    line_type = 7;
    label = 'A';
    cursorlabel = 'Memb. Current';
else
    axes(handles.vc_vplot);
    userdata = get(handles.vc_vplot,'userdata');
    line_data = userdata.lines(line_id - vars.vc_maxc);
    line_type = 1;
    label = 'mV';
    cursorlabel = 'Set Voltage';
end

xdata = get(line_data, 'Xdata');
ydata = get(line_data, 'Ydata');

if index <= length(ydata)
  y_graph_val = ydata(index);
  y_val = graph_scale(y_graph_val, line_type, 0);
else
  y_graph_val = NaN;
end

% if there is no value on that line
if isnan(y_graph_val)
    line_id = mod(line_id, vars.vc_maxc*2) + 1;
    vc_reset_cursor_values(line_id, index);
    return;
end

% setting the cursor size
xlim = get(gca, 'Xlim');         ylim = get(gca, 'Ylim');
c_xsize = 0.01 * (xlim(2) - xlim(1));
c_ysize = 0.06 * (ylim(2) - ylim(1));
if (line_id > vars.vc_maxc)
    c_ysize = c_ysize * 2;
end

if line_id <= vars.vc_maxc
  set(handles.cursor, ...
  'Position', [xdata(index)-c_xsize/2, y_graph_val-c_ysize/2, c_xsize, c_ysize], ...
      'Curvature', [1 1], ...
      'FaceColor', line_color(line_id,1:3), 'visible', 'on', 'parent', handles.vc_mainplot);
else
  set(handles.cursor, ...
  'Position',[xdata(index)-c_xsize/2, y_graph_val-c_ysize/2, c_xsize, c_ysize], ...
      'Curvature', [1 1], ...
      'FaceColor', line_color(line_id,1:3), 'visible', 'on', 'parent', handles.vc_vplot);
end

if line_id<=vars.vc_maxc
  set(handles.cursor_text, 'String', varunits_string(y_val, label), ...
      'backgroundcolor',line_color(line_id,:));
else
  set(handles.cursor_text, 'String', [sprintf('%5.3g',y_val) ' ' label], ...
      'backgroundcolor',line_color(line_id,:));
end

set(handles.cursor_time_text, 'String', [sprintf('%5.2f',xdata(index)) ' msec']);
set(handles.cursor_label_text, ...
    'ForegroundColor',line_color(line_id,:),'String',cursorlabel)

userdata = get(handles.cursor, 'UserData');
userdata.index = index;
userdata.xval = xdata(index);
userdata.line_id = line_id;
userdata.yval=y_val;
set(handles.cursor, 'UserData', userdata);

vars.cursorx=index;

% scroll if the cursor has gone off the screen
axtmp = axis;
xrange = axtmp(2) - axtmp(1);
yrange = axtmp(4) - axtmp(3);

if xdata(index) <= axtmp(1)
    new_xax = (xdata(index)-xrange*0.1) + [0 xrange];
elseif xdata(index) >= axtmp(2)
    new_xax = (xdata(index)-xrange*0.9) + [0 xrange];
else    
    new_xax = axtmp(1:2);
end

if ydata(index) <= axtmp(3)
    new_yax = (ydata(index)-yrange*0.1) + [0 yrange];
elseif ydata(index) >= axtmp(4)
    new_yax = (ydata(index)-yrange*0.9) + [0 yrange];
else    
    new_yax = axtmp(3:4);
end

axis([new_xax new_yax])

%fprintf('index=%d xdata=%f new_xax=%g : %g\n', index, xdata(index), new_xax(1), new_xax(2));

% hide the cursor if it goes off the screen
%if ( (xdata(index) < xlim(1)) | (xdata(index) > xlim(2)) )
%  set_cursor_vis('off');
%end

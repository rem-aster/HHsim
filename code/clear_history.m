function clear_history

global handles vars

if (vars.state_saved.cursorx<2)
   vars.state_saved.V=vars.Vtot_hist(1,vars.state_saved.cursorx);
   vars.state_saved.varplotdata=vars.varplotdata(:,vars.state_saved.cursorx);
   vars.state_saved.cursorx=2;
end

vars.deltaT_plot = max_deltaT(0);
vars.plot_rate = 3;

% reset vars.deltaT_max ignoring pronase value
vars.deltaT_max=max_deltaT(1);
xwidth = 200 * vars.plot_rate * vars.deltaT_plot * 1e3;
%set(handles.slider, 'Visible', 'off');
set(handles.slider, 'Value', xwidth/2);
set(handles.slider, 'Min',xwidth/2);
set(handles.slider, 'Max',xwidth/2 + 1);
set(handles.slider, 'SliderStep', [0.01 1]);

set_cursor_vis('off');

vars.time = 0;
vars.iteration = 0;
vars.last_time = 1;
vars.nudge_time = 0;

axes(handles.mainplot);
cla;
make_splot(handles.mainplot, 500, 0,[-100 60],{'r' vars.stimcolor})

axes(handles.varplot);
cla;
make_splot(handles.varplot,500,0,[-0.1 1.1],{'y' 'g' 'c'})
vars.varplotdata_size = 500;
vars.varplotdata = NaN * ones(length(get(handles.v1button, 'String')), 500);
vars.Vtot_hist = NaN * ones(1,vars.varplotdata_size);
vars.Itot_hist = NaN * ones(1,vars.varplotdata_size);
vars.time_hist = zeros(1,vars.varplotdata_size);

% preparing the cursor
handles.cursor = rectangle('Curvature', [1 1], 'visible', 'off');
userdata = get(handles.mainplot, 'UserData');
set(userdata.lines(1), 'ButtonDownFcn', 'line_click(1)');
set(userdata.lines(2), 'ButtonDownFcn', 'line_click(2)');
userdata = get(handles.varplot, 'UserData');
set(userdata.lines(1), 'ButtonDownFcn', 'line_click(3)');
set(userdata.lines(2), 'ButtonDownFcn', 'line_click(4)');
set(userdata.lines(3), 'ButtonDownFcn', 'line_click(5)');

function vc_clear

global handles vars

if (vars.iterating)
  return;
end

vars.deltaT_plot = max_deltaT(0);
vars.plot_rate = 3;

%xwidth = 200 * vars.plot_rate * vars.deltaT_plot * 1e3;
%set(handles.vc_slider, 'Visible', 'off');
%set(handles.vc_slider, 'Value', xwidth/2);
%set(handles.vc_slider, 'Min',xwidth/2);
%set(handles.vc_slider, 'Max',xwidth/2 + 1);
%set(handles.vc_slider, 'SliderStep', [0.01 1]);
vc_slider_val;
vc_slider_set;
axes(handles.vc_mainplot);
cla;
make_splot(gca,500,0,[-100 100],{'r' 'b' 'g' 'm' 'c' 'y' [1 0.5 0] [0 0.7 0]})
userdata=get(handles.vc_mainplot,'UserData');
for i=1:vars.vc_maxc
  set(userdata.lines(i), 'ButtonDownFcn', ['vc_line_click(' num2str(i) ')']);
end
vars.vc_ymax=10;
vars.vc_ymin=-10;
set(gca,'YLim',[vars.vc_ymin vars.vc_ymax]*1.2);

axes(handles.vc_vplot);
cla;
make_splot(gca,500,0,[-100 100],{'r' 'b' 'g' 'm' 'c' 'y' [1 0.5 0] [0 0.7 0]})
userdata=get(handles.vc_vplot,'UserData');
for i=1:vars.vc_maxc
  set(userdata.lines(i), 'ButtonDownFcn', ['vc_line_click(' num2str(i+vars.vc_maxc) ')']);
end

vars.vc_varplotdata_size = 500;
vars.vc_varplotdata = NaN * ones(vars.vc_maxc*3,vars.vc_varplotdata_size);
vars.vc_numcurves=0;
vars.vc_iteration=zeros(1,vars.vc_maxc);
vars.vc_times=zeros(1,vars.vc_maxc);

handles.cursor = rectangle('Curvature', [1 1], 'visible', 'off');



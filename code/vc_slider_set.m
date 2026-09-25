function vc_slider_set
global handles vars

%initialize boundaries on vertical slider
xlims = get(handles.vc_mainplot, 'XLim');
x_width = xlims(2) - xlims(1);
slider_min = xlims(1) - (.5*x_width);
slider_max = xlims(2) + (.5*x_width);
slider_val = (xlims(1)+xlims(2))/2;

set(handles.vc_slider, 'Value',slider_val, 'Min', slider_min, 'Max', ...
   slider_max);

%%% Change width of slider 
xwidth = xlims(2) - xlims(1);
slider_min = get(handles.vc_slider, 'Min');
slider_max = get(handles.vc_slider, 'Max');
scrollwidth = slider_max - slider_min;
set(handles.vc_slider, 'sliderstep', [.1 xwidth/scrollwidth*2]);


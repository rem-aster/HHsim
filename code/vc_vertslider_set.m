function vc_vertslider_set

global handles vars

%initialize boundaries on vertical slider
ylims = get(handles.vc_mainplot, 'YLim');
y_width = ylims(2) - ylims(1);
slider_min = ylims(1) - (.5*y_width);
slider_max = ylims(2) + (.5*y_width);
slider_val = (ylims(1)+ylims(2))/2;

set(handles.vc_vertslider, 'Value',slider_val, 'Min', slider_min, 'Max', ...
   slider_max);

%%% Change width of slider 
ywidth = ylims(2) - ylims(1);
slider_min = get(handles.vc_vertslider, 'Min');
slider_max = get(handles.vc_vertslider, 'Max');
scrollwidth = slider_max - slider_min;
set(handles.vc_vertslider, 'sliderstep', [.1 ywidth/scrollwidth*2]);


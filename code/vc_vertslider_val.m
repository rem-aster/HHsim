function vc_vertslider_val

global handles vars

ylims = get(handles.vc_mainplot, 'YLim');
slider_val = (ylims(1)+ylims(2))/2;
slider_min = get(handles.vc_vertslider, 'Min');
slider_max = get(handles.vc_vertslider, 'Max');
if slider_val < slider_min
    set(handles.vc_vertslider, 'Min', slider_val);
end
if slider_val > slider_max
    set(handles.vc_vertslider, 'Max', slider_val);
end


%set current slider value
set(handles.vc_vertslider, 'Value',slider_val);

%%% Change width of slider on zoom. 
ywidth = ylims(2) - ylims(1);
slider_min = get(handles.vc_vertslider, 'Min');
slider_max = get(handles.vc_vertslider, 'Max');
scrollwidth = slider_max - slider_min;
set(handles.vc_vertslider, 'sliderstep', [.1 ywidth/scrollwidth*2]);
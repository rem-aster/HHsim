function vc_vertslider_extend(minmax)
global handles vars
if minmax == 0 %extend min
    ylims = get(handles.vc_mainplot, 'YLim');
    slider_min = get(handles.vc_vertslider, 'Min');
    diff = ylims(1) - slider_min;
    new_min = slider_min - 4*diff;
    set(handles.vc_vertslider, 'Min', new_min);
else
    ylims = get(handles.vc_mainplot, 'YLim');
    slider_max = get(handles.vc_vertslider, 'Max');
    diff = ylims(2) - slider_max;
    new_max = slider_max + 4*diff;
    set(handles.vc_vertslider, 'Max', new_max);
end



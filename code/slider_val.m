function slider_val

global handles vars

xlims = get(handles.mainplot, 'XLim');
slider_val = (xlims(1)+xlims(2))/2;
slider_min = get(handles.slider, 'Min');
slider_max = get(handles.slider, 'Max');
if slider_val < slider_min
    set(handles.slider, 'Min', slider_val);
end
if slider_val > slider_max
    set(handles.slider, 'Max', slider_val);
end


%set current slider value
set(handles.slider, 'Value',slider_val);

%%% Change width of slider on zoom. 
xwidth = xlims(2) - xlims(1);
slider_min = get(handles.slider, 'Min');
slider_max = get(handles.slider, 'Max');
scrollwidth = slider_max - slider_min;
set(handles.slider, 'sliderstep', [.1 xwidth/scrollwidth*2]);

function update_vc_slider

global handles vars

xlim = get (handles.vc_vplot, 'XLim');
xwidth = xlim(2) - xlim(1);

max_time=max(vars.vc_times);

if (max_time* 1000 < xwidth/2)
    set(handles.vc_slider, 'Max', xwidth/2 + 1);  % to make sure max is > min always
else
    set(handles.vc_slider, 'Max', max_time * 1000);
end



set(handles.vc_slider, 'Min', xwidth/2);
set(handles.vc_slider, 'Value', xlim(1) + xwidth/2);

x_max = get (handles.vc_slider, 'Max');
x_min = get (handles.vc_slider, 'Min');

if ( (xlim(1) < 0.001) & (xlim(2) >= max_time* 1000) )
     %set(handles.vc_slider, 'Visible', 'off');
else
set(handles.vc_slider, 'Visible', 'on');
end

stepsize = get(handles.vc_slider, 'SliderStep');
stepsize(2) = (xlim(2) - xlim(1)) / (x_max - x_min);
set(handles.vc_slider, 'SliderStep', stepsize);

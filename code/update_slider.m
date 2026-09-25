function update_slider

global handles vars

xlim = get (handles.varplot, 'XLim');
xwidth = xlim(2) - xlim(1);

if (vars.time * 1000 < xwidth/2)
    set(handles.slider, 'Max', xwidth/2 + 1);  % to make sure max is > min always
else
    set(handles.slider, 'Max', vars.time * 1000);
end

set(handles.slider, 'Min', xwidth/2);
set(handles.slider, 'Value', max(0,xlim(1)) + xwidth/2);

x_max = get (handles.slider, 'Max');
x_min = get (handles.slider, 'Min');

if ( (xlim(1) < 0.001) & (xlim(2) >= vars.time * 1000) )
     %set(handles.slider, 'Visible', 'off');
else
     set(handles.slider, 'Visible', 'on');
end

stepsize = get(handles.slider, 'SliderStep');
stepsize(2) = (xlim(2) - xlim(1)) / (x_max - x_min);
set(handles.slider, 'SliderStep', stepsize);

function moveslider

global handles vars

    xlims = get(handles.mainplot, 'xlim');
    xwidth = xlims(2) - xlims(1);
    new_mid = get(handles.slider, 'Value');
    new_max = new_mid + (.5*xwidth);
    new_min = new_mid - (.5*xwidth);
    set(handles.mainplot, 'Xlim', [new_min new_max]);
  
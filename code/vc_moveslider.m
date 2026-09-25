function vc_moveslider

global handles vars

    xlims = get(handles.vc_mainplot, 'xlim');
    xwidth = xlims(2) - xlims(1);
    new_mid = get(handles.vc_slider, 'Value');
    new_max = new_mid + (.5*xwidth);
    new_min = new_mid - (.5*xwidth);
    set(handles.vc_mainplot, 'Xlim', [new_min new_max]);
  
function vc_movevertslider

global handles vars

    ylims = get(handles.vc_mainplot, 'Ylim');
    ywidth = ylims(2) - ylims(1);
    new_mid = get(handles.vc_vertslider, 'Value');
    new_max = new_mid + (.5*ywidth);
    new_min = new_mid - (.5*ywidth);
    set(handles.vc_mainplot, 'Ylim', [new_min new_max]);
  
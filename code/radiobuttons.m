function radiobuttons(setting)
global vars handles
if setting == 1
   
    pan off
    zoom on   
    set(handles.zoombutton, 'ForegroundColor', 'r','value', 1);
    set(handles.panbutton,'ForegroundColor', 'k','value',  0);
    set(handles.cursorbutton, 'ForegroundColor', 'k','value',  0);
    if vars.vclampmode == 0
        axes(handles.mainplot);
        set(handles.zoom_instruction, 'visible', 'on');
        set(handles.pan_instruction, 'visible', 'off');
    else
        set(handles.vc_zoom_instruction, 'visible', 'on');
        set(handles.vc_pan_instruction, 'visible', 'off');
    end
end
if setting == 2
    
    zoom off
    pan on
    set(handles.zoombutton, 'ForegroundColor', 'k','value',  0);
    set(handles.panbutton,'ForegroundColor', 'r','value', 1);
    set(handles.cursorbutton, 'ForegroundColor', 'k','value', 0);
    if vars.vclampmode == 0
        axes(handles.mainplot)
        set(handles.zoom_instruction, 'visible', 'off');
        set(handles.pan_instruction, 'visible', 'on');
    else
         set(handles.vc_zoom_instruction, 'visible', 'off');
         set(handles.vc_pan_instruction, 'visible', 'on');
    end
end
if setting == 3
    zoom off
    pan off
    set(handles.zoombutton, 'ForegroundColor', 'k','value', 0);
    set(handles.panbutton,'ForegroundColor', 'k','value', 0);
    set(handles.cursorbutton, 'ForegroundColor', 'r','value', 1);
    if vars.vclampmode == 1
       set(handles.vc_zoom_instruction, 'visible', 'off');
       set(handles.vc_pan_instruction, 'visible', 'off');
    else
       set(handles.zoom_instruction, 'visible', 'off');
       set(handles.pan_instruction, 'visible', 'off');
    end
end
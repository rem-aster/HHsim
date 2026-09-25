function vc_zoom_hor
global handles vars

xlim = get(handles.vc_mainplot, 'XLim');
cursordata = get(handles.cursor, 'userdata');
  if strcmp(get(handles.cursor, 'visible'), 'on') ...
     & (cursordata.xval > xlim(1)) & (cursordata.xval < xlim(2))
      x_mid = cursordata.xval;
        xlimits(1) = (xlim(1) + x_mid)/2;
        xlimits(2) = (xlim(2) + x_mid)/2;
        set(handles.vc_vplot,'XLim',xlimits);
        set(handles.vc_mainplot,'XLim',xlimits);
  else
      x_mid = (xlim(1) + xlim(2))/2;
      xlimits(1) = (xlim(1) + x_mid)/2;
      xlimits(2) = (xlim(2) + x_mid)/2;
      set(handles.vc_vplot,'XLim',xlimits);
      set(handles.vc_mainplot,'XLim',xlimits);
  end
  
 if strcmp(get(handles.cursor, 'visible'),'on')
    userdata = get(handles.cursor, 'userdata');
    vc_reset_cursor_values(userdata.line_id, userdata.index);
end


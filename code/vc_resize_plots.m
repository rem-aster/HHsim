function vc_resize_plots (step)

  global handles vars;

  min_plot_rate = 1;
  max_plot_rate = 4;
  if (step == 1)
    % zoom out
    vars.plot_rate = vars.plot_rate + 1;
    if (vars.plot_rate >= max_plot_rate)
      set (handles.zoomoutbutton, 'Enable', 'off');
    
    end
    if (vars.plot_rate >= min_plot_rate + 1)
      set (handles.zoominbutton, 'Enable', 'on');
    end
  % else step is -1
  elseif (step == -1)
    % zoom in
    vars.plot_rate = vars.plot_rate - 1;
    if (vars.plot_rate == min_plot_rate)
      set (handles.zoominbutton, 'Enable', 'off');
    end
    if (vars.plot_rate == max_plot_rate -1)
      set (handles.zoomoutbutton, 'Enable', 'on');
    end
 
  end

  xwidth = vars.plot_rate * vars.plot_rate_mul;

  cursordata = get(handles.cursor, 'userdata');
  xlim = get (handles.vc_vplot, 'XLim');

  % determining the point to zoom
  if strcmp(get(handles.cursor, 'visible'), 'on') ...
     & (cursordata.xval > xlim(1)) & (cursordata.xval < xlim(2))
      zoompoint = cursordata.xval;
  else
      zoompoint = (xlim(1) + xlim(2))/2;
  end
  
  % if zooming in our out causes your left side to be less than zero
  if (zoompoint < xwidth/2)
      zoompoint = xwidth/2;
  end
 
  max_time=max(vars.vc_times);
  % in case you're zooming in and are centered on nothingness to the right
  if (zoompoint > max_time * 1000) & (step == -1)
    if (max_time * 1000 < xwidth/2)
      zoompoint = xwidth/2;
    else
      zoompoint = max_time * 1000;
    end
  end

  if (step == 0)
    zoompoint=vars.plot_rate*vars.plot_rate_mul/2;
  end

  vc_set_xaxis_limits( zoompoint );

  
  % for resizing the cursor
  if strcmp(get(handles.cursor, 'visible'), 'on')
    userdata = get(handles.cursor, 'UserData');
    vc_reset_cursor_values(userdata.line_id, userdata.index);
  end
  
  if vars.vc_slider_set_var == 0
      vc_slider_set;
      vc_slider_set_var = 1;
  end
  if vars.vc_vertslider_set_var == 0
      vc_vertslider_set;
      vc_vertslider_set_var = 1;
  end
  drawnow;


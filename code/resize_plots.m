function resize_plots (step)

     global handles vars;

     min_plot_rate = 1;
     max_plot_rate = 50;

     if (step == 1)
       % zoom out
       vars.plot_rate = vars.plot_rate + 1;
       if (vars.plot_rate == max_plot_rate)
         set (handles.zoomoutbutton, 'Enable', 'off');
       end
       if (vars.plot_rate == min_plot_rate + 1)
         set (handles.zoominbutton, 'Enable', 'on');
       end
     % else step is -1
     else
       % zoom in
       vars.plot_rate = vars.plot_rate - 1;
       if (vars.plot_rate == min_plot_rate)
         set (handles.zoominbutton, 'Enable', 'off');
       end
       if (vars.plot_rate == max_plot_rate -1)
         set (handles.zoomoutbutton, 'Enable', 'on');
       end
     end

  xwidth = 200 * vars.plot_rate * vars.deltaT_plot * 1e3;

  cursordata = get(handles.cursor, 'userdata');
  xlim = get (handles.varplot, 'XLim');

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
  
  % in case you're zooming in and are centered on nothingness to the right
  if (zoompoint > vars.time * 1000) & (step == -1)
    if (vars.time * 1000 < xwidth/2)
      zoompoint = xwidth/2;
    else
      zoompoint = vars.time * 1000;
    end
  end

  set_xaxis_limits( zoompoint );

  update_slider;
  
  % for resizing the cursor
  if strcmp(get(handles.cursor, 'visible'), 'on')
    userdata = get(handles.cursor, 'UserData');
    reset_cursor_values(userdata.line_id, userdata.index);
  end
  drawnow;

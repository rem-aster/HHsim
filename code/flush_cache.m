function flush_cache(h)
   
    global vars handles
  
    u = get(h, 'UserData');
    lines = u.lines;
    xval = vars.time;
    yvals = [generate_varplotval( get(handles.v1button, 'Value'), u.ptr) ...
            generate_varplotval( get(handles.v2button, 'Value'), u.ptr) ...
            generate_varplotval( get(handles.v3button, 'Value'), u.ptr) ];
        
            
            
    xwidth = 200 * vars.plot_rate*vars.deltaT_plot * 1e3;
    xlim = get(h,'XLim');
    if (xval * 1000 > xlim(2)) % shift the slider to the right
      set(handles.slider, 'Max', xlim(2) + xwidth/4);
      set(handles.slider, 'Value', xlim(2));
      set_xaxis_limits(xlim(2));
      update_slider
    end
    % now redraw the line
    xcoords = get(lines(1),'XData');
    xcoords(u.ptr+1-u.cachesize:u.ptr) = u.cachexdata;
    for i=1:length(lines)
      ycoords = get(lines(i),'YData');
      ycoords(u.ptr+1-u.cachesize:u.ptr) = u.cacheydata(i,:);
      set(lines(i),'XData',xcoords,'YData',ycoords);
    end
    u.cachexdata=[];
    u.cacheydata=[];
    u.cachecnt=0;
    u.cachedisp=0;
    set(h,'UserData',u)
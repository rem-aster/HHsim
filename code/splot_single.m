function splot_single(h,lindex,xval,yval)
  global vars handles

  u = get(h,'UserData');
  u.ptr = u.ptr + 1;
  lines = u.lines;
  
 
  
  
  if u.ptr > u.nbins
    xcoords = get(lines(lindex),'XData');
    nans = NaN * ones(1,200);
    u.nbins = u.nbins + 200;
    xcoords = [xcoords(1:end) nans];
    ycoords = get(lines(lindex),'YData');
    ycoords = [ycoords(1:end) nans];
    set(lines(lindex),'XData',xcoords,'YData',ycoords);
  end

  u.cachexdata=[u.cachexdata xval*1e3];
  u.cacheydata=[u.cacheydata yval];
  u.cachecnt=u.cachecnt+1;

  if (u.cachedisp==1 || u.cachecnt >= u.cachesize)
    xcoords = get(lines(lindex),'XData');

    xwidth = 200 * vars.plot_rate*vars.deltaT_plot * 1e3;
    xlim = get(h,'XLim');
    if (xval * 1000 > xlim(2)) % shift the slider to the right
    set(handles.slider, 'Max', xlim(2) + xwidth/4);
    set(handles.slider, 'Value', xlim(2));
    set_xaxis_limits(xlim(2));
    update_slider
    end

    % 1e3 converts seconds to milliseconds
    xcoords(u.ptr+1-u.cachesize:u.ptr) = u.cachexdata;
    ycoords = get(lines(lindex),'YData');
    ycoords(u.ptr+1-u.cachesize:u.ptr) = u.cacheydata(:);
    set(lines(lindex),'XData',xcoords,'YData',ycoords);
    u.cachexdata=[];
    u.cacheydata=[];
    u.cachecnt=0;
    u.cachedisp=0;

    set(h,'UserData',u)
    drawnow;
  else
    set(h,'UserData',u)
  end

function splot(h,xval,yvals)
  global vars handles

  u = get(h,'UserData');
  u.ptr = u.ptr + 1;
  lines = u.lines;

  if u.ptr > u.nbins
  % resize plot by lengthening XData/YData
  xcoords = get(lines(1),'XData');
    nans = NaN * ones(1,200);
    u.nbins = u.nbins + 200;
    xcoords = [xcoords(1:end) nans];
    for i=1:length(lines)
      ycoords = get(lines(i),'YData');
      ycoords = [ycoords(1:end) nans];
      set(lines(i),'XData',xcoords,'YData',ycoords);
    end
  end

% Cache points so we don't have to redraw the line every time
  u.cachexdata=[u.cachexdata xval*1e3];
  u.cacheydata=[u.cacheydata yvals'];
  u.cachecnt=u.cachecnt+1;
 
  set(h,'UserData',u)

  
% See if we need to redraw the line now
  if (u.cachedisp==1 || u.cachecnt >= u.cachesize)
 % time to redraw the line: first update the horizontal slider
    % 1e3 converts seconds to milliseconds
    flush_cache(h);
    drawnow;
  else
    set(h,'UserData',u)
  end

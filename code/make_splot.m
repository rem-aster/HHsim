function make_splot(h,nbins,xinit,ylim,colors)

  global vars

  nlines = length(colors);

  u.handle = h;
  u.nbins = nbins;
  u.ptr = 0;

  vals = NaN * ones(1,nbins);
  lines = [];
  hold on
  for i=1:nlines
    lines(1+end) = plot(vals,vals,'Color',colors{i});
  end

  % 1e3 converts seconds to milliseconds
  
  axis([xinit xinit+200*vars.plot_rate*vars.deltaT_max*1e3 ylim])

  u.lines = lines;
  u.cachexdata=[];
  u.cacheydata=[];
  u.cachecnt=0;
  u.cachedisp=0;
  u.cachesize=4;

  set(h,'UserData',u)

function h = make_valtext(varname,xpos,ypos,fmt,initval,scale)

  if any(initval=='_') | any(fmt=='_') % check for subscripted text
    axisoffset = 6;
  else
    axisoffset = 10;
  end

  fontsize = 12;
  if nargin<6, scale = NaN; end

  h = text(xpos,ypos+axisoffset,'','FontSize',fontsize);

  u.handle = h;
  u.varname = varname;
  u.scale = scale;
  u.fmt = fmt;

  set(h,'UserData',u)

  if nargin<5, initval = 0; end
  set_valtext(h,initval)

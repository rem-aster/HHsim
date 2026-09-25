function h = make_valbox(varname,xpos,ypos,valinit,valmin,valmax,scale, ...
			 setter,fmt,incrtype,incrval)
  h = uicontrol('Style','Edit','Units','pixel', ...
		'Position',[xpos ypos 50 20], ...
		'HorizontalAlignment','right', ...
		'ForegroundColor',[1 1 0], ...
		'BackgroundColor',[0 0 0], ...
		'CallBack','set_valbox;run_system(1)');

  u.handle = h;
  u.varname = varname;
  u.valinit = valinit;
  u.valmin = valmin;
  u.valmax = valmax;
  u.scale = scale;
  u.setter = setter;
  u.fmt = fmt;

  if (strcmp(incrtype,'+')|strcmp(incrtype,'*'))
    u.incrtype = incrtype;
    u.incrval = incrval;
    make_incrbutton(h,+1,incrtype,incrval);
    make_incrbutton(h,-1,incrtype,incrval);
  end

  set(h,'UserData',u)
  set(h,'Value',valinit);
  set(h,'String',sprintf(fmt,valinit))
 

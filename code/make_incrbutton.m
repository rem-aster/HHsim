function h = make_incrbutton(bh,incrdir,incrtype,incrval)

  u.button = bh;
  u.incrdir = incrdir;
  u.incrtype = incrtype;
  u.incrval = incrval;

  set(bh,'Units','pixels');
  pos = get(bh,'Position');

  aheight = 10;  % height in pixels
  if incrdir > 0
    adir = '>';
  else
    adir = '<';
  end;

  xp = pos(1)+pos(3)+5;
  yp = pos(2) + pos(4)/2 - (incrdir<0)*17;

  h = uicontrol('Style','PushButton','Position',[xp yp 15 15], ...
	'BackgroundColor',[0 0 0],'ForeGroundColor',[0.8 0.2 0.2], ...
	'String',adir, ...
	'UserData',u, ...
	'CallBack','call_incrbutton;run_system(1)');


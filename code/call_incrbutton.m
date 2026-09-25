function call_incrbutton

  h = gcbo;
  u = get(h,'UserData');

  hb = u.button;
  uv = get(hb,'Userdata');

  v = get(hb,'Value');

  if u.incrtype == '+'
    v = v + u.incrdir*u.incrval;
  elseif u.incrtype == '*'
    v = v * (u.incrval).^u.incrdir;
  else
    error('Invalid incrtype')
  end

  set(hb,'Value',v)
  set_valbox(hb)

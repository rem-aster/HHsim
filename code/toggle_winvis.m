function toggle_winvis(varname)

  global handles
  
  h = handles.([varname '_gates']);

  set_winvis(h,strcmp(get(h,'Visible'),'off'))

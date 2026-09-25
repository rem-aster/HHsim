function set_winvis(hwin,val)

  if val == 0
    vis = 'off';
  else
    vis = 'on';
  end

  set(hwin,'Visible',vis)

function recalc_EK

  global vars handles

  oldK = vars.EK;
  vars.EK = equilib(vars.Ki,vars.Ko,vars.T,+1);
  set_valtext(handles.EK,vars.EK)
  if (vars.EK*1000 > -95 && oldK*1000 <=-95) || (vars.EK*1000< -95 && oldK*1000 >=-95)
  resize_main_axis
  end
  
function recalc_ECl

  global vars handles

  oldCl = vars.ECl;
  vars.ECl = equilib(vars.Cli,vars.Clo,vars.T,-1);
  set_valtext(handles.ECl,vars.ECl)
  if (vars.ECl*1000 > -95 && oldCl*1000 <=-95) || (vars.ECl*1000< -95 && oldCl*1000 >=-95)
  resize_main_axis
  end

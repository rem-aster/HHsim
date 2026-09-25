function recalc_ENa

  global vars handles

  oldNa = vars.ENa;
  vars.ENa = equilib(vars.Nai,vars.Nao,vars.T,+1);
  set_valtext(handles.ENa,vars.ENa)
 if (vars.ENa*1000 > -95 && oldNa*1000 <=-95) || (vars.ENa*1000< -95 && oldNa*1000 >=-95)
  resize_main_axis
  end
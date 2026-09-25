function recalc_Vr

  global vars handles

  gxK  = vars.g_passK  * vars.switch_passK;
  gxNa = vars.g_passNa * vars.switch_passNa;
  gxCl = vars.g_passCl * vars.switch_passCl;

  vars.Vr =  (vars.EK*gxK + vars.ENa*gxNa + vars.ECl*gxCl) / ...
      max(gxK + gxNa + gxCl,1e-15);

  set_valtext(handles.Vr,vars.Vr)

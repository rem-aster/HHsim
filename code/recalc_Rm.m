function  recalc_Rm
    global vars handles
    vars.Rm = 1/(vars.g_passCl + vars.g_passK + vars.g_passNa);
    set_valtext(handles.Rm, vars.Rm/1e6)
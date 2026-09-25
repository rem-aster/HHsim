function update_gate(varname,gatename,gate)

  global vars

  alpha = evalrate(gate.alpha, vars.V*1e3);
  beta = evalrate(gate.beta, vars.V*1e3);

  delta = alpha - (alpha+beta) * gate.value;

  newval = min(1,max(0,gate.value + delta*vars.deltaT*1e3));

  % in main loop, so make this fast
  switch (varname)
    case 'HH_Na'
      if (gatename==1)
        vars.HH_Na.gate1.value=newval;
      else
        vars.HH_Na.gate2.value=newval;
      end
    case 'HH_K'
      if (gatename==1)
        vars.HH_K.gate1.value=newval;
      else
        vars.HH_K.gate2.value=newval;
      end
    case 'HH_user1'
      if (gatename==1)
        vars.HH_user1.gate1.value=newval;
      else
        vars.HH_user1.gate2.value=newval;
      end
  end

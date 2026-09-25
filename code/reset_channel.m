function reset_channel(varname)

  global handles vars

  initval = handles.(varname).ion.UserData;
  handles.(varname).ion.Value = initval;
  vars.(varname).ion = initval;
  
  reset_valbox(handles.(varname).gmax)

  for g = (1:2)
    if ((g == 2) & strcmp(varname,'HH_K'))
      return;
    end

    gate = ['gate' int2str(g)];

    initval = handles.(varname).(gate).exponent.UserData;
    handles.(varname).(gate).exponent.Value = initval;
    % need to use initval-1 below because exponents start at 0
    vars.(varname).(gate).expt = initval - 1;

    % for alpha
    initval = handles.(varname).(gate).alpha.fn.UserData;
    handles.(varname).(gate).alpha.fn.Value = initval;
    vars.(varname).(gate).alpha.fn = initval;
    reset_valbox(handles.(varname).(gate).alpha.c)
    reset_valbox(handles.(varname).(gate).alpha.th)
    reset_valbox(handles.(varname).(gate).alpha.s)

    % for beta
    initval = handles.(varname).(gate).beta.fn.UserData;
    handles.(varname).(gate).beta.fn.Value = initval;
    vars.(varname).(gate).beta.fn = initval;
    reset_valbox(handles.(varname).(gate).beta.c)
    reset_valbox(handles.(varname).(gate).beta.th)
    reset_valbox(handles.(varname).(gate).beta.s)

    recalc_gate_graph(vars.(varname).(gate))
  end

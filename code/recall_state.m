function recall_state(struct_num)

% recall saved state in voltage recording mode

global vars handles

if (~nargin)
  struct_num=0;
end

switch(struct_num)
  case 0
    restore_struct=vars.state_saved;
  case 1
    restore_struct=vars.state_modeswitch;
  case 2
    restore_struct=vars.state_equilibrium;
end

if (struct_num==2)
  curdata=restore_struct.varplotdata;
  curV=restore_struct.V;
else
  if (vars.iteration<1)
    vars.iteration=1;
  end

  if (restore_struct.cursorx<2)
    vars.varplotdata(:,vars.iteration)=vars.varplotdata(:,1);
    curV=vars.Vtot_hist(1,1);
  else
    vars.varplotdata(:,vars.iteration)=restore_struct.varplotdata(:);
    curV=restore_struct.V;
  end
  curdata=vars.varplotdata(:,vars.iteration);
end

vars.cursorx = restore_struct.cursorx;
vars.HH_Na.gate1.value=curdata(1);
vars.HH_Na.gate2.value=curdata(2);
vars.HH_K.gate1.value=curdata(3);
vars.I_leak=curdata(8);
vars.V=curV;

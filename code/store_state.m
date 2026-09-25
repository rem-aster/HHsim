function store_state(struct_num)

global vars

if (~nargin)
  struct_num=0;
end

switch(struct_num)
    % In voltage recording mode, "Save" button saves cursor-selected variable values
  case 0
    vars.state_saved.cursorx=vars.cursorx;
    vars.state_saved.V=vars.Vtot_hist(1,vars.cursorx);
    vars.state_saved.varplotdata=vars.varplotdata(:,vars.cursorx);
  case 1
    vars.state_modeswitch.cursorx=vars.cursorx;
    vars.state_modeswitch.V=vars.Vtot_hist(1,vars.cursorx);
    vars.state_modeswitch.varplotdata=vars.varplotdata(:,vars.cursorx);
  case 2
    vars.state_equilibrium.cursorx=vars.cursorx;
    vars.state_equilibrium.V=vars.Vtot_hist(1,vars.cursorx);
    vars.state_equilibrium.varplotdata=vars.varplotdata(:,vars.cursorx);
end

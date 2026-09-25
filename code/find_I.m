function ans = find_I

  global vars

 
    
    % all these currents are expressed in microamps,
    % i.e. microsiemens times volts

    % 1e6 factors convert siemens to microsiemens
    % 1e3 factor to convert to microvolts
  
    
    currentK  = vars.switch_passK*(vars.g_passK*1e6)*(vars.EK - vars.V);
    currentNa = vars.switch_passNa*(vars.g_passNa*1e6)*(vars.ENa - vars.V);
    currentCl = vars.switch_passCl*(vars.g_passCl*1e6)*(vars.ECl - vars.V);
    vars.I_leak = currentK + currentNa + currentCl;

    update_vgated_channel(vars.HH_Na);
    update_vgated_channel(vars.HH_K);
    update_vgated_channel(vars.HH_user1);

    % pronase effect
    if (vars.pronase==1)
      vars.HH_Na.gate2.value=1;
    end

    current_HH_Na = vars.gmult1 * vars.switch_HH_Na * channel_current(vars.HH_Na);
    current_HH_K = vars.gmult2 * vars.switch_HH_K * channel_current(vars.HH_K);
    current_HH_user1 = vars.switch_HH_user1 * channel_current(vars.HH_user1);

    % deltaT is multiplied by 1e3 to convert seconds to milliseconds
    % stimulus magnitude is multiplied by 1e6 to convert amps to microamps
    % membrane capacitance is multiplied by 1e9 to convert farads to nanofarads
    % therefore dV is in (1e3 * 1e6 / 1e9) volts, i.e. volts



    % limit deltaT from getting too small to prevent the capacitive
    % transient from growing too large in voltage clamp mode
    c_timestep = max(5e-5, vars.deltaT);

    ans = (vars.Cm * 1e9) * vars.deltaV / (c_timestep*1e3) - ...
          (vars.I_leak + current_HH_Na + current_HH_K + current_HH_user1);

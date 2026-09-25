function deltaV = find_dV

  global vars

    % all these currents are expressed in microamps,
    % i.e. microsiemens times volts

    % 1e6 factors convert siemens to microsiemens
    
    currentK  = vars.switch_passK*(vars.g_passK*1e6)*(vars.EK - vars.V);
    currentNa = vars.switch_passNa*(vars.g_passNa*1e6)*(vars.ENa - vars.V);
    currentCl = vars.switch_passCl*(vars.g_passCl*1e6)*(vars.ECl - vars.V);
    vars.I_leak = currentK + currentNa + currentCl;
    
    
    
    one = vars.g_passNa*1e6;
    two = vars.switch_passNa;
    three = vars.ENa - vars.V;
    currentNa;
    
    vars.I_leak;
    currentK;
    currentNa;
    currentCl;
    
    
    update_vgated_channel(vars.HH_Na);
    update_vgated_channel(vars.HH_K);
    update_vgated_channel(vars.HH_user1);

    % pronase effect
    if (vars.pronase==1)
      vars.HH_Na.gate2.value=1;
    end

    % again, 1e6 converts siemens to microsiemens
    
    current_HH_Na = vars.gmult1 * vars.switch_HH_Na * ...
        channel_current(vars.HH_Na);
    current_HH_K = vars.gmult2 * vars.switch_HH_K * ...
        channel_current(vars.HH_K);
    current_HH_user1 = vars.switch_HH_user1 * channel_current(vars.HH_user1);

    % deltaT is multiplied by 1e3 to convert seconds to milliseconds
    % stimulus magnitude is multiplied by 1e6 to convert amps to microamps
    % membrane capacitance is multiplied by 1e9 to convert farads to nanofarads
    % therefore dV is in (1e3 * 1e6 / 1e9) volts, i.e. volts
    
    deltaV = (vars.deltaT * 1e3) * ...
 	(currentNa + currentK + currentCl + ...
	 current_HH_Na + current_HH_K + current_HH_user1 + ...
	 (vars.stimtimer(1,1) * 1e6)) / (vars.Cm * 1e9);


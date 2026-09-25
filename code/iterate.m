function iterate

  global handles vars
  
 
  if vars.iterating == 1 
    return
  else
    vars.iterating = 1;
  end

  if vars.stopflag == 1   % sanity check; could be Inf but shouldn't be 1
    vars.stopflag = 0;
  end

    while 1
      if (vars.clearflag==1)
        vars.clearflag=0;
        clear_history;
      end
      if (vars.recallflag==1)
        vars.recallflag=0;
        recall_state;
      end

      changestepflag = 1;
      while (changestepflag)

        changestepflag = 0;

        % the integration uses a predictor-corrector method with a time
        % step allowed to vary depending on how well the predictor and
        % corrector coincide on the voltage graph

        % find_dV alters vars as though the next time step was taken
        initial_vars = vars;
        predictor_dV = find_dV;
        predictor_vars = vars;

        % the corrector step is the average of the predictor and next step
        corrector_dV = 0.5 * (predictor_dV + find_dV);

        % for all values that change at each time step
        % corrector_vars is the average of the predictor_vars and current vars
        corrector_vars = vars;
        corrector_vars.I_leak = 0.5 * (vars.I_leak + predictor_vars.I_leak); 
        corrector_vars.HH_Na.gate1.value = ...
          0.5 * (vars.HH_Na.gate1.value + predictor_vars.HH_Na.gate1.value); 
        corrector_vars.HH_Na.gate2.value = ...
          0.5 * (vars.HH_Na.gate2.value + predictor_vars.HH_Na.gate2.value); 
        corrector_vars.HH_K.gate1.value = ...
          0.5 * (vars.HH_K.gate1.value + predictor_vars.HH_K.gate1.value); 
  % REMOVE
  %      corrector_vars.HH_K.gate2.value = ...
  %        0.5 * (vars.HH_K.gate2.value + predictor_vars.HH_K.gate2.value); 
        corrector_vars.HH_user1.gate1.value = ...
          0.5 * (vars.HH_user1.gate1.value ...
           + predictor_vars.HH_user1.gate1.value); 
        corrector_vars.HH_user1.gate2.value = ...
          0.5 * (vars.HH_user1.gate2.value ...
           + predictor_vars.HH_user1.gate2.value); 

        % cut the time step in half if the error is too high
        % and redo the step calculation

        % the error value used is rather arbitrary
        errorval1 = abs(predictor_dV - corrector_dV);
        errorval2 = errorval1 / vars.deltaT;
  %      errorval3 = abs(predictor_vars.HH_Na.gate1.value - ...
  %          corrector_vars.HH_Na.gate1.value);
  %      errorval4 = abs(predictor_vars.HH_Na.gate2.value - ...
  %          corrector_vars.HH_Na.gate2.value);
        errorval5 = abs(predictor_vars.HH_K.gate1.value - ...
            corrector_vars.HH_K.gate1.value);
      % for debugging purposes
      %disp(sprintf('%0.5g %0.5g %0.5g %0.5g %0.5g', vars.time, vars.deltaT, ...
      %        errorval1, errorval2, errorval5));

      % remember to change the increase in vars.deltaT at the end of this function
      % if you use different errorvals  
        if ( errorval2 > 30 | errorval5 > 0.01)
            changestepflag = 1;
            vars = initial_vars;
            vars.deltaT = vars.deltaT / 2.0;
        end
      end

      vars = corrector_vars;

      vars.V = vars.V + corrector_dV;
  %    vars.Vhist(1:49) = vars.Vhist(2:50);
  %    vars.Vhist(50) = vars.V;

      vars.time = vars.time + vars.deltaT;
      vars.iteration = vars.iteration + 1;

      u = get(handles.varplot,'UserData');
      if (u.ptr < 1)     u.ptr = 1;  % this statement only temporarily sets u.ptr
          else u.ptr = u.ptr+1;      % splot does it permanently
          end
      if (u.ptr > vars.varplotdata_size)
        vars.varplotdata_size = vars.varplotdata_size + 200;
        extraspace = NaN * ones(length(vars.varplotdata(1:end,1)),200);
        vars.varplotdata = [vars.varplotdata extraspace];
        vars.Vtot_hist = [vars.Vtot_hist zeros(1,200)];
        vars.Itot_hist = [vars.Itot_hist zeros(1,200)];
        vars.time_hist = [vars.time_hist zeros(1,200)];
      end
      vars.Vtot_hist(1,u.ptr) = vars.V;
      vars.Itot_hist(1,u.ptr) = vars.stimtimer(1,1)*1e9;
      vars.time_hist(1,u.ptr) = vars.time;
      vars.varplotdata(1,u.ptr) = vars.HH_Na.gate1.value;
      vars.varplotdata(2,u.ptr) = vars.HH_Na.gate2.value;
      vars.varplotdata(3,u.ptr) = vars.HH_K.gate1.value;
      vars.varplotdata(4,u.ptr) = vars.gmult1 * vars.switch_HH_Na * ...
          channel_current(vars.HH_Na);
      vars.varplotdata(5,u.ptr) = vars.gmult2 * vars.switch_HH_K * ...
          channel_current(vars.HH_K);
      vars.varplotdata(6,u.ptr) = vars.gmult1 * (vars.HH_Na.gmax*1e6) * ...
          vars.HH_Na.gate1.value^vars.HH_Na.gate1.expt * ...
          vars.HH_Na.gate2.value^vars.HH_Na.gate2.expt;
      vars.varplotdata(7,u.ptr) = vars.gmult2 * (vars.HH_K.gmax*1e6) * ... 
          vars.HH_K.gate1.value^vars.HH_K.gate1.expt;
      vars.varplotdata(8,u.ptr) = -vars.I_leak;
      vars.varplotdata(9,u.ptr) = vars.HH_user1.gate1.value;
      vars.varplotdata(10,u.ptr) = vars.HH_user1.gate2.value;
      vars.varplotdata(11,u.ptr) = vars.switch_HH_user1 * channel_current(vars.HH_user1);
      vars.varplotdata(12,u.ptr) = vars.switch_HH_user1 * (vars.HH_user1.gmax*1e6) * ...
          vars.HH_user1.gate1.value ^ vars.HH_user1.gate1.expt * ...
        vars.HH_user1.gate2.value ^ vars.HH_user1.gate2.expt;

      % for scaling
      vars.varplotdata(4,u.ptr) = graph_scale(vars.varplotdata(4,u.ptr),4,1);
      vars.varplotdata(5,u.ptr) = graph_scale(vars.varplotdata(5,u.ptr),4,1);
      vars.varplotdata(6,u.ptr) = graph_scale(vars.varplotdata(6,u.ptr),5,1);
      vars.varplotdata(7,u.ptr) = graph_scale(vars.varplotdata(7,u.ptr),5,1);
      vars.varplotdata(8,u.ptr) = graph_scale(vars.varplotdata(8,u.ptr),6,1);
      vars.varplotdata(11,u.ptr) = graph_scale(vars.varplotdata(11,u.ptr),4,1);
      vars.varplotdata(12,u.ptr) = graph_scale(vars.varplotdata(12,u.ptr),5,1);

      % for debugging only
            vars.varplotdata(9,u.ptr) = vars.deltaT*10000;
            vars.varplotdata(10,u.ptr) = errorval2/20;
            vars.varplotdata(10,u.ptr) = errorval5*200;

      splot(handles.mainplot,vars.time, ...
            [1000*vars.V ...
            vars.stimtimer(1,1)*1e9-85])
        
            
            splot(handles.varplot,vars.time, ...
            [generate_varplotval( get(handles.v1button, 'Value'), u.ptr) ...
            generate_varplotval( get(handles.v2button, 'Value'), u.ptr) ...
            generate_varplotval( get(handles.v3button, 'Value'), u.ptr) ])


      if (u.ptr<50)
        Vchange=Inf;
      else
        lookfor=vars.time-0.005;
        while (vars.time_hist(vars.last_time)<lookfor)
          vars.last_time=vars.last_time+1;
        end
        Vchange=max(abs(vars.Vtot_hist(vars.last_time:u.ptr)-vars.V));
      end

      if vars.stopflag == 1 | ...
         (vars.stopflag == 0 & vars.nudge_time<=vars.time & Vchange < 1e-3 & ...
         vars.stimtimer(1,1) == 0 & size(vars.stimtimer,2)==1)
        vars.stopflag = 0;
        vars.iterating = 0;
        if (vars.quitflag), close_finally; end
        return
      end

      vars.stimtimer(2,1) = vars.stimtimer(2,1) - vars.deltaT;
      if vars.stimtimer(2,1) <= 0
        vars.stimtimer = vars.stimtimer(:,2:end);
      end

      % double the step size (up to a certain point)
      % if it falls below a certain rate of error
      vars.deltaT_max = max_deltaT(0);
      if ( (errorval2 < 10) & (errorval5 < 0.003) ...
         & (vars.deltaT < vars.deltaT_max) )
          vars.deltaT = vars.deltaT * 2;
      end
    end

function vc_iterate

    global handles vars

    %  if vars.iterating == 1 % if user hits Run while we're already running?
    %    return
    %  else
    %    vars.iterating = 1;
    %  end

    if vars.stopflag == 1   % sanity check; could be Inf but shouldn't be 1
        vars.stopflag = 0;
    end

    vars.vc_time=0;
    vars.deltaV=0;
    vars.V=vars.vc_timer(1,1);

    set(handles.runbutton,'BackgroundColor','y');
    highrescnt=0;

    %stabilize the current so we're at a true equilibrium
    vars.V=vars.vc_timer(1,1);
    vars.deltaT=1e-4;
    vc_stabilize;
    vars.I=find_I;

    %%% Main loop
    vars.deltaT=1e-5;

    while 1

        % the integration uses a predictor-corrector method with a time
        % step allowed to vary depending on how well the predictor and
        % corrector coincide on the voltage graph
        % find_I alters vars as though the next time step was taken

        predictor_I = find_I;
        predictor_vars = vars;

        % the corrector step is the average of the predictor and next step
        corrector_I = 0.5 * (predictor_I + find_I);

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

        corrector_vars.HH_user1.gate1.value = ...
            0.5 * (vars.HH_user1.gate1.value ...
                   + predictor_vars.HH_user1.gate1.value); 
        corrector_vars.HH_user1.gate2.value = ...
            0.5 * (vars.HH_user1.gate2.value ...
                   + predictor_vars.HH_user1.gate2.value); 

        vars = corrector_vars;
        vars.I = corrector_I;

        vars.vc_iteration (vars.vc_numcurves) = ...
                vars.vc_iteration (vars.vc_numcurves) + 1;

            u = get(handles.vc_vplot,'UserData');
            if (u.ptr < 1)     u.ptr = 1;  % this statement only temporarily sets u.ptr
            else u.ptr = u.ptr+1;          % splot does it permanently
            end
            %check varplot data size. increase size if needed
            if (u.ptr > vars.vc_varplotdata_size)
                vars.vc_varplotdata_size = vars.vc_varplotdata_size + 200;
                extraspace = NaN * ones(length(vars.vc_varplotdata(1:end,1)),200);
                vars.vc_varplotdata = [vars.vc_varplotdata extraspace];
            end

            InA=vars.I*1e3;
            if (vars.deltaV==0)
                if (InA > vars.vc_ymax)
                    vars.vc_ymax=InA*1.2;
                    set(handles.vc_mainplot,'YLim',[vars.vc_ymin vars.vc_ymax]*1.2);
                elseif (InA < vars.vc_ymin)
                    vars.vc_ymin=InA*1.2;
                    set(handles.vc_mainplot,'YLim',[vars.vc_ymin vars.vc_ymax]*1.2);
                end
            end

            % plot current (I) data 
            vars.vc_varplotdata(vars.vc_numcurves,u.ptr) = InA;
            %voltage step value
            vars.vc_varplotdata(vars.vc_numcurves+vars.vc_maxc,u.ptr) = vars.vc_timer(1,1)*1e3;

            % plot time
            vars.vc_varplotdata(vars.vc_numcurves+vars.vc_maxc*2,u.ptr) = vars.vc_time;

            % plot to both axes
            splot_single(handles.vc_mainplot, vars.vc_numcurves, vars.vc_time, ...
                         vars.vc_varplotdata(vars.vc_numcurves,u.ptr));
            splot_single(handles.vc_vplot, vars.vc_numcurves, vars.vc_time, ...
                         vars.vc_varplotdata(vars.vc_numcurves+vars.vc_maxc,u.ptr));

            % reduce the time resolution if we're far enough past a voltage change
            if (highrescnt==91), vars.deltaT=1e-5; end
            if (highrescnt==1), vars.deltaT=1e-5;  end
            highrescnt=highrescnt-1;

            % advance the simulation time and check for voltage change
            vars.vc_timer(2,1) = vars.vc_timer(2,1) - vars.deltaT;
            vars.vc_time = vars.vc_time + vars.deltaT;
            oldvoltage=vars.vc_timer(1,1);
            %if abs(vars.vc_timer(2,1)) <= 0.0005
            %    fprintf('time=%f timer=%g deltaT=%g voltage=%f\n', ...
            %            vars.vc_time, vars.vc_timer(2,1), vars.deltaT, vars.V)
            %end
            if vars.vc_timer(2,1) <= -1e-7  % should be 0; fudge for floating point roundoff
                vars.vc_timer = vars.vc_timer(:,2:end);  % pop this segment
                vars.V = vars.vc_timer(1,1);
                vars.vc_time = vars.vc_time - vars.deltaT + 1e-10;
                vars.deltaT = 1e-10;
                highrescnt = 93;  % do a few steps at 1e-10 and then 90 at 1e-5
                % fprintf('--> time=%f timer=%g deltaT=%g voltage=%f\n', ...
                % vars.vc_time, vars.vc_timer(2,1), vars.deltaT, vars.V)
            end
            vars.deltaV = vars.V - oldvoltage;

        if vars.stopflag == 1 | ...
                (vars.vc_timer(1,1) == 0 & size(vars.vc_timer,2)==1)
            if (vars.stopflag == 1), vars.curve_aborted=1; end
            vars.stopflag = 0;
            vars.iterating = 0;
            % rescale x axis
            vars.vc_times(vars.vc_numcurves)=vars.vc_time;
            vars.plot_rate_mul=max(vars.vc_times)*1e3/3;
            vc_resize_plots(0);
            if (vars.quitflag), close_finally; end
            set(handles.runbutton,'BackgroundColor','g');
            return
        end
    end

    set(handles.runbutton,'BackgroundColor','g');

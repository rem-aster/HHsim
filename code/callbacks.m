function callbacks(ndx, arg)

global vars handles

switch(ndx)
  % mainwindow
  case 1      % membutton
    set_winvis(handles.memwindow, get(handles.membutton,'Value'));
  case 2      % chanbutton
    set_winvis(handles.chanwindow, get(handles.chanbutton,'Value'));
  case 3      % stimbutton
    set_winvis(handles.stimwindow, get(handles.stimbutton,'Value'));
  case 4      % drugbutton
    set_winvis(handles.drugwindow, get(handles.drugbutton,'Value'));
  case 5      % stim1button
    begin_stimulus(handles.stim1);
    run_system(0);
  case 6      % stim2button
    begin_stimulus(handles.stim2);
    run_system(0);
  case 7      % clearbutton
    if (vars.vclampmode==0)
      vars.clearflag=1;
      run_system(1);
    else
      vc_clear;
    end
  case 8      % recallbutton
    vars.recallflag=1;
    run_system(1);

  % stimwindow
  case 9      % sliders
    update_stimslider(gcbo);
    redisplay_stim(handles.(['stim' int2str(arg)]))
  case 10     % boxes
    update_stimbox(gcbo);
    redisplay_stim(handles.(['stim' int2str(arg)]))
  case 11     % reset
    reset_stimulus(handles.stim1);
    reset_stimulus(handles.stim2);
  case 12     % hide
    set_winvis(gcf,0);
    set(handles.stimbutton,'Value',0);

  % run
  case 13
    toggle_winvis(handles.memwindow);
  case 14
    toggle_winvis(handles.chanwindow);
  case 15
    toggle_winvis(handles.stimwindow);
  case 16
    toggle_winvis(handles.drugwindow);
 
  % memwindow
  case 17    % reset
    reset_memparams;
    run_system(1);
  case 18    % hide
    set_winvis(gcf,0);
    set(handles.membutton,'Value',0);

  % setup drugs
  case 19    % reset
    reset_drugs;
    indicate_drugs_active;
    run_system(1);
  case 20    % hide
    set_winvis(gcf,0);
    set(handles.drugbutton,'Value',0);

  % setup channels
  case 21    % reset
    reset_chanparams;
  case 22    % hide
    set_winvis(gcf,0);
    set(handles.chanbutton,'Value',0);

  % setup channels
  case 23    % switch mode
    newmode=get(handles.modebutton, 'Value')==2;
    if (vars.vclampmode~=newmode)
      vars.vclampmode=newmode;
      switch_mode
    end
  % vclamp button
  case 24
    set_winvis(handles.vclampwindow, get(handles.vc_button,'Value'));

  % vclamp window
  case 25      % sliders
    update_stimslider(gcbo);
    update_vc_userstrings(gcbo);
    redisplay_voltage(handles.vc_curve);
  case 26     % boxes
    update_stimbox(gcbo);
    update_vc_userstrings(get(gcbo,'UserData'));
    redisplay_voltage(handles.vc_curve);
  case 27     % reset
    reset_voltage;
    vc_varselect(3);
  case 28     % hide
    set_winvis(gcf,0);
    set(handles.vc_button,'Value',0);
  % main window vclamp
  case 29     % run with voltage clamp
    vc_run
%  case 30     % voltage plot click
%    if strcmp(get(handles.cursor,'visible'),'on')
%      set_cursor_vis('off');
%    else
%      click_point = get(handles.vc_vplot,'CurrentPoint'); 
%      if mod (handles.vc_varselected, 2)
%        set(handles.vc_varval_box, 'String', ...
%          num2str(round(click_point(1,2))));
%      else
%        set(handles.vc_varval_box, 'String', ...
%          num2str(round(click_point(1,1))));
%      end
%    end

  case 31     % vertical Y-axis zoom in
    ylims=get(handles.vc_mainplot,'YLim');
    %zoom stack for easy zoomout
    vars.vc_ylims{length(vars.vc_ylims)+1} = ylims;
   if strcmp(get(handles.cursor,'visible'),'on')
      cursordata=get(handles.cursor,'userdata');
      if (cursordata.line_id<=vars.vc_maxc)
        yval=cursordata.yval;
        ylims=ylims+yval;
       end
      set(handles.vc_mainplot,'YLim',ylims*0.5);
      vc_reset_cursor_values(cursordata.line_id, cursordata.index);
      vc_vertslider_val;
    else
      set(handles.vc_mainplot,'YLim',ylims*0.5);
      vc_vertslider_val;
    end
    
    
  case 32     % vertical Y-axis zoom out
    ylims=get(handles.vc_mainplot,'YLim');
       %use zoom-in ylims first, if they don't exist, multiply limits by 1.5
    if(isempty(vars.vc_ylims))
        set(handles.vc_mainplot,'YLim',ylims*1.5);
        vc_vertslider_val;
    else
        set(handles.vc_mainplot,'YLim', vars.vc_ylims{length(vars.vc_ylims)});
        temp = cell(1,length(vars.vc_ylims)-1);
        if(~isempty(temp))           
            for i = 1:length(temp)
                temp{i} = vars.vc_ylims{i};
            end
            vars.vc_ylims = temp;
        else
            vars.vc_ylims = temp;   
        end
        vc_vertslider_val;
    end 
    if strcmp(get(handles.cursor,'visible'),'on')
      userdata = get(handles.cursor, 'UserData');
      vc_reset_cursor_values(userdata.line_id, userdata.index);
    end 
    
  case 33    % vc_varval_box updated
    trim_vc_values;
    update_vc_box_slider;
    vc_varselect(handles.vc_varselected);
  case 34 %translate up 
    ylims = get(handles.vc_mainplot, 'YLim');
    diff = ylims(2) - ylims(1);
    set(handles.vc_mainplot, 'YLim', ylims+(.1*diff));
  case 35 %translate up 
    ylims = get(handles.vc_mainplot, 'YLim');
    diff = ylims(2) - ylims(1);
    set(handles.vc_mainplot, 'YLim', ylims-(.1*diff)); 
        
  case 36     % vertical Y-axis zoom in
    xlims=get(handles.vc_mainplot,'XLim');
    %zoom stack for easy zoomout
    vars.vc_xlims{length(vars.vc_xlims)+1} = xlims;
   if strcmp(get(handles.cursor,'visible'),'on')
      cursordata=get(handles.cursor,'userdata');
      if (cursordata.line_id<=vars.vc_maxc)
        xval=cursordata.xval;
        xlims=xlims+xval;
       end
      set(handles.vc_mainplot,'XLim',xlims*0.5);
      vc_reset_cursor_values(cursordata.line_id, cursordata.index);
   else
      mid = (xlims(2) + xlims(1))/2;
      xlims = mid+xlims;
      set(handles.vc_mainplot,'XLim',xlims*0.5);
    end
    
    
    
 
    case 37
        xlims = get(handles.vc_mainplot, 'XLim');
        if(isempty(vars.vc_xlims))
            set(handles.vc_mainplot, 'XLim', xlims*1.05);
        else
          set(handles.vc_mainplot,'XLim', vars.vc_xlims{length(vars.vc_xlims)});
          temp = cell(1,length(vars.vc_xlims)-1);
          if(~isempty(temp))           
              for i = 1:length(temp)
                 temp{i} = vars.vc_xlims{i};
              end
             vars.vc_xlims = temp;
          else
             vars.vc_xlims = temp;           
          end
        end 
       if strcmp(get(handles.cursor,'visible'),'on')
         userdata = get(handles.cursor, 'UserData');
        vc_reset_cursor_values(userdata.line_id, userdata.index);
      end 
end


function update_vc_userstrings(obj)
global handles vars
idx=0;
for i=1:length(handles.vc_curve.sliders)
  if (obj==handles.vc_curve.sliders(i)), idx=i; end
end
if (idx==0), return; end

str=handles.vc_curve.user_strings{idx};
nums=str2num(str);
nums(1)=get(obj,'Value');
handles.vc_curve.user_strings{idx}=num2str(nums);

if (idx==handles.vc_varselected)
  set(handles.vc_varval_box,'String', handles.vc_curve.user_strings{idx});
  set(handles.vc_helpnote1,'String',[handles.vc_labels{idx} ' ' handles.vc_curve.user_strings{idx}]);
end

function update_vc_box_slider
global handles vars
varval_str=get(handles.vc_varval_box, 'String');
varval_arr=str2num(varval_str);
if (length(varval_arr)<1), varval_arr=[0]; end
varval_arr=max(min(varval_arr,100),-90);
idx=handles.vc_varselected;
set(handles.vc_varval_box,'String',num2str(varval_arr));
set(handles.vc_curve.sliders(idx),'Value',varval_arr(1));
update_stimslider(handles.vc_curve.sliders(idx));


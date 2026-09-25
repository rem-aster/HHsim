function switch_mode

global vars handles

set_cursor_vis('off');

vars.time = 0;
vars.stopflag = 0;
vars.quitflag = 0;
vars.plot_rate = 3;
vars.iteration = 0;
vars.clearflag=0;
vars.recallflag=0;

set(handles.zoominbutton,'Enable','on');
set(handles.zoomoutbutton,'Enable','on');

if (vars.vclampmode==0)
  % enter voltage recording mode
  vars.V = -63.39/1000;
  set(handles.zoom_obj, 'ActionPostCallback', 'slider_val');
  set(handles.slider,'visible','on');
  set(handles.stimbutton,'visible','on');
  set(handles.vc_zoom_instruction, 'visible', 'off');
  set(handles.vc_pan_instruction, 'visible', 'off');
  if (get(handles.stimbutton,'Value')~=0)
    set(handles.stimwindow,'Visible','on');
  end
  set(handles.vc_button,'visible','off');
  set(handles.vclampwindow, 'Visible', 'off');

  set(handles.stim1button,'enable','on');
  set(handles.stim2button,'enable','on');
  set(handles.recallbutton,'enable','on');
  set(handles.runbutton,'CallBack','run_system(2)');
  set(handles.runbutton,'BackgroundColor',[0.4 1 0.4]);
  set(handles.nudgebutton,'enable','on');

  show_splot(handles.mainplot);
  show_splot(handles.varplot);
  hide_splot(handles.vc_mainplot);
  hide_splot(handles.vc_vplot);

  set(handles.v1axislabel,'visible','on');
  set(handles.v2axislabel,'visible','on');
  set(handles.v3axislabel,'visible','on');
  set(handles.v1button,'visible','on');
  set(handles.v2button,'visible','on');
  set(handles.v3button,'visible','on');
  set(handles.v1toptext,'visible','on');
  set(handles.v2toptext,'visible','on');
  set(handles.v3toptext,'visible','on');
  set(handles.v1bottomtext,'visible','on');
  set(handles.v2bottomtext,'visible','on');
  set(handles.v3bottomtext,'visible','on');
  set(handles.highlabeltext,'visible','on');
  set(handles.lowlabeltext,'visible','on');
  set(handles.vc_slider,'visible','off');

  set(handles.vc_mainplot,'visible','off');
  set(handles.vc_vplot,'visible','off');

  set(handles.yzoominbutton,'visible','off');
  set(handles.yzoomoutbutton,'visible','off');
   set(handles.zoominbutton, 'visible', 'off');
  set(handles.zoomoutbutton, 'visible', 'off');
  set(handles.zoominbutton,'CallBack','resize_plots(-1)');
  set(handles.zoomoutbutton,'CallBack','resize_plots(1)');

  set(handles.vc_helpnote1,'visible','off');
  set(handles.vc_helpnote2,'visible','off');
  set(handles.transupbutton, 'visible', 'off');
  set(handles.transdownbutton, 'visible', 'off');
  set(handles.vc_vertslider, 'visible', 'off');
  radiobuttons(3);
  recall_state(1);
  clear_history;  
  run_system(1);
  

else % enter voltage clamp mode
  set(handles.zoom_obj, 'ActionPostCallback', 'vc_slider_val');
  vars.vertslider_iter = 0;
  vars.move_slider = 0;
  vc_vertslider_set;
  vc_vertslider_val;
  vc_slider_set;
  vc_slider_val;
  set(handles.zoom_instruction, 'visible', 'off');
  set(handles.pan_instruction, 'visible', 'off');
  vars.V = vars.vc_timer(1,1);
  run_system(3);
  store_state(1);
  store_state(2);

  vars.plot_rate_mul=1;

  set(handles.stimbutton,'visible','off');
  set(handles.vc_button,'visible','on');
  if (get(handles.vc_button,'Value')~=0)
    set(handles.vclampwindow,'Visible','on');
  end
  set(handles.stimwindow, 'Visible', 'off');

  set(handles.stim1button,'enable','off');
  set(handles.stim2button,'enable','off');
  set(handles.recallbutton,'enable','off');
  set(handles.runbutton,'CallBack','callbacks(29)');
  set(handles.nudgebutton,'enable','off');

  hide_splot(handles.mainplot);
  hide_splot(handles.varplot);
  show_splot(handles.vc_mainplot);
  show_splot(handles.vc_vplot);

  set(handles.v1axislabel,'visible','off');
  set(handles.v2axislabel,'visible','off');
  set(handles.v3axislabel,'visible','off');
  set(handles.v1button,'visible','off');
  set(handles.v2button,'visible','off');
  set(handles.v3button,'visible','off');
  set(handles.v1toptext,'visible','off');
  set(handles.v2toptext,'visible','off');
  set(handles.v3toptext,'visible','off');
  set(handles.v1bottomtext,'visible','off');
  set(handles.v2bottomtext,'visible','off');
  set(handles.v3bottomtext,'visible','off');
  set(handles.highlabeltext,'visible','off');
  set(handles.lowlabeltext,'visible','off');
  set(handles.slider,'visible','off');

  set(handles.vc_mainplot,'visible','on');
  set(handles.vc_vplot,'visible','on');

  set(handles.yzoominbutton,'visible','off');
  set(handles.yzoomoutbutton,'visible','off');
  
  set(handles.zoominbutton, 'visible', 'off');
  set(handles.zoomoutbutton, 'visible', 'off');
  set(handles.zoominbutton,'CallBack','vc_resize_plots(-1)');
  set(handles.zoomoutbutton,'CallBack','vc_resize_plots(1)');

  set(handles.vc_helpnote1,'visible','on');
  set(handles.vc_helpnote2,'visible','on');
  set(handles.vc_vertslider, 'visible', 'on');
 % set(handles.transupbutton, 'visible', 'on');
 % set(handles.transdownbutton, 'visible', 'on');
  set(handles.vc_slider,'visible','on');

    

  
  vc_clear;

  set(handles.vc_varval_box, 'String', ...
      handles.vc_curve.user_strings{handles.vc_varselected});
  radiobuttons(3);
end

resize_main
radiobuttons(3);

function hide_splot(plot_handle)
  set(plot_handle,'visible','off');
  userdata=get(plot_handle,'UserData');
  for i=1:length(userdata.lines)
    set(userdata.lines(i),'visible','off');
  end

function show_splot(plot_handle)
  set(plot_handle,'visible','on');
  userdata=get(plot_handle,'UserData');
  for i=1:length(userdata.lines)
    set(userdata.lines(i),'visible','on');
  end

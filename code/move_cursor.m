function move_cursor(button_pushed)

global handles vars

userdata = get(handles.cursor, 'UserData');
index = userdata.index;
line_id = userdata.line_id;

if (vars.vclampmode==0)
  if line_id <= 2
      userdata = get(handles.mainplot,'userdata');
      line_data = userdata.lines(line_id);
  else
      userdata = get(handles.varplot,'userdata');
      line_data = userdata.lines(line_id - 2);
  end

  xdata = get(line_data, 'Xdata');
  ydata = get(line_data, 'Ydata');
  numpoints = length(xdata);

  % moving the cursor
  if (button_pushed == 0)
          line_id = mod(line_id, 5) + 1;
  else 
    xlim = get(handles.mainplot, 'Xlim');
    if abs(button_pushed) < 2  % move by one time step
      newindex = index + sign(button_pushed);
      if ((newindex > 0) & (index <= numpoints) & ...
          1)
          %          (xdata(index+sign(button_pushed)) < xlim(2)) & ...
          %(xdata(index+sign(button_pushed)) > xlim(1)))
          index = index + button_pushed;
      end
    else  % move to the nearest max or min
      if (index+sign(button_pushed) <= 0 | ...
          index+sign(button_pushed) > numpoints)
          return
      end
      original_slope_sign = sign(button_pushed) * ...
          sign(ydata(index+sign(button_pushed)) - ydata(index));
      slope_sign = original_slope_sign;
      while ((slope_sign == original_slope_sign) & (index + sign(button_pushed) >= 1) & ...
             1)
          %         (xdata(index+sign(button_pushed)) < xlim(2)) & ...
          %         (xdata(index+sign(button_pushed)) > xlim(1)) )
          index = index + sign(button_pushed);
          if (index+sign(button_pushed) == 0)    break;   end;
          slope_sign = sign(button_pushed) * ...
              sign(ydata(index+sign(button_pushed)) - ydata(index));
      end
    end
  end
  reset_cursor_values(line_id, index);

else  % vclamp mode
  if line_id <= vars.vc_maxc 
      userdata = get(handles.vc_mainplot,'userdata');
      line_data = userdata.lines(line_id);
  else
      userdata = get(handles.vc_vplot,'userdata');
      line_data = userdata.lines(line_id - vars.vc_maxc);
  end

  xdata = get(line_data, 'Xdata');
  ydata = get(line_data, 'Ydata');
  numpoints = length(xdata);

  % moving the cursor
  if (button_pushed == 0)
          line_id = mod(line_id, vars.vc_maxc*2) + 1;
  else 
    xlim = get(handles.vc_mainplot, 'Xlim');
    if abs(button_pushed) < 2  % move by one time step
      newindex = index + sign(button_pushed);
      if ((newindex > 0) & ...
          (newindex <= numpoints) & ...
          1)
          %          (xdata(index+sign(button_pushed)) < xlim(2)) & ...
          %          (xdata(index+sign(button_pushed)) > xlim(1)))
          index = index + sign(button_pushed);
      end
    else  % move to the nearest max or min
      if (index+sign(button_pushed) == 0 | ...
          index+sign(button_pushed) == numpoints)
          return
      end
      original_slope_sign = sign(button_pushed) * ...
          sign(ydata(index+sign(button_pushed)) - ydata(index));
      slope_sign = original_slope_sign;
      while (slope_sign == original_slope_sign) & ...
          (index + sign(button_pushed) > 0) & ...
          (index + sign(button_pushed) < numpoints)
          %         (xdata(index+sign(button_pushed)) < xlim(2)) & ...
          %         (xdata(index+sign(button_pushed)) > xlim(1)) )
          index = index + sign(button_pushed);
          if index+sign(button_pushed) == 0 | index+sign(button_pushed) > numpoints
              break
          end
          slope_sign = sign(button_pushed) * ...
              sign(ydata(index+sign(button_pushed)) - ydata(index));
      end
    end
  end

  vc_reset_cursor_values(line_id, index);
end

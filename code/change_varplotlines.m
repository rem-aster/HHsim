function change_varplotlines

global vars handles

h = get(handles.varplot, 'UserData');
if(h.ptr >=50)
  h.cachexdata = [];
  h.cacheydata = [];
  h.cachecnt = 3;
  set(handles.varplot, 'userdata', h);
end
set(h.lines(1),'YData',vars.varplotdata(get(handles.v1button,'Value'),1:end));
set(h.lines(2),'YData',vars.varplotdata(get(handles.v2button,'Value'),1:end));
set(h.lines(3),'YData',vars.varplotdata(get(handles.v3button,'Value'),1:end));

% setting the high and low values

[v1top,v1bot] = rangestring(get(handles.v1button,'Value'));
set(handles.v1toptext,'String',v1top)
set(handles.v1bottomtext,'String',v1bot)

[v2top,v2bot] = rangestring(get(handles.v2button,'Value'));
set(handles.v2toptext,'String',v2top)
set(handles.v2bottomtext,'String',v2bot)

[v3top,v3bot] = rangestring(get(handles.v3button,'Value'));
set(handles.v3toptext,'String',v3top)
set(handles.v3bottomtext,'String',v3bot)


% set the y-axis tick labels

if ~isempty(v1top)
  yaxtop = v1top; yaxbot = v1bot;
elseif ~isempty(v2top)
  yaxtop = v2top; yaxbot = v2bot;
else
  yaxtop = v3top; yaxbot = v3bot;
end

if (isempty(v1top) | strcmp(v1top,yaxtop)) & ...
      (isempty(v2top) | strcmp(v2top,yaxtop)) & ...
      (isempty(v3top) | strcmp(v3top,yaxtop))
  set(handles.varplot,'YTickLabel',{yaxbot,yaxtop})
else
  set(handles.varplot,'YTickLabel',{'Low','High'})
end

% Since backing store is turned off, lines aren't redrawn automatically.
% Twiddle Xlimits to force redrawing.
xl = get(handles.varplot,'Xlim');
set(handles.varplot,'Xlim',[-10 -5])
set(handles.varplot,'Xlim',xl)

% re-do the axis labels

labels = get(handles.v1button,'String');

set(handles.v1axislabel,'String',labels{get(handles.v1button','Value')})
set(handles.v2axislabel,'String',labels{get(handles.v2button','Value')})
set(handles.v3axislabel,'String',labels{get(handles.v3button','Value')})

for h = [handles.v1axislabel handles.v2axislabel handles.v3axislabel]
  if strcmp(get(h,'String'),'blank')
    set(h,'Visible','off')
  else
    set(h,'Visible','on')
  end
end


% re-compute the cursor display if cursor is visible

if strcmp(get(handles.cursor,'visible'),'on')
    userdata = get(handles.cursor, 'userdata');
    reset_cursor_values(userdata.line_id, userdata.index);
end

  u = get(handles.varplot,'UserData');
         
drawnow

return

%%%%%%%%%%%%%%%%

function [top,bot] = rangestring(varno)
switch varno
  case {1, 2, 3, 9, 10}
    top = '1';
    bot = '0';
  case {4, 5, 11}
    top = '0.75 uA';
    bot = '-0.75 uA';
  case {6, 7, 12}
    top = '30 uS';
    bot = '0 uS';
  case {8}
    top = '0.05 uA';
    bot = '-0.05 uA';
  otherwise
    top = '';
    bot = '';
end   

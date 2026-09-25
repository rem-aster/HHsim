function set_valbox(h,val)

  global vars handles

  if nargin == 0
    h = gcbo;
    v = str2num(get(h,'String'));
    if isempty(v)
      v = get(h,'Value');
    end
  elseif nargin == 1
    v = get(h,'Value');
  else
    v = val;
  end

  u = get(h,'UserData');
  v = max(u.valmin,min(u.valmax,v(1)));

  set(h,'Value',v)
  set(h,'String',sprintf(u.fmt,v))
  if (abs(v - u.valinit) < 1e-15) | (get(h,'Parent') == handles.HH_user1_gates)
    set(h,'BackgroundColor',[0 0 0])
  else
    set(h,'BackgroundColor',[0.6 0.2 0.2])
  end
  drawnow

  if isstr(u.varname)
    vars.(u.varname) = v*u.scale;
  elseif iscell(u.varname)
    if length(u.varname) == 2
      vars.(u.varname{1}).(u.varname{2}) = v * u.scale;
    elseif length(u.varname) == 4
      vars.(u.varname{1}).(u.varname{2}).(u.varname{3}).(u.varname{4}) = v * u.scale;
    end
  else
    error('*** bad call to set_valbox ***')
  end

  if isa(u.setter, 'function_handle')
    feval(u.setter)
  elseif isstr(u.setter)
    eval(u.setter)
  end

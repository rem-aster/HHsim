function set_channel_button(name,val)

global vars handles

obj = handles.(['button_' name]);

if nargin < 2
  val = get(obj,'Value');
end

vars.(['switch_' name]) = val;

color_button(obj)

recalc_Vr
recalc_Rm
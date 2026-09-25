function vc_vertslider_pos

global vars handles

yzoomin =  get(handles.yzoominbutton, 'position');
yzoomout = get(handles.yzoomoutbutton, 'position');
plus = yzoomin(2)- 18;
minus= yzoomout(2);

y_coord = yzoomout(2) + 20;
y_length = plus - minus - 4;

set(handles.vc_vertslider, 'Position', [2 y_coord 18 y_length]);


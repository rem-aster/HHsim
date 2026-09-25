function vc_delcurve
global handles vars

userdata = get(handles.cursor, 'UserData');
line_id=userdata.line_id;
if line_id>vars.vc_maxc
  line_id=line_id-vars.vc_maxc;
end
set_cursor_vis('off');
num=vars.vc_numcurves;

h=get(handles.vc_mainplot,'UserData');

set(h.lines(line_id),'XData', get(h.lines(num),'XData'));
set(h.lines(line_id),'YData', get(h.lines(num),'YData'));
col=get(h.lines(line_id),'Color');
set(h.lines(line_id),'Color', get(h.lines(num),'Color'));
set(h.lines(num),'Color',col);
set(h.lines(num),'XData',[])
set(h.lines(num),'YData',[])

set(handles.vc_mainplot,'UserData',h);
vars.vc_varplotdata(line_id,:)=vars.vc_varplotdata(num,:);
vars.vc_varplotdata(num,:)=NaN*ones(1,length(vars.vc_varplotdata(1,:)));

h=get(handles.vc_vplot,'UserData');

set(h.lines(line_id),'XData', get(h.lines(num),'XData'));
set(h.lines(line_id),'YData', get(h.lines(num),'YData'));
col=get(h.lines(line_id),'Color');
set(h.lines(line_id),'Color', get(h.lines(num),'Color'));
set(h.lines(num),'Color',col);
set(h.lines(num),'XData',[])
set(h.lines(num),'YData',[])

set(handles.vc_vplot,'UserData',h);
vars.vc_varplotdata(line_id+vars.vc_maxc,:)=vars.vc_varplotdata(num+vars.vc_maxc,:);
vars.vc_varplotdata(num+vars.vc_maxc,:)=NaN*ones(1,length(vars.vc_varplotdata(1,:)));

vars.vc_varplotdata(line_id+vars.vc_maxc*2,:)=vars.vc_varplotdata(num+vars.vc_maxc*2,:);
vars.vc_varplotdata(num+vars.vc_maxc*2,:)=NaN*ones(1,length(vars.vc_varplotdata(1,:)));

vars.vc_numcurves=vars.vc_numcurves-1;

function vc_varselect(rnum, nograph)

global handles vars

if (handles.vc_varselected>0)
  handles.vc_curve.user_strings(handles.vc_varselected) = ...
    {get(handles.vc_varval_box,'String')};
end

handles.vc_varselected=rnum;

for i=1:8
  h = handles.vc_curve.vc_sel;
  if (i==rnum)
    set(h(i), 'Value', 1, 'BackgroundColor', 'm');
  else
    set(h(i), 'Value', 0, 'BackgroundColor', 0.7*[1 1 1]);
  end
end

set(handles.vc_varval_label,'string',handles.vc_labels(rnum));
set(handles.vc_varval_box, 'String', ...
    handles.vc_curve.user_strings{handles.vc_varselected});

if ~(nargin==2 && nograph==0)
  set(handles.vc_helpnote1,'String',[handles.vc_labels{rnum} ' ' handles.vc_curve.user_strings{handles.vc_varselected} ]);
end

if ~(nargin==2 && nograph==1)
  redisplay_voltage;
end

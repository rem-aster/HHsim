% run in voltage clamp mode

varval_str=get(handles.vc_varval_box, 'String');
if (length(regexp(varval_str,'[^\.\s\d,\-]'))~=0)
  varval_str=regexprep(varval_str,'[^\.\s\d,\-]','');
  set(handles.vc_varval_box, 'String', varval_str);
end

%to initialize vertical slider
vars.vc_vertslider_set_var = 0;
vars.vc_slider_set_var = 0;

%valsarray holds numbers in vc_varval_box (vstim voltages)
valsarray=str2num(varval_str);
%iterates N number of times. N = # of voltage steps indicated
for i=1:length(valsarray)
  vars.curve_aborted=0;

  vc_addcurve(valsarray(i));
  if (vars.curve_aborted), break; end
end

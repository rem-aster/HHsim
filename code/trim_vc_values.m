function trim_vc_values

global handles vars

varval_str=get(handles.vc_varval_box, 'String');
varval_str=regexprep(varval_str,'[^\.\s\d,\-]','');

varval_arr=str2num(varval_str);
if (length(varval_arr)>vars.vc_maxc)
  varval_arr=varval_arr(1:vars.vc_maxc);
end

varval_str=num2str(varval_arr);

set(handles.vc_varval_box, 'String', varval_str);


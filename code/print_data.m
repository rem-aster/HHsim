function print_data

global vars

%try
%  printdlg;
%catch

 [filename, pathname] = uiputfile('*.eps','Print to File',vars.write_path);

 if ~(isequal(filename,0) | isequal(pathname,0))
   vars.write_path=pathname;
   print_colors;
   print('-depsc2','-noui', fullfile(pathname, filename));
   restore_colors;
 end
%end

function print_colors
global handles vars
if (vars.vclampmode==0)
  darken_lines(get(handles.mainplot,'UserData'));
  darken_lines(get(handles.varplot,'UserData'));
else
  darken_lines(get(handles.vc_mainplot,'UserData'));
  darken_lines(get(handles.vc_vplot,'UserData'));
end

function restore_colors
global handles vars
if (vars.vclampmode==0)
  lighten_lines(get(handles.mainplot,'UserData'));
  lighten_lines(get(handles.varplot,'UserData'));
else
  lighten_lines(get(handles.vc_mainplot,'UserData'));
  lighten_lines(get(handles.vc_vplot,'UserData'));
end

function darken_lines(line_struct)
line_arr=line_struct.lines;
for i=1:length(line_arr)
  col=get(line_arr(i),'Color');
  if (col==[1 1 0])
    set(line_arr(i),'Color',[0.5 0.5 0.5]);
  end
end

function lighten_lines(line_struct)
line_arr=line_struct.lines;
for i=1:length(line_arr)
  col=get(line_arr(i),'Color');
  if (col==[0.5 0.5 0.5])
    set(line_arr(i),'Color',[1 1 0]);
  end
end

function invert_lines(line_struct)
line_arr=line_struct.lines;
for i=1:length(line_arr)
  col=get(line_arr(i),'Color');
  set(line_arr(i),'Color',1-col);
end

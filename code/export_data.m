function export_data

global handles vars

if (ispc)
  eol='\r\n';
else
  eol='\n';
end


if (vars.vclampmode && vars.vc_numcurves<1)
  mb=msgbox('Cannot export empty plot','Warning');
  whiteBackground(mb)
  set(mb,'Color',[0.9 0.9 0.9]); 
  return
end
  
[filename, pathname] = uiputfile('*.txt','Export to File',vars.write_path);

if (isequal(filename,0) | isequal(pathname,0))
  return;
end

vars.write_path=pathname;
out=fopen(fullfile(pathname, filename), 'w');

if (vars.vclampmode==0)
  strs=get(handles.v1button,'String');
  v1=get(handles.v1button,'Value');
  v2=get(handles.v2button,'Value');
  v3=get(handles.v3button,'Value');

  if (strcmp(get(handles.cursor,'visible'),'on'))
    u=get(handles.cursor,'UserData');
    line_id=u.line_id;
    fprintf(out,'#time (msec)');
    switch (line_id)
      case 1
        fprintf(out,', membrane voltage (mV)'); 
      case 2
        fprintf(out,', stimulus level (nA)'); 
      case 3
        fprintf(out,', %s', strs{v1});
      case 4
        fprintf(out,', %s', strs{v2});
      case 5
        fprintf(out,', %s', strs{v3});
    end
    fprintf(out,eol);
    for i=1:vars.iteration
      fprintf(out,'%8.2f', 1000*vars.time_hist(1,i));
      switch (line_id)
        case 1
          fprintf(out,', %8.3g', 1000*vars.Vtot_hist(1,i));
        case 2
          fprintf(out,', %8.3g', vars.Itot_hist(1,i));
        case 3
          fprintf(out,', %8.3g', vars.varplotdata(v1,i));
        case 4
          fprintf(out,', %8.3g', vars.varplotdata(v2,i));
        case 5
          fprintf(out,', %8.3g', vars.varplotdata(v3,i));
      end
      fprintf(out,eol);
    end
  else
    fprintf(out,'#time (msec), membrane voltage (mV), stimulus level (nA)');
    if (v1<13), fprintf(out,', %s', strs{v1}); end
    if (v2<13), fprintf(out,', %s', strs{v2}); end
    if (v3<13), fprintf(out,', %s', strs{v3}); end
    fprintf(out,eol);

    for i=1:vars.iteration
      fprintf(out,'%8.2f, %7.2f, %5.1f', 1000*vars.time_hist(1,i), ...
              1000*vars.Vtot_hist(1,i), vars.Itot_hist(1,i));
      if (v1<13), fprintf(out,', %8.3g',vars.varplotdata(v1,i)); end
      if (v2<13), fprintf(out,', %8.3g',vars.varplotdata(v2,i)); end
      if (v3<13), fprintf(out,', %8.3g',vars.varplotdata(v3,i)); end
      fprintf(out,eol);
    end
  end
else
  if (strcmp(get(handles.cursor,'visible'),'on'))
    u=get(handles.cursor,'UserData');
    line_id=u.line_id;
    line_id=mod(line_id-1,vars.vc_maxc)+1;
    fprintf(out,['#time (msec), clamped voltage (mV), current (nA)' eol]);
    
    for i=1:vars.vc_iteration(line_id)
      fprintf(out,['%8.2f, %8.3g, %8.3g' eol], ...
              1000*vars.vc_varplotdata(line_id+vars.vc_maxc*2, i), ...
              vars.vc_varplotdata(line_id+vars.vc_maxc,i), ...
              vars.vc_varplotdata(line_id, i));
    end
  else
    fprintf(out,'[ #time (msec), clamped voltage (mV), current (nA) ] x %i', ...
            vars.vc_numcurves);
    fprintf(out,eol);

    for i=1:max(vars.vc_iteration)
      for j=1:vars.vc_numcurves
        if (j==1)
          fprintf(out,'%8.2f', 1000*vars.vc_varplotdata(j+vars.vc_maxc*2,i));
        else
          fprintf(out,', %8.2f', 1000*vars.vc_varplotdata(j+vars.vc_maxc*2,i));
        end
        fprintf(out,', %8.3g',vars.vc_varplotdata(j+vars.vc_maxc,i));
        fprintf(out,', %8.3g',vars.vc_varplotdata(j,i));
      end
      fprintf(out,eol);
    end
  end
end

fclose(out);


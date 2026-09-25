function set_pronase

global vars handles

vars.pronase=get(handles.drug3.selbutton,'Value');
if (vars.pronase==1)
  set(handles.drug3.selbutton,'BackgroundColor','c');
else
  set(handles.drug3.selbutton,'BackgroundColor',0.7*[1 1 1]);
end
indicate_drugs_active;
iterate;

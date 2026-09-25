function indicate_drugs_active

global handles vars

if (vars.pronase~=0 | vars.gmult1~=1 | vars.gmult2~=1)
  set(handles.drugbutton,'BackgroundColor','y');
else
  set(handles.drugbutton,'BackgroundColor',0.7*[1 1 1]);
end

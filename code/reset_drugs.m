function reset_drugs

global handles vars

set_valbox(handles.drug1.concbox,0);
set_drug(1,0,-1);

set_valbox(handles.drug2.concbox,0);
set_drug(2,0,-1);

set(handles.drug3.selbutton,'Value',0);
vars.pronase=0;
set(handles.drug3.selbutton,'BackgroundColor',0.7*[1 1 1]);

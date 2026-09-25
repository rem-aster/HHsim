function graph_select(drug_num)

global handles

drughandle = handles.(['drug' int2str(drug_num)]);

axes(drughandle.axis);
click_point = get(drughandle.axis,'CurrentPoint');

x_val = click_point(1,1);
y_val = click_point(1,2);

if (x_val<1 | x_val>1000 | y_val<0 | y_val > 100)
  gmax=0;
  x_val=-1;
else
  gmax=100-100*drughandle.ic50/(drughandle.ic50+x_val);
end

set_valbox(drughandle.concbox,round(gmax));
set_drug(drug_num,gmax,x_val);
indicate_drugs_active;
run_system(1);

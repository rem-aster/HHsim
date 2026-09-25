function update_drugbox(drug_num)

global vars handles

drughandle = handles.(['drug' int2str(drug_num)]);
cbox = drughandle.concbox;
v = get(drughandle.concbox,'Value');

if (v==0)
  set_drug(drug_num, 0, -1)
elseif (v==100)
  set_drug(drug_num, v, drughandle.xmax);
else
  x_val=max((100*drughandle.ic50)/(100-v)-drughandle.ic50,drughandle.xmin);
  set_drug(drug_num, v, x_val)
end

indicate_drugs_active

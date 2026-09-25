function update_stimbox(hbox)

hslide = get(hbox,'UserData');

boxstr = get(hbox, 'String');
boxstr = regexprep (boxstr,'[^\.\s\d,\-]','');
boxval = str2num(boxstr);

if isempty(boxval)
  boxval = get(hslide,'Value');
elseif (length(boxval)>1)
  boxval = boxval(1);
end

v = max(get(hslide,'Min'),min(get(hslide,'Max'),boxval));

set(hbox,'String',num2str(v))
set(hslide,'Value',v)


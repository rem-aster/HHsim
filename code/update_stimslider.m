function update_stimslider(hslide)

hbox = get(hslide,'UserData');

v = max(get(hslide,'Min'),min(get(hslide,'Max'),round(get(hslide,'Value'))));

set(hslide,'Value',v)

set(hbox,'String',num2str(v))

function color_button(h)

  if get(h,'Value') == 0
    set(h,'BackgroundColor',[0.7 0.7 0.7])
  else
    set(h,'BackgroundColor',get(h,'UserData'))
  end

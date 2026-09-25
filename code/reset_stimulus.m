function reset_stimulus(stim);

defs = stim.defaults;

set(stim.lag, 'Value',defs(1))
set(stim.mag1,'Value',defs(2))
set(stim.dur1,'Value',defs(3))
set(stim.gap, 'Value',defs(4))
set(stim.mag2,'Value',defs(5))
set(stim.dur2,'Value',defs(6))

for h = stim.sliders
  update_stimslider(h)
end

redisplay_stim(stim)

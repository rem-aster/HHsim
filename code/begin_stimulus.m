function begin_stimulus(stim)

global vars

cvals = get(stim.sliders,'Value');
vals = [cvals{:}];

vars.stimtimer = [ ...
 [ 0 vals(2) 0 vals(5) 0] *1e-9; ...
   vals([1 3 4 6]) * 1e-3, Inf];

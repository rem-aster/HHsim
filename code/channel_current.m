function c = channel_current(chan)

  global vars

  switch chan.ion
    case 1,
      E = vars.ENa;
    case 2,
      E = vars.EK;
    case 3,
      E = vars.ECl;
    case 4,
      E = 0;
  end

    %1e3 factor to change mV to uV

  c = (chan.gmax * 1e6) * (E - vars.V) * ...
      chan.gate1.value^chan.gate1.expt * ...
      chan.gate2.value^chan.gate2.expt;

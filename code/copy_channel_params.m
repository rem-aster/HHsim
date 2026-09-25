function copy_channel_params

global handles vars

% deciding which paramters are to be copied
popupval = get(handles.HH_user1.copy_popup, 'value');
switch popupval
    case 2
        hc = handles.HH_Na;
    case 3
        hc = handles.HH_K;
    otherwise
        return
end

hp = handles.HH_user1;

set(hp.ion, 'Value', get(hc.ion, 'Value'));
vars.HH_user1.ion = get(hc.ion, 'Value');
set_valbox(hp.gmax, get(hc.gmax, 'Value'));

% gate1 paramters
set(hp.gate1.exponent, 'Value', get(hc.gate1.exponent, 'Value'));
vars.HH_user1.gate1.expt = get(hc.gate1.exponent, 'Value') - 1;
set(hp.gate1.alpha.fn, 'Value', get(hc.gate1.alpha.fn, 'Value'));
vars.HH_user1.gate1.alpha.fn = get(hc.gate1.alpha.fn, 'Value');
set_valbox(hp.gate1.alpha.c, get(hc.gate1.alpha.c, 'Value'));
set_valbox(hp.gate1.alpha.th, get(hc.gate1.alpha.th, 'Value'));
set_valbox(hp.gate1.alpha.s, get(hc.gate1.alpha.s, 'Value'));
set(hp.gate1.beta.fn, 'Value', get(hc.gate1.beta.fn, 'Value'));
vars.HH_user1.gate1.beta.fn = get(hc.gate1.beta.fn, 'Value');
set_valbox(hp.gate1.beta.c, get(hc.gate1.beta.c, 'Value'));
set_valbox(hp.gate1.beta.th, get(hc.gate1.beta.th, 'Value'));
set_valbox(hp.gate1.beta.s, get(hc.gate1.beta.s, 'Value'));

% gate2 paramters
if (popupval == 2)   % it's sodium
    set(hp.gate2.exponent, 'Value', get(hc.gate2.exponent, 'Value'));
    vars.HH_user1.gate2.expt = get(hc.gate2.exponent, 'Value') - 1;
    set(hp.gate2.alpha.fn, 'Value', get(hc.gate2.alpha.fn, 'Value'));
    vars.HH_user1.gate2.alpha.fn = get(hc.gate2.alpha.fn, 'Value');
    set_valbox(hp.gate2.alpha.c, get(hc.gate2.alpha.c, 'Value'));
    set_valbox(hp.gate2.alpha.th, get(hc.gate2.alpha.th, 'Value'));
    set_valbox(hp.gate2.alpha.s, get(hc.gate2.alpha.s, 'Value'));
    set(hp.gate2.beta.fn, 'Value', get(hc.gate2.beta.fn, 'Value'));
    vars.HH_user1.gate2.beta.fn = get(hc.gate2.beta.fn, 'Value');
    set_valbox(hp.gate2.beta.c, get(hc.gate2.beta.c, 'Value'));
    set_valbox(hp.gate2.beta.th, get(hc.gate2.beta.th, 'Value'));
    set_valbox(hp.gate2.beta.s, get(hc.gate2.beta.s, 'Value'));
else   % it's the delayed rectifier so blank all the values
    set(hp.gate2.exponent, 'Value', 1);
    vars.HH_user1.gate2.expt = 0;
    set(hp.gate2.alpha.fn, 'Value', 4);
    vars.HH_user1.gate2.alpha.fn = 4;
    set_valbox(hp.gate2.alpha.c, 0);
    set_valbox(hp.gate2.alpha.th, 0);
    set_valbox(hp.gate2.alpha.s, 0);
    set(hp.gate2.beta.fn, 'Value', 4);
    vars.HH_user1.gate2.beta.fn = 4;
    set_valbox(hp.gate2.beta.c, 0);
    set_valbox(hp.gate2.beta.th, 0);
    set_valbox(hp.gate2.beta.s, 0);
end

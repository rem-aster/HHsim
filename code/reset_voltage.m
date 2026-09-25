function reset_voltage

global handles

vc_curve = handles.vc_curve;
defs = vc_curve.defaults;

set(vc_curve.mag1,'Value',defs(1))
set(vc_curve.dur0,'Value',defs(2))
set(vc_curve.mag1,'Value',defs(3))
set(vc_curve.dur1,'Value',defs(4))
set(vc_curve.mag2,'Value',defs(5))
set(vc_curve.dur2,'Value',defs(6))
set(vc_curve.mag3,'Value',defs(7))
set(vc_curve.dur3,'Value',defs(8))

vc_curve.user_strings = { num2str(defs(1)) num2str(defs(2)) ...
                          num2str(defs(3)) num2str(defs(4)) ...
                          num2str(defs(5)) num2str(defs(6)) ...
                          num2str(defs(7)) num2str(defs(7)) };

vc_curve.user_strings{1} = '-60 ';
vc_curve.user_strings{3} = '-40 ';
vc_curve.user_strings{4} = '20 ';

for h = vc_curve.sliders
  update_stimslider(h)
end

handles.vc_curve = vc_curve;

redisplay_voltage(vc_curve)

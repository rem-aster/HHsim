function redisplay_stim(stim)

global vars

lag  = get(stim.lag,'Value');
mag1 = get(stim.mag1,'Value');
dur1 = get(stim.dur1,'Value');
gap = get(stim.gap,'Value');
mag2 = get(stim.mag2,'Value');
dur2 = get(stim.dur2,'Value');

if lag > 0
  xvals = [-0.2 lag];
  yvals = [0 0];
else
  xvals = [-0.2 0];
  yvals = [0 0];
end
if dur1 > 0
  xvals = [xvals lag+[0 dur1]];
  yvals = [yvals mag1 mag1];
end
if gap > 0
  xvals = [xvals lag+dur1+[0 gap]];
  yvals = [yvals 0 0];
end
if dur2 > 0
  xvals = [xvals lag+dur1+gap+[0 dur2]];
  yvals = [yvals mag2 mag2];
end
xvals = [xvals lag+dur1+gap+dur2+[0 0.7]];
yvals = [yvals 0 0];

subplot(stim.axis)
cla, hold on
plot([-1 500],[0 0],':','Color',[0.7 0.7 0.7])
plot(xvals,yvals,'Color',vars.stimcolor)

% pick an esthetic value for max x axis
mtime = max(xvals);
timevals = [0 10.9 20.9 25.9 50.9 100.9 110.9 120.9 130.9 140.9 150.9 160.9 170.9 180.9 190.9 200.9 210.9 220.9 230.9];
b = find((mtime>=timevals(1:end-1)) & (mtime<=timevals(2:end)));

axis([-0.2 timevals(b+1) round(max([10 abs(yvals)])*[-1.2 1.2])])
drawnow

    


function redisplay_voltage(vc_curve)

global handles vars

if (~nargin)
  vc_curve=handles.vc_curve;
end

varvals=str2num(get(handles.vc_varval_box, 'String'));

subplot(vc_curve.axis)
cla, hold on
plot([-1 500],[0 0],':','Color',[0.7 0.7 0.7])
ccolors={'r' 'b' 'g' 'm' 'c' 'y' [1 0.5 0] [0 0.7 0]};
mtime=0;
myval=10;

for i=1:length(varvals)
  mag0 = get(vc_curve.mag0,'Value');
  dur0 = get(vc_curve.dur0,'Value');
  mag1 = get(vc_curve.mag1,'Value');
  dur1 = get(vc_curve.dur1,'Value');
  mag2 = get(vc_curve.mag2,'Value');
  dur2 = get(vc_curve.dur2,'Value');
  mag3 = get(vc_curve.mag3,'Value');
  dur3 = get(vc_curve.dur3,'Value');
  switch(handles.vc_varselected)
    case 1, mag0=varvals(i);
    case 2, dur0=varvals(i);
    case 3, mag1=varvals(i);
    case 4, dur1=varvals(i);
    case 5, mag2=varvals(i);
    case 6, dur2=varvals(i);
    case 7, mag3=varvals(i);
    case 8, dur3=varvals(i);
  end

  if dur0 > 0
    xvals = [-0.2 dur0];
    yvals = [mag0 mag0];
  else
    xvals = [-0.2 0];
    yvals = [mag0 mag0];
  end
  if dur1 > 0
    xvals = [xvals dur0+[0 dur1]];
    yvals = [yvals mag1 mag1];
  end
  if dur2 > 0
    xvals = [xvals dur0+dur1+[0 dur2]];
    yvals = [yvals mag2 mag2];
  end
  if dur3 > 0
    xvals = [xvals dur0+dur1+dur2+[0 dur3]];
    yvals = [yvals mag3 mag3];
  end

  plot(xvals,yvals,'Color',ccolors{i});
  mtime=max([mtime xvals]);
  myval=max([myval abs(yvals)]);
end

% pick an esthetic value for max x axis
timevals = [0 10.9 20.9 25.9 50.9 100.9 150.9 200.9];
b = find((mtime>=timevals(1:end-1)) & (mtime<=timevals(2:end)));

axis([-0.2 timevals(b+1) round(myval*[-1.2 1.2])])
drawnow


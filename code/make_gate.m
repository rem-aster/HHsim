function gate = make_gate(varname,letter,gatename,xi,yi, ...
			    initval, gexpt, ...
			    afn,ac,ath,as,bfn,bc,bth,bs)

  global vars handles

  alpha.type = 'alpha';
  alpha.fn = afn;
  alpha.c = ac;
  alpha.th = ath;
  alpha.s = as;

  beta.type = 'beta';
  beta.fn = bfn;
  beta.c = bc;
  beta.th = bth;
  beta.s = bs;

  gate.value = initval;
  gate.expt = gexpt;
  gate.alpha = alpha;
  gate.beta = beta;

  if isempty(letter), return, end

%%% Graphics part

  xind = 30; xtinc = 150; yinc = -35;

  text(xi,yi,[letter ':'],'FontSize',15,'Color','w')
  yi = yi + yinc;

  make_valtext('',xi,yi,'%s','exponent');
  h = uicontrol('Style','Popup','String',{'0' '1' '2' '3' '4' '5' '6'}, ...
	    'Value',gexpt+1, ...
        'UserData',gexpt+1, ...
	    'Position',[xi+xtinc yi 50 20], ...
	    'ForegroundColor',[1 1 0], ...
	    'BackgroundColor',[0 0 0], ...
	    'Callback',['vars.' varname '.' gatename '.expt = get(gcbo,''Value'')-1);']);
  handles.(varname).(gatename).exponent = h;
  yi = yi + yinc;

  yi = make_gate_rate(varname,gatename,xi,yi,xtinc,yinc,alpha);
  yi = yi + yinc + 25;
  yi = make_gate_rate(varname,gatename,xi,yi,xtinc,yinc,beta);

  axsave = gca;
  ax = axes('Units','pixels','Position',[xi+xind,yi-110,200,100], ...
	'Color',[0.8 0.8 0]);
  vmin = -90; vmax = 90;
  axis([vmin vmax -0.1 2])
  hold on, box on, grid on
  vrange = vmin:vmax;
  gate.aline = plot(vrange,evalrate(gate.alpha,vrange),'Color','r');
  gate.bline = plot(vrange,evalrate(gate.beta,vrange),'Color','b');
  title('alpha, beta')
  xlabel('V_m')
  ylabel('msec^{-1}')
  set(gcf,'CurrentAxes',axsave);

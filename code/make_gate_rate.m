function yi = make_gate_rate(varname,gatename,xi,yi,xtinc,yinc,rate);

  global vars handles

  recalc_string = ['global vars; recalc_gate_graph(vars.' varname '.' gatename ')'];

  xind = 20; 

  if strcmp(rate.type,'alpha') == 1
    rlabel = 'alpha:    Closed \rightarrow Open';
    rcolor = [1 0.5 0.5];
  else
    rlabel = 'beta:    Open \rightarrow Closed';
    rcolor = [0.5 0.5 1];
  end
  h=make_valtext('',xi,yi,'%s',rlabel);
  set(h,'Color',rcolor)
  yi = yi + yinc;

  hand = uicontrol('Style','Popup','Position',[xi+xind yi 200 20], ...
	'String',{'c * exp[(V-th)*s]' ...
		  'c * (V-th) / (1-exp[(V-th)*s])' ...
		  'c / (1+exp[(V-th)*s])' ...
		  '--'}, ...
	'Value', rate.fn, ...
        'UserData', rate.fn, ...
	'ForeGroundColor',[1 1 0], ...
	'BackgroundColor',[0 0 0], ...
        'CallBack',['global vars; vars.' varname '.' gatename '.' rate.type ...
                    '.fn = get(gcbo,''Value''); ' recalc_string]);
  handles.(varname).(gatename).(rate.type).fn = hand;
  yi = yi + yinc;

  make_valtext('',xi+xind,yi,'%s','magnitude (c)');
  hand = make_valbox({varname gatename rate.type 'c'},xi+xtinc,yi,rate.c,0,10,1, ...
		recalc_string, '%4.3f', '+', 0.01);
  handles.(varname).(gatename).(rate.type).c = hand;
  yi = yi + yinc;

  make_valtext('',xi+xind,yi,'%s','threshold (th)');
  hand = make_valbox({varname gatename rate.type 'th'},xi+xtinc,yi,rate.th,-100,100,1, ...
		recalc_string, '%4.3f', '+', 5);
  handles.(varname).(gatename).(rate.type).th = hand;
  yi = yi + yinc;

  make_valtext('',xi+xind,yi,'%s','slope (s)');
  hand = make_valbox({varname gatename rate.type 's'},xi+xtinc,yi,rate.s,-1,1,1, ...
		recalc_string, '%4.3f', '+', 0.01);
  handles.(varname).(gatename).(rate.type).s = hand;
  yi = yi + yinc;

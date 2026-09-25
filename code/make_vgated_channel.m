function gate_handle = make_vgated_channel (varname,descr,switchval,ion, ...
	xi,yi,gmax, ... 
	g1letter,g1init,g1expt,g1afn,g1ac,g1ath,g1as,g1bfn,g1bc,g1bth,g1bs, ...
	g2letter,g2init,g2expt,g2afn,g2ac,g2ath,g2as,g2bfn,g2bc,g2bth,g2bs)

global vars handles
   
%%% Make the buttons

  buttonwidth = 20; buttonheight = 20; xtinc = 150;
  button2width = 80;

h = uicontrol(handles.chanwindow, 'Style','CheckBox','Fontsize',8, ...
	  'Position',[xi yi buttonwidth buttonheight],...
	  'String','','Value',switchval, ...
	  'UserData',[1 0.7 0.7], ...
	  'CallBack',['set_channel_button(''' varname ''')']);
handles.(['button_' varname]) = h;
vars.(['switch_' varname]) = switchval;
color_button(h)
xi = xi + buttonwidth + 5;

set(0, 'CurrentFigure', handles.chanwindow);
  
make_valtext('',xi,yi,'%s',descr);

uicontrol(handles.chanwindow,'Style','PushButton','Fontsize',10, ...
	  'Position',[xi+xtinc yi button2width buttonheight], ...
	  'String','Details', ...
	  'CallBack',['toggle_winvis(''' varname ''')']);

%%% Make channel gate params window

gate_handle = figure('Visible','off', 'Resize','off', ...
    'NumberTitle','off','MenuBar','none');
clf
blackBackground(gcf)
axis off
width = 600; height = 700;
pos = get(gcf,'Position');
set(gcf,'Units','pixels','Position',[pos(1) 30 width height])
set(gcf,'Name',descr)
set(gcf, 'CloseRequestFcn', 'set_winvis(gcf,0)');
cla, axis off
set(gca,'Units','pixels','Position',[0 0 width height])
axis([1 width 1 height])

xinit = 10; xi = xinit; xinc = 80; xtinc = 150; xind=20; xcol2 = 300;
yinit = height -20; yi = yinit; yinc = -25;

text(100,yi,descr,'FontSize',20,'Color',[0.8 0.8 0.2])
yi = yi - 50;

make_valtext('',xi+xinc,yi,'%s','Ion');
h = uicontrol('Style','Popup','Position',[xi+xinc+40 yi 70 20], ...
	  'String',{'Na+','K+','Cl-','--'},'Value',ion, ...
          'UserData',ion, ...
	  'ForegroundColor',[1 1 0],'BackgroundColor',[0 0 0], ...
	  'CallBack',['vars.' varname '.ion = get(gcbo,''Value'');']);
handles.(varname).ion = h;

make_valtext('',xi+xtinc+xinc,yi,'%s','g_{max} (\mu{}S)');
h = make_valbox({varname 'gmax'},xi+xtinc*2,yi,gmax*1e6,0,200,1e-6, ...
		'', '%4.1f', '+', 1);
handles.(varname).gmax = h;

yi = yi + yinc*1.5;


ysave = yi;

gate1 = make_gate(varname,g1letter,'gate1',xi,yi, ...
                  g1init,g1expt, ...
                  g1afn,g1ac,g1ath,g1as, ...
                  g1bfn,g1bc,g1bth,g1bs);

gate2 = make_gate(varname,g2letter,'gate2',xi+xcol2,ysave, ...
                  g2init,g2expt, ...
                  g2afn,g2ac,g2ath,g2as, ...
                  g2bfn,g2bc,g2bth,g2bs);

channel.varname = varname;
channel.descr = descr;
channel.ion = ion;
channel.gmax = gmax;
channel.gate1 = gate1;
channel.gate2 = gate2;

vars.(varname) = channel;

uicontrol('Style','Pushbutton','String','Reset', ...
    'Position',[1 1 40 20], 'CallBack', ['reset_channel(''' varname ''')']);

uicontrol('Style','PushButton','Position',[51 1 40 20],'String','Hide', ...
	'Callback','set_winvis(gcf,0)')


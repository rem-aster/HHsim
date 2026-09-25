function setup_membrane

global vars handles

width = 320; height = 370;
handles.memwindow = figure('Visible','off', 'Resize', 'off', ...
    'NumberTitle','off','MenuBar','none');
clf
pos = get(gcf,'Position');
set(gcf,'Units','pixels','Position',[pos(1:2) width height])
drawnow
blackBackground(gcf)
set(gcf,'Name','Membrane')
set(gcf, 'CloseRequestFcn', 'callbacks(18)');
cla, axis off
set(gca,'Units','pixels','Position',[0 0 width height])
axis([1 width 1 height])

xinit = 10; xi = xinit; xinc = 80; xtinc = 20;
yinit = 350; yi = yinit; yinc = -35;
dfmt = '%4.1f';
efmt = '%4.1f mV';

text(110,yi,'Membrane','FontSize',20,'Color',[0.8 0.2 0.2])
yi=yi-50;

make_valtext('',xi+1*xinc,yi,'%s','  C_{in} (mM)');
make_valtext('',xi+2*xinc,yi,'%s',' C_{out} (mM)');
make_valtext('',xi+3*xinc,yi,'%s','    E_{ion}');

yi = yi + yinc;
make_valtext('',xi+xtinc,yi,'%s','Na^+');
vars.Nai = 50; vars.Nao = 440;
handles.Nai = make_valbox ('Nai',xi+1*xinc,yi,vars.Nai,1,100,1, ...
	@recalc_ENa_Vr,'%4.1f','+',1);
handles.Nao = make_valbox ('Nao',xi+2*xinc,yi,vars.Nao,5,800,1, ...
	@recalc_ENa_Vr,dfmt,'+',5);
handles.ENa = make_valtext('ENa',xi+3*xinc,yi,efmt,0,1000);

yi=yi+yinc;
make_valtext('',xi+xtinc,yi,'%s','K^+');
vars.Ki = 400; vars.Ko = 20;
handles.Ki = make_valbox ('Ki',xi+1*xinc,yi,vars.Ki,5,800,1, ...
	@recalc_EK_Vr,'%4.1f','+',5);
handles.Ko = make_valbox ('Ko',xi+2*xinc,yi,vars.Ko,1,100,1, ...
	@recalc_EK_Vr,dfmt,'+',1);
handles.EK = make_valtext('EK',xi+3*xinc,yi,efmt,0,1000);

yi = yi + yinc;
make_valtext('',xi+xtinc,yi,'%s','Cl^-');
vars.Cli = 52; vars.Clo = 560;
handles.Cli = make_valbox ('Cli',xi+1*xinc,yi,vars.Cli,1,100,1, ...
	@recalc_ECl_Vr,'%4.1f','+',1);
handles.Clo = make_valbox ('Clo',xi+2*xinc,yi,vars.Clo,5,800,1, ...
	@recalc_ECl_Vr,dfmt,'+',5);
handles.ECl = make_valtext('ECl',xi+3*xinc,yi,efmt,0,1000);

yinc = -30;
xtinc = xtinc + 50;
yi = yi + yinc*1.5;
make_valtext('',xi+xtinc,yi,'%s','T (^oC)');
vars.T = 6.3;
vars.cache_zgain=3 ^ ((vars.T - 6.3) / 10);

handles.T = make_valbox ('T',xi+xtinc+1*xinc,yi,vars.T,-20,50,1, ...
	@recalc_EK_ENa_ECl_Vr,'%3.2f','+',1);

yi = yi + yinc;
handles.Vr = make_valtext('Vr',xi+xtinc,yi,'passive V_r = %5.1f mV',0,1000);

yi = yi + yinc*1.5;
make_valtext('',xi+xtinc,yi,'%s','R_m');

vars.Rm = 5.1;
handles.Rm = make_valtext('Rm',xi+xtinc+1*xinc,yi,'= %5.1f M\\Omega',vars.Rm/1e6,1);


%handles.Rm = make_valbox ('Rm',xi+xtinc+1*xinc,yi,vars.Rm/1e6,1,Inf,1e6, ...
%	'','%4.2f','+',1);

yi = yi + yinc;
make_valtext('',xi+xtinc,yi,'%s','C_m (nF)');
vars.Cm = 1;
handles.Cm = make_valbox ('Cm',xi+xtinc+1*xinc,yi,vars.Cm,1,Inf,1e-9, ...
	'','%4.2f','+',1);

uicontrol('Style','PushButton','Position',[1 1 40 20],'String','Reset', ...
	'Callback','callbacks(17)')

uicontrol('Style','PushButton','Position',[51 1 40 20],'String','Hide', ...
	'Callback','callbacks(18)')

% small internal functions
function recalc_ENa_Vr
recalc_ENa; recalc_Vr; recalc_Rm; 

function recalc_EK_Vr
recalc_EK; recalc_Vr; recalc_Rm; 

function recalc_ECl_Vr
recalc_ECl; recalc_Vr; recalc_Rm; 

function recalc_EK_ENa_ECl_Vr
global vars
recalc_EK; recalc_ENa; recalc_ECl; recalc_Vr; 
vars.cache_zgain=3 ^ ((vars.T - 6.3) / 10);



function setup_drugs

global vars handles

vars.drugcolor = [1.0 1.0 0.2];
handles.drugwindow = figure('Visible','off','Resize','off', ...
    'NumberTitle','off','MenuBar','none');
clf
width = 500; height = 550;
pos = get(gcf,'Position');
set(gcf,'Units','pixels','Position',[460 180 width height],'Visible','off')
set(gcf,'Name','Препараты')
set(gcf, 'CloseRequestFcn', 'callbacks(20)');
blackBackground(gcf)
cla, axis off
set(gca,'Units','pixels','Position',[0 0 width height])
axis([1 width 1 height])

text(185,530,'Препараты','FontSize',20,'Color',vars.drugcolor)
buttonwidth = 20; buttonheight = 20;

text(115,170,'% ингибирования','FontSize',10)
text(115,350,'% ингибирования','FontSize',10)

uicontrol('Style','PushButton','Position',[1 1 40 20],'String','Сброс', ...
	'Callback','callbacks(19)')

uicontrol('Style','PushButton','Position',[51 1 40 20],'String','Скрыть', ...
	'Callback','callbacks(20)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xpos = 15;
ypos = 350;

make_drug(1,0,330,'TTX','тетродотоксин','подавляет Na-ток', ...
          'нМ',0.1,100,10);
make_drug(2,0,150,'TEA','тетраэтиламмоний','подавляет K-ток', ...
          'мМ',0.1,100,10);

handles.drug3.selbutton = ...
  uicontrol('Style','CheckBox','Position',[210 70 110 20], ...
    'Value',0,'String','Проназа','FontSize',10, ...
    'Tooltip','Включить/выключить проназу','BackgroundColor',0.7*[1 1 1], ...
    'CallBack','set_pronase');
handles.drug3.axis = axes('Units','pixel', ...
             'Position',[65, 40, 400 80]);
subplot(handles.drug3.axis)
set(gca,'xtick',[],'ytick',[])
box on
title('Проназа - устраняет инактивацию Na-каналов', ...
      'Color',vars.drugcolor,'FontSize',11);

set(handles.drug1.axis,'ButtonDownFcn','graph_select(1);');
set(handles.drug1.line,'ButtonDownFcn','graph_select(1);');
set(handles.drug1.helpt,'ButtonDownFcn','graph_select(1);');

set(handles.drug2.axis,'ButtonDownFcn','graph_select(2);');
set(handles.drug2.line,'ButtonDownFcn','graph_select(2);');
set(handles.drug2.helpt,'ButtonDownFcn','graph_select(2);');

vars.ginh1=0;
vars.ginh2=0;
vars.gmult1=1;
vars.gmult2=1;


function setup_stimuli

global vars handles

vars.stimcolor = [0.6 0.6 1.0];
handles.stimwindow = figure('Visible','off','Resize','off', ...
    'NumberTitle','off','MenuBar','none');
clf
width = 480; height = 550;
pos = get(gcf,'Position');
set(gcf,'Units','pixels','Position',[480 200 width height],'Visible','off')
set(gcf,'Name','Stimuli')
set(gcf, 'CloseRequestFcn', 'callbacks(12)');
blackBackground(gcf)
cla, axis off
set(gca,'Units','pixels','Position',[0 0 width height])
axis([1 width 1 height])

text(130,530,'Stimulus Patterns','FontSize',20,'Color',vars.stimcolor)
buttonwidth = 20; buttonheight = 20;

uicontrol('Style','PushButton','Position',[1 1 40 20],'String','Reset', ...
	'Callback','callbacks(11)')

uicontrol('Style','PushButton','Position',[51 1 40 20],'String','Hide', ...
	'Callback','callbacks(12)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

make_stimulus(1,0,290,[0 10 1 1 0 1])
make_stimulus(2,0,30,[0 -10 2 1 0 1])

reset_stimulus(handles.stim1)
reset_stimulus(handles.stim2)

vars.stimtimer = [0; Inf];


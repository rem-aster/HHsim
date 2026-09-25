function setup_vclamp

global vars handles

vars.vc_color = [0.6 0.6 1.0];
handles.vclampwindow = figure('Visible','off','Resize','off', ...
    'NumberTitle','off','MenuBar','none');
clf
width = 600; height = 480;
pos = get(gcf,'Position');
set(gcf,'Units','pixels','Position',[200 200 width height],'Visible','off')
set(gcf,'Name','Voltage Clamp')
set(gcf, 'CloseRequestFcn', 'callbacks(28)');
blackBackground(gcf)
cla, axis off
set(gca,'Units','pixels','Position',[0 0 width height])
axis([1 width 1 height])

text(195,460,'Voltage Clamp Protocol','FontSize',20,'Color',vars.vc_color)
buttonwidth = 20; buttonheight = 20;

uicontrol('Style','PushButton','Position',[1 1 40 20],'String','Reset', ...
	'Callback','callbacks(27)')

uicontrol('Style','PushButton','Position',[51 1 40 20],'String','Hide', ...
	'Callback','callbacks(28)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

make_voltage(0,220,[-60 10 -40 20 -60 10 0 0])

handles.vc_labels={'Holding voltage (mV): ', ...
            'Hold time (msec):  ', ...
            'Step 1 voltage (mV): ', ...
            'Step 1 duration (msec): ', ...
            'Step 2 voltage (mV): ', ...
            'Step 2 duration (msec): ', ...
            'Step 3 voltage (mV): ', ...
            'Step 3 duration (msec): ' };
handles.vc_varselected = 0;
reset_voltage;
vc_varselect(3,0);
reset_voltage;

vars.vc_ylims = cell(1,0);
vars.vc_xlims = cell(1,0);
vars.vc_timer = [0; Inf];


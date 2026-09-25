function resize_main

global handles vars

pos=get(handles.mainwindow,'Position');
width=pos(3);
height=pos(4);

% leave bottom row as is

% move top row buttons
toprow=[handles.membutton handles.chanbutton handles.stimbutton ...
        handles.drugbutton handles.vc_button handles.helpbutton handles.radio_frame];
for i=1:length(toprow)
  pos=get(toprow(i),'Position');
  pos(2)=height-pos(4);
  set(toprow(i),'Position',pos);
end

radiobuttons = [handles.cursorbutton ...
        handles.zoombutton handles.panbutton ];
    
for i=1:length(radiobuttons)
  pos=get(radiobuttons(i),'Position');
  pos(2)=height-pos(4)-2;
  set(radiobuttons(i),'Position',pos);
end
% rescale top plots
if (vars.vclampmode==0)
  pos=get(handles.mainplot,'Position');
  pos(4)=1-(40/height)-pos(2);
  set(handles.mainplot,'Position',pos);
else
  pos=get(handles.vc_mainplot,'Position');
  pos(4)=1-(40/height)-pos(2);
  set(handles.vc_mainplot,'Position',pos);
end

% rescale bottom plots
if (vars.vclampmode==0)
  pos=get(handles.varplot,'Position');
  p_top=pos(2)+pos(4);
  pos(2)=145/height;
  pos(4)=p_top-pos(2);
  set(handles.varplot,'Position',pos);
else
  pos=get(handles.vc_vplot,'Position');
  p_top=pos(2)+pos(4);
  pos(2)=145/height;
  pos(4)=p_top-pos(2);
  set(handles.vc_vplot,'Position',pos);
end

% rescale plot scroll bars
if (vars.vclampmode==0)
  pos=get(handles.slider,'Position');
  pos(1)=0.06*width;
  pos(3)=0.9*width;
  set(handles.slider,'Position',pos);
else
  pos=get(handles.vc_slider,'Position');
  pos(1)=0.06*width;
  pos(3)=0.9*width;
  set(handles.vc_slider,'Position',pos);
end


% var axis labels
ypos=height*21/50;
set(handles.v1axislabel,'Position',[10 ypos 40 15]);
ypos=height*19/50;
set(handles.v2axislabel,'Position',[10 ypos 40 15]);
ypos=height*17/50;
set(handles.v3axislabel,'Position',[10 ypos 40 15]);

% vertical zoom
ypos=height*0.53;
set(handles.yzoomoutbutton,'Position',[2 ypos 18 18]);
set(handles.transdownbutton,'Position',[2 ypos+20 18 18]);
ypos=height*0.98-45;
set(handles.yzoominbutton,'Position',[2 ypos 18 18]);
set(handles.transupbutton,'Position',[2 ypos-20 18 18]);

%vert slider
vc_vertslider_pos;

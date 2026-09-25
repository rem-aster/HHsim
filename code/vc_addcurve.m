function vc_addcurve (varval)
global handles vars

%cvals will hold data from VStim window
cvals = get(handles.vc_curve.sliders,'Value');
%convert msecs to seconds, and put voltage and time data on separate rows
vals = reshape([cvals{:}],2,4);
vals(:,find(vals(2,:)==0)) = [];
vars.vc_timer = [ vals [0; Inf] ] * 1e-3;

if (nargin)
  if mod((handles.vc_varselected-1),2) == 0
    %bound clamped voltage between -90 and 100 mV
    if varval > 100
        varval=100;
    elseif  varval < -90
        varval=-90;
    end
  end
  varval=varval*1e-3;  % convert to volts or seconds
  vars.vc_timer(mod((handles.vc_varselected-1),2)+1, ...
                ceil(handles.vc_varselected/2)) = varval;
end

u=get(handles.vc_mainplot,'UserData');
u.ptr=0; u.cachexdata=[]; u.cacheydata=[]; u.cachecnt=0; u.cachedisp=0;
set(handles.vc_mainplot,'UserData',u);
u=get(handles.vc_vplot,'UserData');
u.ptr=0; u.cachexdata=[]; u.cacheydata=[]; u.cachecnt=0; u.cachedisp=0;
set(handles.vc_vplot,'UserData',u);

if (vars.vc_numcurves>=vars.vc_maxc)
  vars.curve_aborted=1;
  mb=msgbox(['Cannot display more than ' num2str(vars.vc_maxc) ' curves in voltage clamp. Hit the Clear button, or delete some curves.'], 'Warning');
  whiteBackground(mb);
  set(mb,'Color',[0.9 0.9 0.9]);
else 
  vars.vc_numcurves=vars.vc_numcurves+1;
  vc_iterate
end

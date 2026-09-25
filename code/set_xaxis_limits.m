function set_xaxis_limits(x_middle)

global vars handles

xwidth = vars.plot_rate * vars.deltaT_plot * 200 * 1e3;
%xlims = get(handles.vc_mainplot, 'XLim');
%xwidth = xlims(2) - xlims(1);


xlimits(1,1) = x_middle - xwidth/2;
xlimits(1,2) = x_middle + xwidth/2;
set(handles.varplot,'XLim',xlimits);
set(handles.mainplot,'XLim',xlimits);

% in case the off-screen cursor falls within the limits
% or the on-screen cursor falls off
if strcmp(get(handles.cursor, 'visible'),'on')
    userdata = get(handles.cursor, 'userdata');
    reset_cursor_values(userdata.line_id, userdata.index);
end

function vc_set_xaxis_limits(x_middle)

global vars handles


xwidth = vars.plot_rate * vars.plot_rate_mul;
xlimits(1,1) = x_middle - xwidth/2;
xlimits(1,2) = x_middle + xwidth/2;

set(handles.vc_vplot,'XLim',xlimits);

set(handles.vc_mainplot,'XLim',xlimits);

% in case the off-screen cursor falls within the limits
% or the on-screen cursor falls off
if strcmp(get(handles.cursor, 'visible'),'on')
    userdata = get(handles.cursor, 'userdata');
    vc_reset_cursor_values(userdata.line_id, userdata.index);
end

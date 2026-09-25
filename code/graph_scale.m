function val = graph_scale (value, line_type, to_graph)

% for line_type
% 1 is voltage
% 2 is stimulus
% 3 is m,h,and n
% 4 is channel currents
% 5 is channel conductances
% 6 is I_leak

% to_graph indicates transformation to for from graph coordinates

if (to_graph ~= 0)
    switch line_type
        case 2
            val = value - 85;
        case 4
            val = (value / 1.5) + 0.5;
        case 5
            val = value / 30;
        case 6
            val = (value * 22.5) + 0.5;
        otherwise
            val = value;
    end
else
    switch line_type
        case 2
            val = value + 85;
        case 4
            val = (value - 0.5) * 1.5;
        case 5
            val = value * 30;
        case 6
            val = (value - 0.5) / 22.5;
        otherwise
            val = value;
    end
end

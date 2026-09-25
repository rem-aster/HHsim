function blackBackground(h)
    if nargin == 0
        h = gcf;
    end
    if is_octave
        octave_colors(h, [0, 0, 0])
    elseif isMATLABReleaseOlderThan('R2025a')
        whitebg(h, [0, 0, 0])
    else
        theme(h, 'dark')
    end

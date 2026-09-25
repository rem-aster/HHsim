function whiteBackground(h)
    if nargin == 0
        h = gcf;
    end
    if is_octave
        octave_colors(h, [1, 1, 1])
    elseif isMATLABReleaseOlderThan('R2025a')
        whitebg(h, [1, 1, 1])
    else
        theme(h, 'light')
    end

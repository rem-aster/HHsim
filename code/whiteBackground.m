function whiteBackground(h)
    if nargin == 0
        h = gcf;
    end
    if isMATLABReleaseOlderThan('R2025a')
        whitebg(h, [1, 1, 1])
    else
        theme(h, 'light')
    end

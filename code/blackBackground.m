function blackBackground(h)
    if nargin == 0
        h = gcf;
    end
    if isMATLABReleaseOlderThan('R2025a')
        whitebg(h, [0, 0, 0])
    else
        theme(h, 'dark')
    end

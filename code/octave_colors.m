function octave_colors(h, bg)
% Octave replacement for whitebg/theme: set background and matching
% foreground colors for the figure and everything created in it later.
fg = 1 - bg;
set(h, 'Color', bg);
set(h, 'DefaultAxesColor', bg, ...
       'DefaultAxesXColor', fg, 'DefaultAxesYColor', fg, 'DefaultAxesZColor', fg, ...
       'DefaultTextColor', fg);
ax = findall(h, 'Type', 'axes');
for i = 1:numel(ax)
  set(ax(i), 'Color', bg, 'XColor', fg, 'YColor', fg, 'ZColor', fg);
end

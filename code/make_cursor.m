function h = make_cursor(varargin)
% create the (initially hidden) elliptical cursor in the current axes
h = rectangle('Curvature', [1 1], 'visible', 'off', varargin{:});
set(h, 'visible', 'off');  % Octave ignores 'visible' passed to rectangle()

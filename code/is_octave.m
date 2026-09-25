function r = is_octave
% true when running under GNU Octave instead of MATLAB
persistent cached
if isempty(cached)
  cached = exist('OCTAVE_VERSION', 'builtin') ~= 0;
end
r = cached;

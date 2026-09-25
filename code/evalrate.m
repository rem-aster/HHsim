function z = evalrate(r,V)

% V is in millivolts

global vars

switch r.fn
  case 1
    z = r.c * exp((V-r.th)*r.s);
  case 2
    % V(V==r.th) = r.th + 0.01;
    % prevent divide-by-zero error
    V(V==r.th) = r.th + 0.01;
    if r.s ~= 0
        z = r.c * (V-r.th) ./ (1-exp((V-r.th)*r.s));
    else
        z = r.c * (V-r.th) ./ (1-exp(0.0001));
    end
  case 3
    z = r.c ./ (1+exp((V-r.th)*r.s));
  case 4
    z = V*0;
end

% Bard's temperature correction factor (based on squid axon)
  
z = z * vars.cache_zgain;

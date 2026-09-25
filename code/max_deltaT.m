function dT = max_deltaT(ignore_pronase)

global vars

if (vars.pronase==1 & ignore_pronase==0)
  % pronase requires a much finer resolution
  dT=1e-5;
else
  dT=1e-4;
end


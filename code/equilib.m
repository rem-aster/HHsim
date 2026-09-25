function y = equilib(Ci,Co,T,Z)

  T = T + 273.16;
  R = 8.31451;
  F = 96485.3;

  y = R*T / (Z*F) * log(Co/Ci);

function vc_stabilize
%to stabilize current before plotting
  global handles vars
  
  % The variable I may change too slowly in one iteration,
  % giving the appearance that the system has stabilized although 
  % the gate variables may still be changing.  To cope with this,
  % we keep a history of the 200 previous values and require that
  % the value of I not change for the last 200 iterations.

  THRESHOLD = 1e-7;
  MAX_ITERATIONS = 10000;
  
  vars.V = vars.vc_timer(1,1);
  first = find_I;
  second = find_I;
  diff = 999;
  iters = 0;
  Ihist = 1:200;
  
  while abs(diff) > THRESHOLD && iters < MAX_ITERATIONS
      Ihist = [Ihist(2:end) find_I];
      diff = Ihist(1) - Ihist(end);
      iters = iters+1;
  end

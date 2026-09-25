function recalc_gate_graph(gate)
  V = get(gate.aline,'XData');
  set(gate.aline,'YData',evalrate(gate.alpha,V))
  set(gate.bline,'YData',evalrate(gate.beta,V))

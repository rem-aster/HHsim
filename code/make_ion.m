function r = make_ion(name, pos, Oconc, Iconc, density)

  r.name = name;
  r.pos = pos;
  r.defIconc = Iconc;
  r.Iconc = r.defIconc;
  r.defOconc = Oconc;
  r.Oconc = r.defOconc;
  r.density = density;

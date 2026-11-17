model FD_test
  parameter Integer order = 20;
  Real ymh,yh,y3h;
  Real lmh,lh,l3h;
  Real eemh,eeh,ee3h;
  Modelica.Blocks.Sources.Ramp uramp(height = 100, duration = 1, offset = -10)  annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  (ymh,lmh) = ThermalMatters.Utilities.fd_asymp(uramp.y, -1, order);
  (yh,lh) = ThermalMatters.Utilities.fd_asymp(uramp.y, 0, order);
  (y3h,l3h) = ThermalMatters.Utilities.fd_asymp(uramp.y, 1, order);
  // crude estimation of relative error based upon last term in expansion: 
  eemh = abs(lmh/ymh);
  eeh = abs(lh/yh);
  ee3h = abs(l3h/y3h);
  annotation(
    uses(Modelica(version = "4.1.0")),
  Diagram(coordinateSystem(extent = {{-20, 20}, {0, -20}})),
  version = "",
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.0001));
end FD_test;
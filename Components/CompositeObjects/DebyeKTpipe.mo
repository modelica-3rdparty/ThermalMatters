within ThermalMatters.Components.CompositeObjects;

model DebyeKTpipe "Debye-Mass KT-Conducting Cylindrical Shell"
  extends Icons.Block;
  import Modelica.Units.SI;
  import const=Modelica.Constants;
  parameter SI.Length rin = 0.1 "m; Inner radius";
  parameter SI.Length rout = 0.2 "m; Outer radius";
  parameter SI.Length l = 10 "m; Length";
  final parameter SI.Length rhalf = (2/3)*(rout*rout*rout-rin*rin*rin)/(rout*rout-rin*rin);
  final parameter SI.Volume V = const.pi*l*(rout*rout-rin*rin);
  parameter SI.Temperature T_start (displayUnit = "K")= 323 "K; Initial avg T";
  parameter SI.Temperature T_D (displayUnit = "K")= 343 "K ; Debye Temperature";
  parameter Real effAm = 63.546 "Da ; Effective atomic mass";
  parameter SI.Density Mdens (displayUnit = "kg/m3")= 8935 "kg/m^3 ; Mass density";
  parameter SI.ThermalConductivity kappa0 = 401 "W/(m K); Thermal conductivity at T0";
  parameter SI.Temperature T0(displayUnit = "K") = 293 "K; Reference temperature";
  // parameter SI.Temperature Tkmax(displayUnit = "K")=10 "Temperature of max kappa (K)";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(
    Placement(transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(
    Placement(transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  HeatCapacitors.DebyeSolid debyeSolid(V = V, T(start = T_start, fixed = true), T_D = T_D, effAm = effAm, Mdens = Mdens)  annotation(
    Placement(transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}})));
  ThermalConductors.KTDebCylShell kTDebCylShell_a(ra = rin, rb = rhalf, l = l, kappa0 = kappa0, T0 = T0, T_D = T_D, effAm = effAm, Mdens = Mdens)  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  ThermalConductors.KTDebCylShell kTDebCylShell_b(ra = rhalf, rb = rout, l = l, kappa0 = kappa0, T0 = T0, T_D = T_D, effAm = effAm, Mdens = Mdens)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(kTDebCylShell_a.port_a, port_a) annotation(
    Line(points = {{-40, 0}, {-60, 0}}, color = {191, 0, 0}));
  connect(kTDebCylShell_a.port_b, debyeSolid.port) annotation(
    Line(points = {{-20, 0}, {0, 0}}, color = {191, 0, 0}));
  connect(kTDebCylShell_b.port_a, debyeSolid.port) annotation(
    Line(points = {{20, 0}, {0, 0}}, color = {191, 0, 0}));
  connect(kTDebCylShell_b.port_b, port_b) annotation(
    Line(points = {{40, 0}, {60, 0}}, color = {191, 0, 0}));
  annotation(preferredView = "model", 
    Diagram(coordinateSystem(extent = {{-80, 20}, {80, -20}})),
    Icon(graphics = {Ellipse(origin = {-4, 0}, lineColor = {230, 97, 0}, fillColor = {36, 31, 49}, fillPattern = FillPattern.Solid, lineThickness = 9, extent = {{-90, 90}, {90, -90}}), Line(origin = {-45, 85}, points = {{-17, -13}, {23, 15}}, color = {230, 97, 0}, thickness = 3), Line(origin = {71, -59}, points = {{-17, -13}, {29, 23}}, color = {230, 97, 0}, thickness = 3), Ellipse(origin = {-4, 0}, lineColor = {246, 211, 45}, lineThickness = 9, extent = {{-80, 80}, {80, -80}}), Line(origin = {-44, 0}, points = {{44, 0}, {-34, -6}}, color = {224, 27, 36}, thickness = 2), Text(origin = {-44, 11}, textColor = {224, 27, 36}, extent = {{-14, 15}, {14, -15}}, textString = "ra"), Line(origin = {44, 0}, points = {{44, -6}, {-44, 0}}, color = {129, 61, 156}, thickness = 2), Text(origin = {42, 10}, textColor = {129, 61, 156}, extent = {{-12, 14}, {12, -14}}, textString = "rb"), Line(origin = {53, 91}, points = {{-9, -5}, {11, 7}, {11, 7}, {11, 7}}, thickness = 0.5), Line(origin = {73, 83}, points = {{-11, -7}, {11, 7}, {11, 7}, {23, 15}}, thickness = 0.5), Line(origin = {87, 63}, points = {{-9, -7}, {11, 7}, {11, 7}, {11, 7}}, thickness = 0.5)}),
  Documentation(info = "<html><head></head><body>Two T-dependent thermal conductors connecting inner and outer radii of a cylindrical volume with a T-dependent heat capacitor located at the center-of-mass radius. The T(r) distribution for the conductors is determined at each step according to the lowest-order solution of Poisson's equation (see Functions.poissonCyl).<div><br></div><div>The default material parameters are those for Copper.</div></body></html>"));
end DebyeKTpipe;
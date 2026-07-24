within ThermalMatters.Components.CompositeObjects;

model DebyeKTVessel "Debye-Mass WF-Conducting Spherical Shell"
  extends Icons.Block;
  import Modelica.Units.SI;
  import const=Modelica.Constants;
  parameter SI.Length rin = 0.1 "m; Inner radius";
  parameter SI.Length rout = 0.2 "m; Outer radius";
  final parameter SI.Length rhalf = 0.75*(rout*rout*rout*rout-rin*rin*rin*rin)/(rout*rout*rout-rin*rin*rin);
  final parameter SI.Volume V = (4/3)*const.pi*(rout*rout*rout-rin*rin*rin);
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
  HeatCapacitors.DebyeSolid debyeSolid(V = V, T_D = T_D, effAm = effAm, Mdens = Mdens, T(start = T_start, fixed = true))  annotation(
    Placement(transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}})));
  ThermalConductors.KTDebSphShell kTDebSphShell_a(ra = rin, rb = rhalf, kappa0 = kappa0, T0 = T0, T_D = T_D, effAm = effAm, Mdens = Mdens)  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  ThermalConductors.KTDebSphShell kTDebSphShell_b(ra = rhalf, rb = rout, kappa0 = kappa0, T0 = T0, T_D = T_D, effAm = effAm, Mdens = Mdens)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(port_a, kTDebSphShell_a.port_a) annotation(
    Line(points = {{-60, 0}, {-40, 0}}, color = {191, 0, 0}));
  connect(kTDebSphShell_a.port_b, debyeSolid.port) annotation(
    Line(points = {{-20, 0}, {0, 0}}, color = {191, 0, 0}));
  connect(debyeSolid.port, kTDebSphShell_b.port_a) annotation(
    Line(points = {{0, 0}, {20, 0}}, color = {191, 0, 0}));
  connect(kTDebSphShell_b.port_b, port_b) annotation(
    Line(points = {{40, 0}, {60, 0}}, color = {191, 0, 0}));
  annotation(preferredView = "model", 
    Diagram(coordinateSystem(extent = {{-80, 20}, {80, -20}})),
    Icon(graphics = {Ellipse(origin = {-4, 0}, lineColor = {230, 97, 0}, fillColor = {255, 163, 72}, fillPattern = FillPattern.Backward, lineThickness = 9, extent = {{-90, 90}, {90, -90}}), Ellipse(origin = {-4, 0}, lineColor = {246, 211, 45}, lineThickness = 9, extent = {{-80, 80}, {80, -80}}), Line(origin = {-44, 0}, points = {{44, 0}, {-34, -6}}, color = {224, 27, 36}, thickness = 2), Text(origin = {-44, 11}, textColor = {224, 27, 36}, extent = {{-14, 15}, {14, -15}}, textString = "ra"), Line(origin = {44, 0}, points = {{44, -6}, {-44, 0}}, color = {129, 61, 156}, thickness = 2), Text(origin = {42, 10}, textColor = {129, 61, 156}, extent = {{-12, 14}, {12, -14}}, textString = "rb")}),
  Documentation(info = "<html><head></head><body><span style=\"font-family: 'Ubuntu Sans';\">Two T-dependent thermal conductors connecting inner and outer radii of a spherical volume with a T-dependent heat capacitor located at the center-of-mass radius. The T(r) distribution for the conductors is determined at each step according to the lowest-order solution of Poisson's equation (see Functions.poissonSph).</span><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">The default material parameters are those for Copper.</div></body></html>"));
end DebyeKTVessel;
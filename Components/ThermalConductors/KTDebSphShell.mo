within ThermalMatters.Components.ThermalConductors;

model KTDebSphShell "Kinetic-Theory-based Debye-solid conducting spherical shell"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  extends Icons.Block;
  import SI = Modelica.Units.SI;
  SI.Temperature T "Temperature of material";
  SI.ThermalConductance G "Thermal conductance of material";
  SI.Conductivity sigma "S/m; Electrical conductivity";
  SI.ThermalConductivity kappa "W/(m K); Thermal conductivity";
  SI.Length g "m; Geometrical factor";
  SI.SpecificHeatCapacity cp0,cp;
  SI.EnergyDensity e0,e;
  parameter SI.Length ra = 0.1 "m; Radius at port a";
  parameter SI.Length rb = 0.2 "m; Radius at port b";
  parameter SI.ThermalConductivity kappa0 = 401 "W/(m K); Thermal conductivity at T0";
  parameter SI.Temperature T0(displayUnit = "K") = 293 "K; Reference temperature";
  parameter SI.Temperature T_D(displayUnit = "K")= 343 "= Debye_Temperature (K)";
  parameter Real effAm= 63.546 "= Effective_Atomic_Mass (Da)";
  parameter SI.Density Mdens(displayUnit = "kg/m3") = 8935 "= Mass_density (kg/m^3)";
equation
  (T, g) = Functions.poissonSph(port_a.T, port_b.T, ra, rb);
  (e0,cp0) = Functions.debyeEoS(T0,T_D,effAm,Mdens);
  (e,cp) = Functions.debyeEoS(T,T_D,effAm,Mdens);
  (kappa, sigma) = Functions.ktCond(T,kappa0,T0,cp/cp0);
  G = g * kappa;
  Q_flow = G * dT;
  annotation(
    Documentation(info = "<html><head></head><body><div><p style=\"font-family: 'Ubuntu Sans';\">The temperature-dependent conductivity comes from kinetic theory:&nbsp;</p><div style=\"font-family: 'Ubuntu Sans';\">κ = ρ c&nbsp;〈v〉 Λ / 3 = (c<sub>p</sub>/c<sub>p0</sub>) (T<sub>0</sub>/T) κ<sub>0</sub>&nbsp;</div></div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">and c<sub>p</sub> is determined via the Debye model.&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div>The overall thermal conductance is...&nbsp;</div><div><br></div><div>G = g κ =&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">g&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">κ</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">(c</span><sub style=\"font-family: 'Ubuntu Sans';\">p</sub><span style=\"font-family: 'Ubuntu Sans';\">/c</span><sub style=\"font-family: 'Ubuntu Sans';\">p0</sub><span style=\"font-family: 'Ubuntu Sans';\">)&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">(T</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">/T)&nbsp;</span></div><div><br></div><div>where g is a purely geometrical factor with an overall unit of length (m):&nbsp;</div><div><br></div><div><div style=\"font-family: 'Ubuntu Sans';\"><div>g = 4π / (1/r<sub>a</sub>&nbsp;- 1/r<font size=\"2\"><sub>b</sub></font>) &nbsp; for a spherical shell of inner and outer radii of r<sub>a</sub>&nbsp;and r<sub>b</sub>.</div><div><br></div><div>Note: for composite objects,&nbsp;r<sub>a</sub>&nbsp;and r<sub>b</sub>&nbsp;should reflect the center-of-mass coordinates of any heat capacitors at a and b.</div><div><br></div><div>T is taken as the average temperature from the Poisson-Eq solution in spherical coordinates&nbsp;(quasi-steady-state).</div></div></div><div><br></div><div><span style=\"font-family: 'Ubuntu Sans';\">The default parameters are those appropriate for copper.</span></div><div><br></div><div>(see also ThermalMatters.Functions.ktCond and&nbsp;ThermalMatters.Functions.poissonSph).</div></body></html>"),
  Icon(graphics = {Ellipse(origin = {-4, 0}, lineColor = {230, 97, 0}, fillColor = {255, 163, 72}, fillPattern = FillPattern.Backward, lineThickness = 9, extent = {{-90, 90}, {90, -90}}), Line(origin = {-44, 0}, points = {{44, 0}, {-42, -6}}, color = {224, 27, 36}, thickness = 2), Text(origin = {-44, 11}, textColor = {224, 27, 36}, extent = {{-14, 15}, {14, -15}}, textString = "ra"), Text(origin = {42, 10}, textColor = {129, 61, 156}, extent = {{-12, 14}, {12, -14}}, textString = "rb"), Line(origin = {44, 0}, points = {{44, -6}, {-44, 0}}, color = {129, 61, 156}, thickness = 2)}),
  Diagram(graphics));
end KTDebSphShell;
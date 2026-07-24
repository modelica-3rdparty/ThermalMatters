within ThermalMatters.Components.ThermalConductors;

model KTDebWall "Kinetic-Theory-based Debye-solid conducting planar wall"
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
  parameter SI.Length d = 0.1 "m; Thickness";
  parameter SI.Area A = 1 "m^2; Area";
  parameter SI.ThermalConductivity kappa0 = 401 "W/(m K); Thermal conductivity at T0";
  parameter SI.Temperature T0(displayUnit = "K") = 293 "K; Reference temperature";
  parameter SI.Temperature T_D(displayUnit = "K")= 343 "= Debye_Temperature (K)";
  parameter Real effAm= 63.546 "= Effective_Atomic_Mass (Da)";
  parameter SI.Density Mdens(displayUnit = "kg/m3") = 8935 "= Mass_density (kg/m^3)";
equation
  (T, g) = Functions.poissonWall(port_a.T, port_b.T, A, d);
  (e0,cp0) = Functions.debyeEoS(T0,T_D,effAm,Mdens);
  (e,cp) = Functions.debyeEoS(T,T_D,effAm,Mdens);
  (kappa, sigma) = Functions.ktCond(T,kappa0,T0,cp/cp0);
  G = g * kappa;
  Q_flow = G * dT;
  annotation(
    Documentation(info = "<html><head></head><body><div><p style=\"font-family: 'Ubuntu Sans';\">The temperature-dependent conductivity comes from kinetic theory:&nbsp;</p><div style=\"font-family: 'Ubuntu Sans';\">κ = ρ c&nbsp;〈v〉 Λ / 3 = (c<sub>p</sub>/c<sub>p0</sub>) (T<sub>0</sub>/T) κ<sub>0</sub>&nbsp;</div></div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">and c<sub>p</sub> is determined via the Debye model.&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div>The overall thermal conductance is...&nbsp;</div><div><br></div><div>G = g κ =&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">g&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">κ</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">(c</span><sub style=\"font-family: 'Ubuntu Sans';\">p</sub><span style=\"font-family: 'Ubuntu Sans';\">/c</span><sub style=\"font-family: 'Ubuntu Sans';\">p0</sub><span style=\"font-family: 'Ubuntu Sans';\">)&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">(T</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">/T)&nbsp;</span></div><div><br></div><div>where g is a purely geometrical factor with an overall unit of length (m):&nbsp;</div><div><br></div><div>g = A / d &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for a planar wall of area, A, and thickness, d.&nbsp;</div><div><br></div><div><span style=\"font-family: 'Ubuntu Sans';\">T is taken as the average temperature from the Poisson-Eq solution in 1D planar coordinates (quasi-steady-state).</span></div><div><br></div><div><span style=\"font-family: 'Ubuntu Sans';\">The default parameters are those appropriate for copper.</span></div><div><br></div><div>(see also ThermalMatters.Functions.ktCond and&nbsp;ThermalMatters.Functions.poissonWall).</div></body></html>"),
  Icon(graphics = {Rectangle( lineColor = {230, 97, 0}, fillColor = {255, 190, 111}, fillPattern = FillPattern.Backward, lineThickness = 2, extent = {{-88, 98}, {88, -98}})}));
end KTDebWall;
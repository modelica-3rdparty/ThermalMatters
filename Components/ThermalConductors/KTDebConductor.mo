within ThermalMatters.Components.ThermalConductors;

model KTDebConductor "Kinetic-Theory-based Debye-solid conductor"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  extends Icons.Conductor;
  import SI = Modelica.Units.SI;
  SI.Temperature T "Temperature of material";
  SI.ThermalConductance G "Thermal conductance of material";
  SI.Conductivity sigma "S/m; Electrical conductivity";
  SI.ThermalConductivity kappa "W/(m K); Thermal conductivity";
  SI.SpecificHeatCapacity cp0,cp;
  SI.EnergyDensity e0,e;
  parameter SI.Length g = 1 "m; Geometrical factor";
  parameter Real w = 0.5 "Weight factor of Ta (0<w<1)";
  parameter SI.ThermalConductivity kappa0 = 401 "W/(m K); Thermal conductivity at T0";
  parameter SI.Temperature T0(displayUnit = "K") = 293 "K; Reference temperature";
  parameter SI.Temperature T_D(displayUnit = "K")= 343 "= Debye_Temperature (K)";
  parameter Real effAm= 63.546 "= Effective_Atomic_Mass (Da)";
  parameter SI.Density Mdens(displayUnit = "kg/m3") = 8935 "= Mass_density (kg/m^3)";
equation
  T = w*port_a.T + (1 - w)*port_b.T;
  (e0,cp0) = Functions.debyeEoS(T0,T_D,effAm,Mdens);
  (e,cp) = Functions.debyeEoS(T,T_D,effAm,Mdens);
  (kappa, sigma) = Functions.ktCond(T,kappa0,T0,cp/cp0);
  G = g*kappa;
  Q_flow = G*dT;
  annotation(
    Documentation(info = "<html><head></head><body><div><div>The overall thermal conductance is modeled as...&nbsp;</div><div><br></div><div>G = g κ =&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">g&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">κ</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">&nbsp;(T</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">/T)&nbsp;</span></div><div><br></div><div>where T is the absolute temperature [taken here as the weighted average of the values at the two heat ports: T=wT<sub>a</sub>+(1-w)T<sub>b</sub>] and g is a purely geometrical factor with an overall unit of length (m): e.g.,&nbsp;</div><div><br></div><div>g = A / d &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for a planar wall of area, A, and thickness, d... or...&nbsp;</div><div>g = 2π l / ln(r<sub>b</sub>/r<sub>a</sub>) &nbsp; &nbsp; &nbsp; for a cylindrical shell of length, l, and inner and outer radii of r<sub>a</sub>&nbsp;and r<sub>b</sub>&nbsp;(radial heat flow)... or...</div><div>g = 4π / (1/r<sub>a</sub>&nbsp;- 1/r<font size=\"2\"><sub>b</sub></font>) &nbsp; for a spherical shell of inner and outer radii of r<sub>a</sub>&nbsp;and r<sub>b</sub>.</div><p style=\"font-family: 'Ubuntu Sans';\">The temperature-dependent conductivity comes from kinetic theory:&nbsp;</p><div style=\"font-family: 'Ubuntu Sans';\">κ = ρ c&nbsp;〈v〉 Λ / 3&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">where κ is the thermal conductivity, ρ is the mass density, c (=c<sub>p</sub>) is the specific heat capacity (obtained from the Debye model), 〈v〉 is the mean phonon speed (~ sound speed, c<sub>s</sub>), Λ is the phonon mean free path, and T is the absolute temperature. The specific heat capacity at T is taken as an input and the phonon mean free path is chosen to behave as ~ 1/T, appropriate for all but the lowest temperatures:&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">κ = (c<sub>p</sub>/c<sub>p0</sub>) (T<sub>0</sub>/T) κ<sub>0</sub>&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">For metals the theory is more complicated due to the participation of the conduction electrons in the energy propagation through interaction with the phonons, but the general form above is similar (the differing physics -- 〈v〉Λ being much larger -- is \"absorbed\" into the κ<sub>0</sub>&nbsp;term).&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\"><div>The electrical conductivity (for good conductors) may then be estimated via the Wiedemann-Franz relation:</div><div><br></div><div>σ = κ / (L T)&nbsp;</div></div></div><div><br></div><div>where κ is the thermal conductivity, σ is the electrical conductivity, L is known as the Lorenz number, and&nbsp;</div><div><br></div><div><span style=\"font-family: 'Ubuntu Sans';\">The default parameters are those appropriate for copper.</span></div><div><br></div><div>(see also ThermalMatters.Functions.ktCond and Modelica.Thermal.HeatTransfer.Components.ThermalConductor).</div></body></html>"));
end KTDebConductor;
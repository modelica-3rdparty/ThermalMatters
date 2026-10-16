within ThermalMatters.Components.ThermalConductors;

model WFconductor "Wiedemann-Franz conductor"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  extends ThermalMatters.Icons.Conductor;
  import SI = Modelica.Units.SI;
  SI.Temperature T "Temperature of material";
  SI.ThermalConductance G "Thermal conductance of material";
  SI.Conductivity sigma "S/m; Electrical conductivity";
  SI.ThermalConductivity kappa "W/(m K); Thermal conductivity";
  // parameter Real L=2.44e-8 "V^2 K^-2; Lorenz number";
  parameter SI.Length g=1 "m; Geometrical factor";
  parameter Real w=0.5 "Weight factor of Ta (0<w<1)";
  // parameter SI.Conductivity sigma0=59.6e6 "S/m; Electrical conductivity";
  parameter SI.ThermalConductivity kappa0 = 401 "W/(m K); Thermal conductivity at T0";
  parameter SI.Temperature T0(displayUnit = "K")=293 "K; Reference temperature";
  // parameter SI.LinearTemperatureCoefficient a0=4.04e-3 "1/K; Resistivity T coefficient";
  // parameter SI.Temperature Tkmax(displayUnit = "K")=10 "Temperature of max kappa (K)";
equation
  T = w*port_a.T + (1-w)*port_b.T;
  (kappa,sigma) = ThermalMatters.Functions.wfCond(T,kappa0,T0);
  G = g * kappa;
  Q_flow = G*dT;
annotation(
    Documentation(info = "<html><head></head><body><div><span style=\"font-family: 'Ubuntu Sans';\">** Note: good approximation for T &gt;&gt; T<sub>k,max</sub>&nbsp;(where&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">κ is a maximum; see Functions.wfCond). **&nbsp;</span></div>Model of a temperature-dependent thermal conductor obeying the Wiedemann-Franz relation:<div><br></div><div>κ / σ = L T&nbsp;</div><div><br></div><div>where κ is the thermal conductivity, σ is the electrical conductivity, L is known as the Lorenz number, and T is the absolute temperature [taken here as the weighted average of the values at the two heat ports: T=wT<sub>a</sub>+(1-w)T<sub>b</sub>].</div><div><br></div><div>For good electrical conductors (e.g., metals), both conductivities are dominated by the (nearly free) conduction electrons. The empirical value of the Lorenz number is rather close to the free-electron model value:</div><div><br></div><div>L = π<sup>2</sup> k<sub>B</sub><sup>2&nbsp;</sup>/ (3 e<sup>2</sup>)&nbsp; ≅ 2.44 × 10<sup>-8</sup> V<sup>2</sup> K<sup>-2</sup>&nbsp;</div><div><br></div><div>The thermal conduc<span style=\"font-family: 'Ubuntu Sans';\">tivity</span>&nbsp;is modeled with a T<sup>-1</sup> temperature response:&nbsp;</div><div><br></div><div>κ = κ<sub>0</sub>&nbsp;(T<sub>0</sub>/T)&nbsp;</div><div><br></div><div>The overall thermal conductance is then...&nbsp;</div><div><br></div><div>G = g κ =&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">g&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">κ</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">&nbsp;(T</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub><span style=\"font-family: 'Ubuntu Sans';\">/T)&nbsp;</span></div><div><br></div><div>where g is a purely geometrical factor with an overall unit of length (m): e.g.,&nbsp;</div><div><br></div><div>g = A / d &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for a planar wall of area, A, and thickness, d... or...&nbsp;</div><div>g = 2π l / ln(r<sub>b</sub>/r<sub>a</sub>) &nbsp; &nbsp; &nbsp; for a cylindrical shell of length, l, and inner and outer radii of r<sub>a</sub> and r<sub>b</sub>&nbsp;(radial heat flow)... or...</div><div>g = 4π / (1/r<sub>a</sub> - 1/r<font size=\"2\"><sub>b</sub></font>) &nbsp; for a spherical shell of inner and outer radii of r<sub>a</sub>&nbsp;and r<sub>b</sub>.</div><div><br></div><div><span style=\"font-family: 'Ubuntu Sans';\">The default parameters are those appropriate for copper.</span></div><div><br></div><div>(see also ThermalMatters.Functions.wfCond and Modelica.Thermal.HeatTransfer.Components.ThermalConductor).</div></body></html>"));
end WFconductor;
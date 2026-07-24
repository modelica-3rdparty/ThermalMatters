within ThermalMatters.Functions;
function ktCond "Kinetic-theory-based thermal conductivity function (kappa,sigma) = ktCond(T,kappa0,T0,cp/cp0)"
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  input SI.Temperature T "= Temperature (K)";
  input SI.ThermalConductivity kappa0 "= Thermal conductivity at T0 (W/(K m))";
  input SI.Temperature T0 "= Reference_Temperature (K)";
  input Real cp_cp0 "= Specific_Heat_Capacity ratio";
  output SI.ThermalConductivity kappa "= Thermal conductivity (W/(K m))";
  output SI.Conductivity sigma "= Estim. Elec. Conductivity (S/m)";
protected
  parameter Real L = 2.44e-8 "Lorenz number (V^2 K^-2)";
algorithm
  kappa := kappa0 * (T0 / T) * cp_cp0;
  sigma := kappa / (L * T);
  annotation(preferredView = "text", 
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>(kappa,sigma) = ThermalMatters.Functions.<b>ktCond</b>(T,kapp0,T0,cp/cp0);</pre></blockquote>

<h4>Description</h4><p><span style=\"font-family: 'Ubuntu Sans';\">Model of a temperature-dependent conductivity from kinetic theory:&nbsp;</span></p><div style=\"font-family: 'Ubuntu Sans';\">κ = ρ c&nbsp;〈v〉 Λ / 3&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">where κ is the thermal conductivity, ρ is the mass density, c is the specific heat capacity, 〈v〉 is the mean phonon speed (~ sound speed, c<sub>s</sub>), Λ is the phonon mean free path, and T is the absolute temperature. The specific heat capacity at T is taken as an input and the phonon mean free path is chosen to behave as ~ 1/T, appropriate for all but the lowest temperatures:&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">κ = (c<sub>p</sub>/c<sub>p0</sub>) (T<sub>0</sub>/T) κ<sub>0</sub>&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">For metals the theory is more complicated due to the participation of the conduction electrons in the energy propagation through interaction with the phonons, but the general form above is similar (the differing physics -- 〈v〉Λ being much larger -- is \"absorbed\" into the κ<sub>0</sub>&nbsp;term).&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\"><div>The electrical conductivity (for good conductors) may then be estimated via the Wiedemann-Franz relation:</div><div><br></div><div>σ = κ / (L T)&nbsp;</div><div><br></div></div><div style=\"font-family: 'Ubuntu Sans';\">For good electrical conductors (e.g., metals), both conductivities are dominated by the (nearly free) conduction electrons. The empirical value of the Lorenz number is rather close to the free-electron model value:</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">L = π<sup>2</sup>&nbsp;k<sub>B</sub><sup>2&nbsp;</sup>/ (3 e<sup>2</sup>)&nbsp; ≅ 2.44 × 10<sup>-8</sup>&nbsp;V<sup>2</sup>&nbsp;K<sup>-2</sup>&nbsp;</div>

<p>For more details, see [KK] and&nbsp;<a href=\"http://en.wikipedia.org/wiki/Wiedemann%E2%80%93Franz_law\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre><br></pre></blockquote>

<h4>See also</h4>
<p><br></p>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>May 26, 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"));
end ktCond;
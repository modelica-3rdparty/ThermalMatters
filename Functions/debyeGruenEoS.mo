within ThermalMatters.Functions;
function debyeGruenEoS "Debye-Grueneisen Equation of State function (Edens,c_p,alpha) = debyeGruenEoS(T,T_D,effAm,Mdens,alpha0,T0)"
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  input SI.Temperature T "= Temperature (K)";
  input SI.Temperature T_D "= Debye_Temperature (K)";
  input Real effAm "= Effective_Atomic_Mass (Da)";
  input SI.Density Mdens "= Mass_density (kg/m^3)";
  input SI.CubicExpansionCoefficient alpha0 "= Thermal expansion coefficient (1/K)";
  input SI.Temperature T0 "= Reference Temperature (K)";
  output SI.EnergyDensity Edens "= Energy_density (J/m^3)";
  output SI.SpecificHeatCapacity c_p "= Specific_Heat_Capacity (J/(kg K))";
  output SI.CubicExpansionCoefficient alpha "= Thermal expansion coefficient (1/K)";
protected
  SI.EnergyDensity e0,e;
  SI.SpecificHeatCapacity c0,c;
  Real a_over_c;
algorithm
  (e0,c0) := Functions.debyeEoS(T0,T_D,effAm,Mdens);
// alpha/c_p is independent of temperature (Grueneisen's law); use ratio at T0 and c_p(T) to find alpha(T)
  a_over_c := alpha0 / c0;
  (e,c) := Functions.debyeEoS(T,T_D,effAm,Mdens);
  alpha := a_over_c * c;
// energy density:
  Edens := e*(1+0.5*alpha*T);
// specific heat capacity:
  c_p := c*(1+0.5*alpha*T) + 0.5*e*alpha/Mdens;
  annotation(preferredView = "text", 
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>(Edens,c_p,alpha) = ThermalMatters.Functions.<b>debyeGruenEoS</b>(T,T_D,effAm,Mdens,alpha0,T0);</pre></blockquote>

<h4>Description</h4>
<p><span style=\"font-family: 'Ubuntu Sans';\">Debye-Grüneisen (Isotropic Quasi-Harmonic-Approximation) Equation of State (EoS), appropriate for the acoustic phonon contribution in solids.</span></p><div style=\"font-family: 'Ubuntu Sans';\">Energy density:</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">e = 3 n k T [1 + α(T) T/2] D<sub>3</sub>(x)</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">where n is the number density of atoms,&nbsp;D<sub>3</sub>(x) is the third Debye function, x=T<sub>D</sub>/T, and T<sub>D</sub>&nbsp;is the Debye temperature:</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">T<sub>D</sub>&nbsp;= [h c<sub>s</sub>&nbsp;/ (2 k)] (6 n / π)<sup>1/3</sup>&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">c<sub>s</sub>&nbsp;being the sound speed in the material.</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">α(T) is the thermal expansion coefficient at temperature T. It is determined via the input reference value &nbsp;α<sub>0</sub> = α(T<sub>0</sub>) and Grüneisen's law: α(T)/c<sub>p</sub>(T) is independent of T.</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">With proper values of T<sub>D</sub>&nbsp;(in K), the atomic mass (effAm in Da), and the mass density (ρ or Mdens in kg m<sup>-3</sup>), this function will provide the energy density (in J m<sup>-3</sup>) as a function of the input temperature (in K): e(T). The specific heat capacity, c<sub>p</sub>(T) (in J kg<sup>-1</sup>&nbsp;K<sup>-1</sup>), is also calculated from the derivative wrt T.</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">c<sub>p</sub>&nbsp;= (1 + α T/2) c<sub>p,Debye</sub> + (e<sub>Debye</sub>/ρ) α/2&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">Higher order terms involving dα/dT are neglected.</div>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Gr%C3%BCneisen_parameter\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre><br></pre></blockquote>

<h4>See also</h4>
<p><br></p>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>May 10, 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"));
end debyeGruenEoS;
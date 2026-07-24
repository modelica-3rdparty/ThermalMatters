within ThermalMatters.Functions;
function debyeEoS "Debye Equation of State function (Edens,c_p) = debyeEoS(T,T_D,effAm,Mdens)"
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  input SI.Temperature T "= Temperature (K)";
  input SI.Temperature T_D "= Debye_Temperature (K)";
  input Real effAm "= Effective_Atomic_Mass (Da)";
  input SI.Density Mdens "= Mass_density (kg/m^3)";
  // output Real y[2] "= {Energy_density (J/m^3) , Specific_Heat_Capacity (J/(kg K))}";
  output SI.EnergyDensity Edens "= Energy_density (J/m^3)";
  output SI.SpecificHeatCapacity c_p "= Specific_Heat_Capacity (J/(kg K))";
  import const = Modelica.Constants;
protected
  Real x;
  Real bern_x;
  Real debye3_x;
  constant Real ndens = Mdens/(effAm*1.66053906892e-27) "= Number density of atoms (1/m^3)";
  constant Real c_s = (2*T_D*const.k/const.h) * (const.pi/(6*ndens))^0.3333333333333 "= Sound speed (m/s)";
algorithm
  x := T_D / T;
  bern_x := x / (exp(x) - 1.0);
  // debye3_x := GNU_ScientificLibrary.Functions.specfunc.debye_D3(x);
  debye3_x := ThermalMatters.Utilities.debye3(x);
  // energy density:
  Edens := 3.0 * ndens * const.k * T * debye3_x;
  // specific heat capacity:
  //  using...  x D'_n(x) = n ( B(x) - D_n(x) )
  // c_p = ( Edens/T - 9*ndens*const.k*(B(x) - D_3(x)) ) / Mdens;
  c_p := ndens * const.k * (12.0 * debye3_x - 9.0 * bern_x) / Mdens;
  annotation(preferredView = "text", 
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>(Edens,c_p) = ThermalMatters.Functions.<b>debyeEoS</b>(T,T_D,effAm,Mdens);</pre></blockquote>

<h4>Description</h4>
<p><span style=\"font-family: 'Ubuntu Sans';\">Debye-model (Isotropic, Harmonic) Equation of State (EoS), appropriate for the&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">acoustic&nbsp;</span><span style=\"font-family: 'Ubuntu Sans';\">phonon contribution in solids.</span></p><div style=\"font-family: 'Ubuntu Sans';\">Energy density:</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">e = 3 n k T D<sub>3</sub>(x)</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">where n is the number density of atoms,&nbsp;D<sub>3</sub>(x) is the third Debye function, x=T<sub>D</sub>/T, and T<sub>D</sub>&nbsp;is the Debye temperature:</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">T<sub>D</sub>&nbsp;= [h c<sub>s</sub>&nbsp;/ (2 k)] (6 n / π)<sup>1/3</sup>&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">c<sub>s</sub>&nbsp;being the sound speed in the material (value obtainable via the constant, *.c_s).</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">With proper values of T<sub>D</sub>&nbsp;(in K), the atomic mass (effAm in Da), and the mass density (ρ or Mdens in kg m<sup>-3</sup>), this function will provide the energy density (in J m<sup>-3</sup>) as a function of the input temperature (in K): e(T). The specific heat capacity, c<sub>p</sub>(T) (in J kg<sup>-1</sup>&nbsp;K<sup>-1</sup>), is also calculated from the derivative wrt T (c<sub>p</sub> = c<sub>v</sub> is a good approximation for solids and most liquids):</div><div style=\"font-family: 'Ubuntu Sans';\"><br></div><div style=\"font-family: 'Ubuntu Sans';\">c<sub>p</sub>&nbsp;= [e/T - 9 n k (B(x)-D<sub>3</sub>(x))] / ρ = n k [12 D<sub>3</sub>(x) - 9 B(x)] / ρ&nbsp;</div><div style=\"font-family: 'Ubuntu Sans';\"><font face=\"DejaVu Sans Mono\"><br></font></div><div style=\"font-family: 'Ubuntu Sans';\"><font face=\"DejaVu Sans Mono\">where &nbsp;B(x)=x/(exp(x)-1) &nbsp;and &nbsp;x D'<sub>3</sub>(x)=3[B(x)-D<sub>3</sub>(x)] .</font></div>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Debye_model\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre><br></pre></blockquote>

<h4>See also</h4>
<p><br></p>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>April 1, 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"));
end debyeEoS;
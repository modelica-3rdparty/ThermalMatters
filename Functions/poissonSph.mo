within ThermalMatters.Functions;
function poissonSph "Spherical Poisson-Eq. average temperature function (Tavg,g) = poissonSph(Ta,Tb,ra.rb)"
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  import const = Modelica.Constants;
  input SI.Temperature Ta "= Temperature (K)";
  input SI.Temperature Tb "= Temperature (K)";
  input SI.Length ra "= Radius (m)";
  input SI.Length rb "= Radius (m)";
  output SI.Temperature Tavg "= Temperature (K)";
  output SI.Length g "= Geometric factor (m)";
protected
  Real invra, invrb, A, C, ra2, rb2, ra3, rb3;
algorithm
  invra := 1 / ra;
  invrb := 1 / rb;
// T(r) = A / r + C
  A := (Tb - Ta)/(invrb - invra);
  C := Ta - A * invra;
  ra2 := ra * ra;
  rb2 := rb * rb;
  ra3 := ra2 * ra;
  rb3 := rb2 * rb;
  Tavg := 1.5 * A * (rb2 - ra2) / (rb3 - ra3) + C;
  g := 4 * const.pi / (invra - invrb);
  annotation(preferredView = "text", 
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>(Tavg,g) = ThermalMatters.Functions.<b>poissonSph</b>(Ta,Tb,ra,rb);</pre></blockquote>

<h4>Description</h4>
<p>Function for calculating the&nbsp;geometric conductance factor (g) and the average temperature (T<sub>avg</sub>) based upon the lowest-order solution to Poisson's (or Laplace's) Equation,&nbsp;</p><p>∇<sup>2</sup>T = 0&nbsp;</p><p>in a spherically symmetric geometry:&nbsp;</p><p>T(r) = T<sub>a</sub> + (T<sub>b</sub> - T<sub>a</sub>) (1/r - 1/r<sub>a</sub>)&nbsp;/ (1/r<sub>b</sub>&nbsp;- 1/r<sub>a</sub>)&nbsp;</p><p>T<sub>avg</sub> = T<sub>a</sub> + (T<sub>b</sub>&nbsp;- T<sub>a</sub>)&nbsp;[(3/2) (r<sub>b</sub><sup>2</sup>&nbsp;- r<sub>a</sub><sup>2</sup>) / (r<sub>b</sub><sup>3</sup> - r<sub>a</sub><sup>3</sup>) + 1/r<sub>a</sub>] / (1/r<sub>b</sub>&nbsp;- 1/r<sub>a</sub>)&nbsp;</p><p>g = 4&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">π</span>&nbsp;/ (1/r<sub>a</sub>&nbsp;- 1/r<sub>b</sub>) .</p>

<p>
For more details, see [RHB] and&nbsp;<a href=\"http://en.wikipedia.org/wiki/Poisson%27s_equation\">Wikipedia</a>.</p>

<h4>Example</h4>
<blockquote><pre><br></pre></blockquote>

<h4>See also</h4>
<p><br></p>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>June 4, 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"));
end poissonSph;
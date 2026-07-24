within ThermalMatters.Functions;
function poissonCyl "Cylindrical Poisson-Eq. average temperature function (Tavg,g) = poissonCyl(Ta,Tb,ra.rb,l)"
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  import const=Modelica.Constants;
  input SI.Temperature Ta "= Temperature (K)";
  input SI.Temperature Tb "= Temperature (K)";
  input SI.Length ra "= Radius (m)";
  input SI.Length rb "= Radius (m)";
  input SI.Length l "= Length (m)";
  output SI.Temperature Tavg "= Temperature (K)";
  output SI.Length g "= Geometric factor (m)";
protected
  Real lnra,lnrb,A,C,ra2,rb2;
algorithm
  lnra := log(ra);
  lnrb := log(rb);
// T(r) = A ln(r) + C
  A := (Tb - Ta) / (lnrb - lnra);
  C := Ta - A * lnra;
  ra2 := ra * ra;
  rb2 := rb * rb;
  Tavg := A * ((rb2 * lnrb - ra2 * lnra) / (rb2 - ra2) - 0.5) + C;
  g := 2 * const.pi * l / (lnrb - lnra);
  annotation(preferredView = "text", 
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>(Tavg,g) = ThermalMatters.Functions.<b>poissonCyl</b>(Ta,Tb,ra,rb,l);</pre></blockquote>

<h4>Description</h4>
<p>Function for calculating the geometric conductance factor (g) and the average temperature (T<sub>avg</sub>) based upon the lowest-order solution to Poisson's (or Laplace's) Equation,&nbsp;</p><p>∇<sup>2</sup>T = 0&nbsp;</p><p>in a cylindrical geometry (assuming length, l &gt;&gt; r<sub>a,b</sub>):&nbsp;</p><p>T(r) = T<sub>a</sub> + (T<sub>b</sub> - T<sub>a</sub>) ln(r/r<sub>a</sub>) / ln(r<sub>b</sub>/r<sub>a</sub>)&nbsp;</p><p>T<sub>avg</sub> = T<sub>a</sub> + (T<sub>b</sub>&nbsp;- T<sub>a</sub>)&nbsp;[(r<sub>b</sub><sup>2</sup> ln(r<sub>b</sub>) - r<sub>a</sub><sup>2</sup> ln(r<sub>a</sub>)) / (r<sub>b</sub><sup>2</sup> - r<sub>a</sub><sup>2</sup>) - (ln(r<sub>a</sub>) + 1/2)] / ln(r<sub>b</sub>/r<sub>a</sub>)&nbsp;</p><p>g = 2&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">π&nbsp;</span>l / ln(r<sub>b</sub>/r<sub>a</sub>) .</p>

<p>
For more details, see [RHB] and&nbsp;<a href=\"http://en.wikipedia.org/wiki/Poisson%27s_equation\">Wikipedia</a>.
</p>

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
end poissonCyl;
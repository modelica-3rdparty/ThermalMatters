within ThermalMatters.Functions;
function poissonWall "Planar Poisson-Eq. average temperature function (Tavg,g) = poissonWall(Ta,Tb,A,d)"
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  input SI.Temperature Ta "= Temperature (K)";
  input SI.Temperature Tb "= Temperature (K)";
  input SI.Area A "= Area (m^2)";
  input SI.Length d "= Thickness (m)";
  output SI.Temperature Tavg "= Temperature (K)";
  output SI.Length g "= Geometric factor (m)";
algorithm
  Tavg := 0.5 * (Ta + Tb);
  g := A / d;
  annotation(preferredView = "text", 
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>(Tavg,g) = ThermalMatters.Functions.<b>poissonWall</b>(Ta,Tb,A,d);</pre></blockquote>

<h4>Description</h4>
<p>Function for calculating the geometric conductance factor (g) and the average temperature (T<sub>avg</sub>) based upon the lowest-order solution to Poisson's (or Laplace's) Equation,&nbsp;</p><p>∇<sup>2</sup>T = 0&nbsp;</p><p>in a planar geometry:&nbsp;</p><p>T(x) = T<sub>a</sub> + (T<sub>b</sub> - T<sub>a</sub>) x / d&nbsp;</p><p>T<sub>avg</sub> = (T<sub>a</sub> + T<sub>b</sub>)/2&nbsp;</p><p>g = A/d .</p>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Poisson%27s_equation\">Wikipedia</a>.
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
end poissonWall;
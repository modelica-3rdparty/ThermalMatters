within ThermalMatters.Utilities;
function fd_asymp
  extends Modelica.Icons.Function;
  input Real u;
  // j = -1, 0, 1, ... for F_j+1/2 ; 0 < order < 16
  input Integer j,order;
  output Real y;
  protected
    Integer k;
    Real a,G,core,term,sum;
    // zeta(2k), k = 0, 1, 2, ...
    constant Real zeta2k[16] = {-0.5,
                                1.6449340668482264,
                                1.0823232337111382,
                                1.0173430619844491,
                                1.0040773561979443,
                                1.0009945751278181,
                                1.0002460865533080,
                                1.0000612481350587,
                                1.0000152822594087,
                                1.0000038172932650,
                                1.0000009539620339,
                                1.0000002384505027,
                                1.0000000596081891,
                                1.0000000149015548,
                                1.0000000037253340,
                                1.0000000009313274};
algorithm
  sum := 0;
  a := 0.5 + j;
  if j < -1 then
  end if;
  if order < 1 then
  elseif order > 15 then
  end if;
  // a = j + 1/2
// F_a(u) = Sum_k=1^order (-1)^(k-1) exp(ku) k^(-1-a) :
if u <= 1.5 then
    core := -exp(u);
    term := 1.0;
    for k in 1:order loop
      term := term * core;
      sum := sum - term * (k)^(-1.0-a);
    end for;
    y := sum;
  // a = j + 1/2
// F_a(u) = 2 u^(a+1) Sum_k=0^(order-1) (1-2^(1-2k)) zeta(2k) u^(-2k) / Gamma(a+2-2k) :
else
    core := 1/(u*u);
    term := 1.0;
// Gamma(3/2) : for j=-1, a+2=3/2
    G := 0.5*sqrt(Modelica.Constants.pi);
// Gamma(j+1/2+2)
    for k in 1:(j+1) loop
      G := G * (0.5 + k);
    end for;
    for k in 0:(order-1) loop
      sum := sum + term * (1.0 - 2.0 * 0.25^k) * zeta2k[k+1] / G;
// Gamma(a+2-2k) and term for next loop
      G := G / (a + 2 - 2*k - 1) / (a + 2 - 2*k - 2);
      term := term * core;
    end for;
    y := 2.0 * u^(a+1) * sum;
  end if;
annotation(preferredView = "text",
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>ThermalMatters.Utilities.<b>fd_asymp</b>(u,j,order);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the u&lt;0 and u&gt;&gt;1 expansions of the complete Fermi-Dirac integral fd_asymp(u,j,order) = 3/Gamma(j+3/2)*Integral_0_inf x^(j+1/2)/(exp(x-u)+1)*dx&nbsp; to \"order\" order.</p>

<p>j &gt;= -1&nbsp; and&nbsp; 0 &lt; order &lt; 16.</p><p>
For more details, see <a href=\"https://en.wikipedia.org/wiki/Complete_Fermi%E2%80%93Dirac_integral\">Wikipedia</a>.&nbsp;</p>

<h4>Example</h4>
<blockquote><pre><br></pre></blockquote>

<h4>See also</h4><div><br></div>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>November 1, 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"));
end fd_asymp;
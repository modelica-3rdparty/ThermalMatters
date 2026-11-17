within ThermalMatters.Utilities;
function fd_asymp
  extends Modelica.Icons.Function;
  input Real u;
  // j = -1, 0, 1, ... for F_j+1/2 ; 0 < order < 21
  input Integer j,order;
  output Real y,last;
  protected
    Integer k,jj,ord;
    Real a,G,core,term,sum;
    // zeta(2k), k = 0, 1, 2, ... , 20
    constant Real zeta2k[21] = {-0.5,
                                1.64493406684822643637,
                                1.08232323371113819152,
                                1.01734306198444913971,
                                1.00407735619794433938,
                                1.00099457512781808534,
                                1.00024608655330804830,
                                1.00006124813505870483,
                                1.00001528225940865187,
                                1.00000381729326499984,
                                1.00000095396203387280,
                                1.00000023845050272773,
                                1.00000005960818905126,
                                1.00000001490155482837,
                                1.00000000372533402479,
                                1.00000000093132743242,
                                1.00000000023283118337,
                                1.00000000005820772088,
                                1.00000000001455192189,
                                1.00000000000363797955,
                                1.00000000000090949478};
algorithm
  sum := 0;
  jj := j;
  ord := order;
  if j < -1 then
    print("fd_asymp error: input j must be >= -1 ... using j=-1");
    jj := -1;
  end if;
  if order < 1 or order > 20 then
    print("fd_asymp error: input must respect 0 < order < 21 ... using order=1");
    ord := 1;
  end if;
  a := 0.5 + jj;
  // a = j + 1/2
  // F_a(u) = Sum_k=1^order (-1)^(k-1) exp(ku) k^(-1-a) :
  if u <= 1.5 then
    core := -exp(u);
    term := 1.0;
    for k in 1:ord loop
      term := term * core;
      last := -term * (k)^(-1.0-a);
      sum := sum + last;
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
    for k in 1:(jj+1) loop
      G := G * (0.5 + k);
    end for;
    for k in 0:ord loop
      last := term * (1.0 - 2.0 * 0.25^k) * zeta2k[k+1] / G;
      sum := sum + last;
      // Gamma(a+2-2k) and "term" for next order 
      if k < ord then
        G := G / (a + 1.0 - 2.0*k) / (a - 2.0*k);
        term := term * core;
      end if;
    end for;
    term := 2.0 * u^(a+1.0);
    y := term * sum;
    last := last * term;
  end if;
annotation(preferredView = "text",
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>(y,last) = ThermalMatters.Utilities.<b>fd_asymp</b>(u,j,order);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the u&lt;0 and u&gt;&gt;1 expansions of the complete Fermi-Dirac integral fd_asymp(u,j,order) = 1/Gamma(j+3/2)*Integral_0_inf x^(j+1/2)/(exp(x-u)+1)*dx&nbsp; to \"order\" order. The output \"last\" is the contribution from the last term in the expansions.</p>

<p>j &gt;= -1&nbsp; and&nbsp; 0 &lt; order &lt; 21.</p><p>
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
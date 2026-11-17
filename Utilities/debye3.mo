within ThermalMatters.Utilities;
function debye3 "3rd-order Debye function debye3(u) = 3/u^3*Integral_0_u t^3/(exp(t)-1)*dt"
  extends Modelica.Icons.Function;
  input Real u "Input argument";
  output Real y "= 3/u^3*Integral_0_u t^3/(exp(t)-1)*dt";
  //
  // using numerical integration for now, intend switch to Chebyshev fit soon...
  //
  function integrand
    extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
  algorithm
    y := u*u*u / (exp(u) - 1.0);
  end integrand;
  //
protected
  Real z;
  Real u3;
  Real sum;
  constant Real eps = 2.e-3;
  constant Real eps3 = eps*eps*eps;
  constant Real uu = 17.0;
  constant Real uu3 = uu*uu*uu;
  constant Real rel_err = 1.e-10;
  constant Real Imax = 19.4818182068004875; // u^3 debye3(u) / 3 ~ pi^4 / 15  for u-->inf
algorithm
  if u < 0 then
    // domain error: return debye3(0) result
    y := 1.0;
    print("debye3 error: input u must be >= 0 ... using u=0");
  elseif u < eps then
    // small u expansion
    y := 1.0 - 3.0*u/8.0 + u*u/20.0;
  elseif u <= 0.5*uu then
    // forward Lobatto quadrature
    u3 := u*u*u;
    z := Modelica.Math.Nonlinear.quadratureLobatto(function integrand(), eps, u, rel_err);
    y := 3.0/u3 * (z + eps3/3.0 * (1.0 - 3.0*eps/8.0 + eps*eps/20.0));
  elseif u <= uu then
    // backward Lobatto quadrature
    u3 := u*u*u;
    z := Modelica.Math.Nonlinear.quadratureLobatto(function integrand(), u, uu, rel_err);
    sum := 6.0 + 6.0*uu + 3.0*uu*uu + uu3;
    y := 3.0/u3 * (-z + Imax/3.0 - sum*exp(-uu));
  else
    // debye3(u->inf) minus large-u-to-inf expansion
    u3 := u*u*u;
    sum := 6.0 + 6.0*u + 3.0*u*u + u3;
    y := ( Imax - 3.0*sum*exp(-u) ) / u3;
  end if;
  annotation(preferredView = "text", 
    Documentation(info = "<html><head></head><body><h4>Syntax</h4>
<blockquote><pre>y = ThermalMatters.Utilities.<b>debye3</b>(u);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the 3rd order Debye function debye3(u) = 3/u^3*Integral_0_u t^3/(exp(t)-1)*dt numerically with a relative precision of 1e-10. The implementation uses the Lobatto quadrature routine available in the MSL, bracketed by approximations via expansions for small and large arguments.</p>

<p>
For more details, see <a href=\"http://en.wikipedia.org/wiki/Debye_function\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>debye3(0)     // = 1
debye3(5.e-4) // = 0.999813
debye3(1)     // = 0.674416
debye3(100)   // = 1.94818e-5</pre></blockquote>

<h4>See also</h4><div><br></div>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>March 22, 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"),
  uses(Modelica(version = "4.1.0")));
end debye3;
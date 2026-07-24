within ;
package ThermalMatters

  // extends ThermalMatters.Icons.TMPackage;
  extends Modelica.Icons.Package;


  annotation (
    version="0.2.0",
    uses(Modelica(version = "4.1.0")),
    Documentation(info= "<html><head></head><body><p><span style=\"font-family: 'Ubuntu Sans';\">This package is meant as an extension of MSL's Thermal library, taking into account nonlinearities in materials' thermal properties.</span></p><p>This Modelica package is free software and the use is completely at your own risk; it can be redistributed and/or modified under the terms of the GNU General Public License (GPL). For license conditions visit https://www.gnu.org/copyleft/gpl.html.</p>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>March 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"),
  Icon(graphics = {Text(origin = {49, -19}, textColor = {230, 97, 0}, extent = {{-51, 49}, {51, -49}}, textString = "m", fontName = "Standard Symbols PS [URW ]"), Text(origin = {-31, 17}, textColor = {192, 28, 40}, extent = {{-53, 77}, {53, -77}}, textString = "Q", fontName = "Standard Symbols PS [URW ]"), Text(origin = {-66, -39}, textColor = {245, 194, 17}, extent = {{-16, 17}, {16, -17}}, textString = "a", fontName = "Standard Symbols PS [URW ]"), Text(origin = {-23, -54}, textColor = {38, 162, 105}, extent = {{-17, 20}, {17, -20}}, textString = "c"), Text(origin = {-10, -65}, textColor = {38, 162, 105}, extent = {{-8, 11}, {8, -11}}, textString = "p"), Text(origin = {62, 61}, textColor = {192, 97, 203}, extent = {{-14, 17}, {14, -17}}, textString = "k", fontName = "Standard Symbols PS [URW ]"), Text(origin = {8, 83}, textColor = {28, 113, 216}, extent = {{-14, 17}, {14, -17}}, textString = "T", fontName = "Ubuntu Mono"), Text(origin = {20, 72}, textColor = {28, 113, 216}, extent = {{-6, 14}, {6, -14}}, textString = "D")}),
  Diagram(graphics));
end ThermalMatters;
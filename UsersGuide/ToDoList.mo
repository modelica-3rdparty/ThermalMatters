within ThermalMatters.UsersGuide;
class ToDoList "To-Do List for the ThermalMatters Library"
  extends Modelica.Icons.Information;

 annotation (preferredView = "info", Documentation(info= "<html><head></head><body><p>Examples:&nbsp;<br>- CryoHose&nbsp;<br></p><p>Components:&nbsp;<br>- Kinetic-theory-based thermal conductors for intermediate-to-high T.&nbsp;<br>&nbsp; &nbsp; &nbsp;(Need way to choose Cond function in generic Component.)&nbsp;<br>- Create LUT-based versions of HeatCap's and ThermCond's&nbsp;<br>- Other geometries (e.g., oblate, hyperbolic, toroidal, two-center)? Elements of 2D?&nbsp;<br>- Thermal contact conductances&nbsp;</p><p>Functions:&nbsp;<br>- Further considerations for thermal conductivities? <br>&nbsp; &nbsp; &nbsp;(Low temperatures: e.g., for metals κ --&gt; 0 as T --&gt; 0; T<sub>e</sub> vs T<sub>i</sub>&nbsp;in experiments?) <br>- Finalize Frenkel EoS: f<sub>F</sub> is in general a function of T and P (parametrize viscosity and inf.-freq. shear mod.?) <br>- More general EoS's for non-isotropic materials <br>- Include optical-branch phonon contributions for non-elemental materials <br>- G<sub>c</sub> functions for convection component&nbsp;</p><p>Numerics / Utilities:&nbsp;<br>- Switch from numerical integration to Chebyshev fits for Debye3 function <br>- Implement Fermi-Dirac integrals F<sub>-1/2</sub> F<sub>1/2</sub> F<sub>3/2</sub> , starting from their asymptotic forms&nbsp;<br>- Double FD integrals for electronic transport functions&nbsp;</p><p>Data:&nbsp;<br>- Create more Records of physical parameters (T<sub>D</sub>&nbsp;,&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">α</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub>&nbsp;,&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">κ</span><sub style=\"font-family: 'Ubuntu Sans';\">0</sub>&nbsp;,&nbsp;<span style=\"font-family: 'Ubuntu Sans';\">ρ</span>&nbsp;, etc.) for different materials <br>- Import (or link to) relevant physical values for different materials (CRC? NIST? MatWeb? Or DFT ab-inito results: Abinit, Aflow?)&nbsp;<br></p>
</body></html>", revisions = "<html><head></head><body><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td>March 2026</td>
    <td>

<table border=\"0\">
<tbody><tr><td>
         Initial version implemented by T. Burch.<br></td></tr></tbody></table>
</td></tr>

</tbody></table>
</body></html>"));
end ToDoList;
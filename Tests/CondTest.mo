model CondTest
  import Modelica.Units.SI;
  SI.ThermalConductivity kappa,kap_wf;
  SI.Conductivity sigma, sig_wf;
  SI.EnergyDensity e0,e;
  SI.SpecificHeatCapacity cp0,cp;
  Modelica.Blocks.Sources.Ramp T_ramp(height = 499, duration = 499, offset = 1)  annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  ThermalMatters.Materials.Copper copper annotation(
    Placement(transformation(origin = {-20, 10}, extent = {{-10, -10}, {10, 10}})));
  ThermalMatters.Materials.Silver silver annotation(
    Placement(transformation(origin = {-20, -10}, extent = {{-10, -10}, {10, 10}})));
equation
  (e0,cp0) = ThermalMatters.Functions.debyeEoS(silver.T0,silver.T_D,silver.effAm,silver.Mdens);
  (e,cp) = ThermalMatters.Functions.debyeEoS(T_ramp.y,silver.T_D,silver.effAm,silver.Mdens);
  (kap_wf,sig_wf) = ThermalMatters.Functions.wfCond(T_ramp.y,silver.kappa0,silver.T0);
  (kappa,sigma) = ThermalMatters.Functions.ktCond(T_ramp.y,silver.kappa0,silver.T0,cp/cp0);
annotation(
    uses(Modelica(version = "4.1.0")),
    Diagram(coordinateSystem(extent = {{-40, 20}, {40, -20}})),
    version = "",
  experiment(StartTime = 0, StopTime = 499, Tolerance = 1e-06, Interval = 1));
end CondTest;

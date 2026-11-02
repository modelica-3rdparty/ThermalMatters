model FD_test
  parameter Integer order = 3;
  Modelica.Blocks.Sources.Ramp uramp(height = 20, duration = 1, offset = -10)  annotation(
    Placement(transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interaction.Show.RealValue Fmhalf annotation(
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interaction.Show.RealValue Fhalf annotation(
    Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interaction.Show.RealValue F3half annotation(
    Placement(transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression Fmhalf_src(y = ThermalMatters.Utilities.fd_asymp(uramp.y, -1, order))  annotation(
    Placement(transformation(origin = {-30, 30}, extent = {{-30, -10}, {30, 10}})));
  Modelica.Blocks.Sources.RealExpression Fhalf_src(y = ThermalMatters.Utilities.fd_asymp(uramp.y, 0, order)) annotation(
    Placement(transformation(origin = {-30, 10}, extent = {{-30, -10}, {30, 10}})));
  Modelica.Blocks.Sources.RealExpression F3half_src(y = ThermalMatters.Utilities.fd_asymp(uramp.y, 1, order)) annotation(
    Placement(transformation(origin = {-30, -10}, extent = {{-30, -10}, {30, 10}})));
equation
  connect(Fmhalf_src.y, Fmhalf.numberPort) annotation(
    Line(points = {{4, 30}, {18, 30}}, color = {0, 0, 127}));
  connect(Fhalf_src.y, Fhalf.numberPort) annotation(
    Line(points = {{4, 10}, {18, 10}}, color = {0, 0, 127}));
  connect(F3half_src.y, F3half.numberPort) annotation(
    Line(points = {{4, -10}, {18, -10}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "4.1.0")),
  Diagram(coordinateSystem(extent = {{-100, 40}, {40, -20}})),
  version = "",
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001));
end FD_test;
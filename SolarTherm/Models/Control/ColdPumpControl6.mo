within SolarTherm.Models.Control;
model ColdPumpControl6
  extends Icons.Control;
  parameter SI.Temperature T_ref=from_degC(570) "Setpoint of temperature";
  parameter SI.MassFlowRate m_flow_max=1400 "Maximum mass flow rate";
  parameter SI.MassFlowRate m_flow_min=0 "Mass flow rate when control off";
  parameter Real L_off=10 "Level of stop discharge";
  parameter Real y_start=300 "Initial value of output";
  parameter SI.Time delay=from_hour(0.25) "Start-up delay time";

  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{54,-6},{66,6}})));
  Modelica.Blocks.Sources.RealExpression m_flow_off_input(y=m_flow_min)
    annotation (Placement(transformation(extent={{6,-34},{32,-10}})));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{-28,38},
            {-8,18}})));
  PID_AW_reset3               PI(                                                                                           Ti = 1, Kp = -10,           Tt = 1,
    uMax=m_flow_max,
    uMin=m_flow_min,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=y_start)                                                                                                 annotation(Placement(transformation(extent={{14,18},
            {34,38}})));
  Modelica.Blocks.Sources.RealExpression T_ref_input(y=T_ref)
    annotation (Placement(transformation(extent={{-62,18},{-42,38}})));
  Modelica.Blocks.Interfaces.RealInput L_mea
    annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow
    annotation (Placement(transformation(extent={{94,-18},{130,18}})));
  Modelica.Blocks.Interfaces.BooleanInput sf_on
    annotation (Placement(transformation(extent={{-130,-80},{-90,-40}})));
  Modelica.Blocks.Interfaces.RealInput T_mea
    annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{76,-10},{90,4}})));
  Level2Logic hotTankLogic(level_max=30, level_min=L_off)
    annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-44,-20},{-24,0}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay(delayTime=delay)
    annotation (Placement(transformation(extent={{-14,-12},{-6,-4}})));
equation
  connect(m_flow_off_input.y, switch.u3) annotation (Line(points={{33.3,-22},{44,
          -22},{44,-4.8},{52.8,-4.8}}, color={0,0,127}));
  connect(PI.u,feedback. y) annotation(Line(points={{12,28},{12,28},{-9,28}},              color = {0, 0, 127}));
  connect(T_ref_input.y, feedback.u1)
    annotation (Line(points={{-41,28},{-28,28},{-26,28}}, color={0,0,127}));
  connect(PI.y, switch.u1) annotation (Line(points={{35,28},{46,28},{46,16},{46,
          4.8},{52.8,4.8}},         color={0,0,127}));
  connect(T_mea, feedback.u2)
    annotation (Line(points={{-110,60},{-18,60},{-18,36}}, color={0,0,127}));
  connect(PI.reset, switch.u2) annotation (Line(points={{12,20},{0,20},{0,0},{52.8,
          0}}, color={255,0,255}));
  connect(switch.y, max.u1) annotation (Line(points={{66.6,0},{70,0},{70,1.2},{
          74.6,1.2}}, color={0,0,127}));
  connect(max.y, m_flow) annotation (Line(points={{90.7,-3},{94.35,-3},{94.35,0},
          {112,0}}, color={0,0,127}));
  connect(max.u2, switch.u3) annotation (Line(points={{74.6,-7.2},{74.6,-22},{
          44,-22},{44,-4.8},{52.8,-4.8}}, color={0,0,127}));
  connect(L_mea, hotTankLogic.level_ref)
    annotation (Line(points={{-108,0},{-74,0},{-74,0}},   color={0,0,127}));
  connect(hotTankLogic.y, and1.u1) annotation (Line(points={{-53.2,0},{-50,0},{-50,
          -10},{-46,-10}},     color={255,0,255}));
  connect(and1.u2, sf_on) annotation (Line(points={{-46,-18},{-64,-18},{-64,-60},
          {-110,-60}}, color={255,0,255}));
  connect(and1.y, onDelay.u) annotation (Line(points={{-23,-10},{-20,-10},{-20,-8},
          {-15.6,-8}}, color={255,0,255}));
  connect(onDelay.y, switch.u2) annotation (Line(points={{-5.2,-8},{-2,-8},{-2,0},
          {52.8,0}}, color={255,0,255}));
end ColdPumpControl6;

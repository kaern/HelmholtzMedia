within HelmholtzMedia.Examples.Sweep;
model State_pT_sweep
  package Medium = HelmholtzFluids.Butane;
  Medium.AbsolutePressure p;
  Medium.Temperature T;
  Medium.ThermodynamicState inletState;
  Medium.Density d_in;
  Medium.SpecificEnthalpy h_in;
  Medium.DynamicViscosity eta;
  Medium.ThermalConductivity lambda;
  Medium.PrandtlNumber Pr;

protected
  constant Medium.Temperature Tmin=Medium.fluidLimits.TMIN;
  constant Medium.Temperature Tcrit=Medium.fluidConstants[1].criticalTemperature;
  constant Medium.Temperature Tmax=Medium.fluidLimits.TMAX;
  constant Medium.AbsolutePressure pmin=Medium.fluidLimits.PMIN;
  constant Medium.AbsolutePressure pcrit=Medium.fluidConstants[1].criticalPressure;
  constant Medium.AbsolutePressure pmax=Medium.fluidLimits.PMAX;

Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    offset=0,
    startTime=0.001,
    duration=9.5)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
Modelica.Blocks.Sources.ExpSine expSine(
    amplitude=0.99,
    damping=0.5,
    freqHz=2,
    offset=0,
    startTime=3)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
Modelica.Blocks.Sources.Sine sine(
    amplitude=0.999,
    freqHz=1,
    startTime=2,
    phase=0)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

equation
  p = 0.7*pcrit + (0.7*pcrit)*(sine.y);
  T = 0.7*Tcrit + (0.7*Tcrit-Tmin)*(expSine.y);

  inletState=Medium.setState_pTX(p=p, T=T, phase=0, X={1});
  d_in=inletState.d;
  h_in=inletState.h;
  eta=Medium.dynamicViscosity(inletState);
  lambda=Medium.thermalConductivity(inletState);
  Pr=Medium.prandtlNumber(inletState);

  annotation (experiment(StopTime=10, NumberOfIntervals=1000),
      __Dymola_experimentSetupOutput);
end State_pT_sweep;
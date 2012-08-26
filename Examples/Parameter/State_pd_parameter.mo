within HelmholtzMedia.Examples.Parameter;
model State_pd_parameter "calculate state record from pd input"

  package Medium = HelmholtzFluids.Butane;

  parameter Medium.AbsolutePressure p=2e2;
  parameter Medium.Density d=1;

  Medium.ThermodynamicState inletState;

equation
  inletState=Medium.setState_pd(p=p, d=d, phase=0);
end State_pd_parameter;
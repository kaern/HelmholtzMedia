within HelmholtzMedia.Examples.Parameter;
model State_pT_parameter_Transport "calculate state record from pT input"

  package Medium = HelmholtzFluids.Propane;

  parameter Medium.AbsolutePressure p=101325;
  parameter Medium.Temperature T=298.15;
  Medium.ThermodynamicState state;

  // pT always results in single phase states
  // order of properties as in RefProp

  // derived properties
  Medium.SpecificHeatCapacity cv;
  Medium.SpecificHeatCapacity cp;
  Medium.VelocityOfSound a;
  Medium.Types.DerTemperatureByPressure mu;

  // transport proerties
  Medium.ThermalConductivity lambda;
  Medium.DynamicViscosity eta;
  Medium.PrandtlNumber Pr;

  // more derived properties
  Modelica.SIunits.IsothermalCompressibility kappa;
  Medium.IsobaricExpansionCoefficient beta;
  Medium.DerEnthalpyByPressure delta_T;

equation
  state=Medium.setState_pTX(p=p, T=T, phase=0, X={1});

  // derived properties
  cv=Medium.specificHeatCapacityCv(state);
  cp=Medium.specificHeatCapacityCp(state);
  a=Medium.velocityOfSound(state);
  mu=Medium.jouleThomsonCoefficient(state);
  beta=Medium.isobaricExpansionCoefficient(state);
  kappa=Medium.isothermalCompressibility(state);
  delta_T=Medium.isothermalThrottlingCoefficient(state);

  // transport properties
  lambda=Medium.thermalConductivity(state);
  eta=Medium.dynamicViscosity(state);
  Pr=Medium.prandtlNumber(state);

end State_pT_parameter_Transport;

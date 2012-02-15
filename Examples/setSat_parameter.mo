within HelmholtzFluids.Examples;
model setSat_parameter
  package medium = HelmholtzFluids.R134a;

  medium.SaturationProperties satProps;

  parameter medium.Temperature Tsat=273.15;
  parameter medium.AbsolutePressure psat=101325;

equation
  satProps = medium.setSat_T(T=Tsat);
//satProps = medium.setSat_p(p=psat);

  annotation (experiment(Tolerance=1e-012), __Dymola_experimentSetupOutput);
end setSat_parameter;
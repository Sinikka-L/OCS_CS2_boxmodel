function y = difcoef(T)
%DIFCOEF calculates the diffusion coefficient of COS
%in seawater according to Wilke and Chang (1955).
%The formula is empirical!
%input is water temperature in K.
%units: m2 s-1

MB = 18;	%MB is the molar weight of water in g mol-1
VA = 55.2;	%VB is the molar volume of COS in cm3 mol-1 at its boiling point
%Following two lines are to calculate dynamic viscosity of seawater
mu20 = 1.002e-3;
lomu0T = log10(mu20) + (1.1709*(293-T)-1.827e-3*(293-T).^2)./(T-183.07);

%Following the main equation
%The factor 0.95 takes account of the 5% decrease of D in saltwater
y =0.95*7.4e-15*sqrt(2.6*MB)*T./(VA^0.6*10.^lomu0T);

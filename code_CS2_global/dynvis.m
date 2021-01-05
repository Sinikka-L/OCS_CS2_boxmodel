function y = dynvis(S,T)
%DYNVIS calculates dynamic viscosity.
%Inputs are salinity and absolute temperature.
%units: kg m-1 s-1

A = 1.0675e-4 + 5.185e-5*(T-273);
B = 2.591e-3 + 3.3e-5*(T-273);
mu20 = 1.002e-3;
lomu0T = log10(mu20) + (1.1709*(293-T)-1.827e-3*(293-T).^2)./(T-183.07);
y = 10.^lomu0T.*(1+A.*volchlor(S,T).^2+B.*volchlor(S,T));

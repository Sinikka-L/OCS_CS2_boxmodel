function y = density(S,T)
%DENSITY calculates the density of water.
%Inputs are salinity and temperature.
%units: kg m-3

T = T-273;
r1 = 999.8426+0.067940*T-0.0090953*T.^2+1.0017e-4*T.^3-1.1201e-6*T.^4+6.5363e-9*T.^5;
r2 = S.*(0.82449-0.0040899*T+7.6438e-5*T.^2-8.2467e-7*T.^3+5.3875e-9*T.^4);
r3 = S.^1.5.*(-5.72466e-3+1.0227e-4*T-1.6546e-6*T.^2);
r4 = S.^2*4.8314e-4;
y = r1+r2+r3+r4;

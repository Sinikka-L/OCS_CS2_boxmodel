function y = kinvis(S,T)
%KINVIS calculates kinematic viscosity.
%Inputs are salinity and absolute temperature.
%units: m2 s-1

y = dynvis(S,T)./density(S,T);


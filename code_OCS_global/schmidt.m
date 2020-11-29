function y = schmidt (S,T)
%SCHMIDT calculates the schmidt number for COS in seawater
%which is the ratio of kinematic viscosity of seawater
%over the diffusion coefficient of the gas.
%Inputs are the salinity and temperature in K
%units: none

y = kinvis(S,T)./difcoef(T);

function y = volchlor(S,T)
%VOLCHLOR calculates the volume chlorinity.
%Inputs are salinity and temperature.
%units: none

y = S.*density(S,T)/1806.55;

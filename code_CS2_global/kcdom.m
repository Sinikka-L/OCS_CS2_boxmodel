function y = kcdom(acdom,zenith)
%KCDOM calculates the diffuse ext. coefficient
%of disolved organic matter.
%Input is measured absorbance of CDOM and solar zenith angle.
%units: m-1

y = acdom./richtcos(zenith);



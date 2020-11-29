function y = kdiffuse(cextinct,zenith)
%KCDOM calculates the total diffuse ext. coefficient
%of seawater.
%Input is total absorbance of seawater and solar zenith angle.
%units: m-1

y = cextinct./richtcos(zenith);



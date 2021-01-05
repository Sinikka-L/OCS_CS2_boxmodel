function y = richtcos(x)
% RICHTCOS calculates the direction cosine
% which takes account of the path of the light 
% in the water. Input is solar zenith angle.
%units: none

z = fd(x)./cos(asin(sin(x*pi/180)/1.3392)) + (1-fd(x))/0.859;
y = 1./z;


function y = adiffuse(x)
%ADIFFUSE calculates albedo for diffuse incident light
%input is windspeed
%units: none

i = find(x > 20);
x(i) = 20*ones(size(i));
y = 0.05+0.018.*(1-x/20).^1.5;



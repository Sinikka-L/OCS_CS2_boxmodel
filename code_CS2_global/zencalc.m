function y = zencalc(lat,long,juday)
%zencalc calculates the solar zenith angle.
%Input are latitude, longitude and (fractional!) julian day 
%units: degrees


N3 = (0.39637-22.9133*cos(6.283*juday/365)+4.02543*sin(6.283*juday/365)-0.3872*cos(12.566*juday/365)+0.052*sin(12.566*juday/365))/57.2958;
O3 = lat/57.2958;
Q3 = ((juday-fix(juday)-0.5)*86400 + long*240)/13751; 

y = 57.2958 * acos(sin(O3).*sin(N3)+cos(O3).*cos(N3).*cos(Q3));

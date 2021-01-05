function y = uvcalc(irrad,zenith)
%uvcalc calculates the UV irradiation between 295 and 330 nm from total solar
%insolation according to Behr (1992).
%Input are solar irradiation and solar zenith angle
%units: m s-1

y = cos(zenith*pi/180).^2;
y = 0.000285*irrad.*y;
i = find(zenith<20);
y(i)=0.00025*irrad(i);


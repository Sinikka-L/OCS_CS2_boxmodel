% calcdarkproduction

% according to von Hobe 2003
%DP=1.71*10^21*ACDOM350(tstep)*exp(-16.2/T(tstep))./1000; % nmol/dm³*s

% now Lennartz et al. 2020 DP
DP=10^-6*ACDOM350(:,:,tstep).*exp(57.2-16692./(T(:,:,tstep)+273.15)); %nmol/m³/s




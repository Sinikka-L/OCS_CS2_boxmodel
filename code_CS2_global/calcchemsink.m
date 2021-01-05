% calculates (known) chemical sink


kh=9.26*10^-7; % corresponds to 12.5 days, mean kettle
%kh=1.0919*10^-6; % corresponds to Min AQ in Kettle PhD  p. 193, 10.6 days
%kh=1.3197*19^-6; %corresponds to Max const., fastest sink, 8.77 days
%kh= 9.8*10^-7; % first order rate constant (1/s), corresponds to mean sink
HY=cw(:,:,tstep-1).*kh; % nmol/L/s

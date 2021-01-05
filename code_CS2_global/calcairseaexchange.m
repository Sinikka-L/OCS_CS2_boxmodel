% calculates air-sea gas exchange in nmol/m²/s

%Henry constant
kh=H0.*exp(tempdep.*(1./(T(:,:,tstep)+273.15)-1./298.15)); % Henry constant acc. to temperature m/L/atm
%H=(T(tstep)+273.15)*kh./12.2;                 % Henry constant in water over gas, dimless

% Schmidt number
% T in °C, acc. to Wilke & Chang, 1955 -> Marc, airsea EMAC
schmidtsea=schmidt(S(:,:,tstep), T(:,:,tstep)+273.15);


% transfer velocity
switch parameterkw                      % wind dependant transfer velocity water side
    case 1  % Wanninkhof 1992
        kw=0.31*wind10(:,:,tstep).*(schmidtsea./660).^(-0.5);
    case 2  % Nightingale 2000
        kw=(0.22*wind10(:,:,tstep).^2+0.333*wind10(:,:,tstep)).*(schmidtsea./600).^(-0.5);
    case 3  % Ho 2006
        kw=0.266*wind10(:,:,tstep).^2.*(schmidtsea./600).^(-0.5);
end

% eq-concentration
eqairatm=PRESS(:,:,tstep)./1013.25.*cair(:,:,tstep).*10^-12; % eqairatm für mol (nicht pico oder nano)
eqconc=eqairatm.*kh.*10^9; % in nanomol
% air-sea exchange in nmol/s/m²
%EX=(kw*(cw(tstep-1)-(cair(tstep).*10^-3).*H))./3600*10; % air sea gas exchange, cw=nmol/L, cair=10^-12
EX=(kw.*(cw(:,:,tstep-1)-eqconc))./3600*10;




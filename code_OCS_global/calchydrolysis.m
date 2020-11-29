% calculates hydrolysis

% according to von Hobe et al, 2003: Modeling of OCS in the ocean
switch hydrolysemethod
    case 1 % from Elliott et al., 1989
        Kw=10.^-(3046.7./(T(:,:,tstep)+273.15)+3.7685+0.0035486.*sqrt(S(:,:,tstep)));
        aH=10.^-pH(:,:,tstep);
        kh=exp(24.3-10450./(T(:,:,tstep)+273.15))+exp(22.8-6040./(T(:,:,tstep)+273.15)).*Kw./aH; % first order rate constant (1/s)
    case 2 % updated from Radford-Knoery/Cutter, 1994
        h1=exp(10.7-6468./(T(:,:,tstep)+273.15));
        h2=exp(15.7-4428./(T(:,:,tstep)+273.15));
        kh=h1+h2.*10.^(pH(:,:,tstep)-13.2); % 13.2=ionic product seawater culberson 1993
end
HY=cw(:,:,tstep-1).*kh; % nmol/L/s
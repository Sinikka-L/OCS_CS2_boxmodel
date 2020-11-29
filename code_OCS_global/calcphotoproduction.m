% calculates photoproduction

switch photomethod
    case 1 % wavelength resolved - not available in 2D
    case 2 % wavelength integrated nach Hobe 2001 - one constant photoprod rate for whole ocean, no decreasing light field
        % not recommended (mixed layer dynamics missing)
        UVints=2.85*10^-4.*I0(tstep).*(cos(zenith(tstep))).^2; % W/m² = J/m²/s
        UVint=uvuw0(UVints, zenith(tstep), wind10(tstep)); % W/m² = J/m²/s
        PP=pint.*ACDOM(tstep,3).*UVint.*10^9/1000;
    case 6 % including integration over mixed layer, intersected fit
        P_z=zeros(64,128,500);
        for i=1:64
            for j=1:128
               if isnan(ACDOM350(i,j,tstep))||isnan(Dmix(i,j,tstep))||isnan(I0(i,j,tstep))||isnan(zenith(i,j,tstep))||isnan(wind10(i,j,tstep))
               else
                  nboxes=floor(Dmix(i,j,tstep)); % number of 1m boxes in water column in mixed layer
                  vb=1:1:nboxes;
                  vb=vb-0.5;
                  vb(vb<0)=0;
                  UVints=2.85*10^-4.*I0(i,j,tstep).*(cos(zenith(i,j,tstep))).^2; % UV at sea surface, see von Hobe 2003 for details
                  UVint=uvuw0(UVints,zenith(i,j,tstep), wind10(i,j,tstep)); % UV under sea surface (taking reflections into account)
                  Kd=(ACDOM350(i,j,tstep)+0.0530)./richtcos(zenith(i,j,tstep));
                  UVz=UVint*exp(-Kd*vb);
                  psmall=3591.3*ACDOM350(i,j,tstep)+329.4; % empirically fitted relationship of psmall and CDOM, see Lennartz et al 2017 for details
                  P_z(i,j,1:nboxes)=psmall.*10^-12*10^9*UVz.*ACDOM350(i,j,tstep);
                end
            end
       end
       PP=nansum(P_z,3)./squeeze(Dmix(:,:,tstep))./1000; % calculate mean mixed layer production

end

% calculates photoproduction

 P_z=zeros(64,128,500);
     for i=1:64
         for j=1:128
            if isnan(ACDOM350(i,j,tstep))||isnan(Dmix(i,j,tstep))||isnan(I0(i,j,tstep))||isnan(zenith(i,j,tstep))||isnan(wind10(i,j,tstep))
            else
               nboxes=floor(Dmix(i,j,tstep)); % number of 1 m boxes
               vb=1:1:nboxes;
               vb=vb-0.5; % set value to middle of depth grid
               vb(vb<0)=0;
               UVints=2.85*10^-4.*I0(i,j,tstep).*(cos(zenith(i,j,tstep))).^2; %UV at surface
               UVint=uvuw0(UVints,zenith(i,j,tstep), wind10(i,j,tstep)); %UV below sea surface
               Kd=(ACDOM350(i,j,tstep)+0.0530)./richtcos(zenith(i,j,tstep)); % light attenuation
               UVz=UVint*exp(-Kd*vb); % light at each depth in grid
               psmall=3591.3*ACDOM350(i,j,tstep)+329.4; % photoproduction rate constant
               P_z(i,j,1:nboxes)=psmall.*10^-12*10^9*UVz.*ACDOM350(i,j,tstep);
             end
         end
    end
PP=nansum(P_z,3)./squeeze(Dmix(:,:,tstep))./1000;


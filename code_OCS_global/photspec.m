function y = photspec(D1,D2, acdomSP, adiffSP, UVSP, zenith, uwind)
%PHOTSPEC calculates the five photochemical production terms resolved
%for five different wavelength.
%This has to be multiplied with the photoproduction constant.
%Inputs are D1 and D2, CDOM absorption (Spectrally resolved), 
%overall absorption (Sp. res.), UV intensity at surface (Sp. res.),
%solar zenith angle and wind speed.

for i=1:5
y(i,:) = 1./(D2-D1).*acdomSP(i,:)./adiffSP(i,:).*UVSP(i,:).*(exp(-kdiffuse(adiffSP(i,:), zenith).*D1)-exp(-kdiffuse(adiffSP(i,:), zenith).*D2));
end

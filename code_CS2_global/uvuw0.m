function y = UVUW0 (UV, zenith, uwind)
%UVUW0 calculates the UVlight intensity
%just below the water surface.
%Input is UV at surface, solar zenith 
%angle and wind speed at 10m height.
%units: same as UV

y = fd(zenith).*UV.*(1.03-afreshn(zenith,uwind)) + (1-fd(zenith)).*UV.*(1.03-adiffuse(uwind));


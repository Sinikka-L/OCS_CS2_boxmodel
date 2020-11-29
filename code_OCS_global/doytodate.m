function datestring=doytodate(doy,year)
% function datestring=doytodate(doy,year)
% year optional
%
% H. Bittig, IFM-GEOMAR
% 19.07.2011

if nargin<2
    year=datestr(now,'yyyy');
else
    year=num2str(year);
end

%datestring=datestr(datenum(year,'yyyy')+doy-1,'dd-mm-yyyy');
datestring=datestr(datenum(year,'yyyy')+doy-1,0);
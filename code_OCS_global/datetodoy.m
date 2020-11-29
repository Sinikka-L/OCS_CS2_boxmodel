function doy=datetodoy(datestring,dateformat)
% function doy=datetodoy(datestring,dateformat)
% dateformat optional
% default dateformat: 'dd-mm-yyyy'
%
% H. Bittig, IFM-GEOMAR
% 19.07.2011

if nargin<2
    dateformat='dd.mm.yyyy';
end

warning off
d=datevec(datestring,dateformat);
warning on
doy=datenum(d)-datenum(num2str(d(:,1)),'yyyy')+1;
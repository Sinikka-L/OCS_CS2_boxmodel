% loadin

% load climatological data
cairT42=ncread('./data/cair_T42.nc','cair');
cairT42(cairT42>10000)=NaN;

latT42=ncread('./data/latlon_T42.nc','lat');
latT42(latT42>91)=NaN;

lonT42=ncread('./data/latlon_T42.nc','lon');
lonT42(lonT42>361)=NaN;

mldT42=ncread('./data/MLD_T42.nc','MLD');
mldT42(mldT42>10000)=NaN;

pHT42=ncread('./data/pH_T42.nc','pH');
pHT42(pHT42>15)=NaN;

salT42=ncread('./data/sal_T42.nc','sal');
salT42(salT42>100)=NaN;

% data for specific month
rootdir=['./data/' sprintf('%i',year)];

ACDOM350T42=ncread([rootdir '/CDOM_a350_' sprintf('%i',year) '.nc'],'CDOM_a350');
ACDOM350T42(ACDOM350T42>20)=NaN;

pressT42=ncread([rootdir '/ps_' sprintf('%i',year) '_monthlymeandiurnalT42.nc'],'sp');
pressT42(pressT42>100000)=NaN;

sstT42=ncread([rootdir '/skin_' sprintf('%i',year) '_monthlymeandiurnalT42.nc'],'skt');
sstT42(sstT42>100)=NaN;

windT42=ncread([rootdir '/wind_' sprintf('%i',year) '_monthlymeandiurnalT42.nc'],'wind');
windT42(windT42>1000)=NaN;

ssrdT42=ncread([rootdir '/ssrd_' sprintf('%i',year) '_monthlymeandiurnalT42.nc'],'ssrd');
ssrdT42(ssrdT42>10000)=NaN;





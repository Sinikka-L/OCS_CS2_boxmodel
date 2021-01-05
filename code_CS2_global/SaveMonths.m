% Save in month loop

filename2be=['CS2_2D_diurnal' sprintf('%i',year) '.nc'];

if isfile(filename2be)
      delete(filename2be)
end

months=1:1:12;
timeofday=0:2:23;

% create file and files
% monthly mean fields
nccreate(filename2be,'cwcs2', 'Dimensions',{'lat',64, 'lon', 128,'month',length(months)}); % water concentration of ocs
nccreate(filename2be,'EX', 'Dimensions',{'lat',64, 'lon', 128,'month',length(months)}); % exchange air-sea
nccreate(filename2be,'CS', 'Dimensions',{'lat',64, 'lon', 128,'month',length(months)}); % chemical sink
%nccreate(filename2be,'DP', 'Dimensions',{'lat',64, 'lon', 128,'month',length(months)}); % dark production
nccreate(filename2be,'PP', 'Dimensions',{'lat',64, 'lon', 128,'month',length(months)}); % photoproduction

% mean monthly diurnal cycle (the one of the 14.th of each month)
nccreate(filename2be,'cwday', 'Dimensions',{'lat',64, 'lon', 128,'timeofday',length(timeofday),'month',length(months)}); % water concentration of ocs
nccreate(filename2be,'exday', 'Dimensions',{'lat',64, 'lon', 128,'timeofday',length(timeofday),'month',length(months)}); % exchange air-sea
nccreate(filename2be,'csday', 'Dimensions',{'lat',64, 'lon', 128,'timeofday',length(timeofday),'month',length(months)}); % hydrolysis
nccreate(filename2be,'ppday', 'Dimensions',{'lat',64, 'lon', 128,'timeofday',length(timeofday),'month',length(months)}); % photoproduction

% additional variables
nccreate(filename2be,'lat', 'Dimensions',{'lat',64, 'lon',128})
nccreate(filename2be,'lon', 'Dimensions',{'lat',64,'lon',128})
nccreate(filename2be,'month', 'Dimensions',{'month',length(months)})
nccreate(filename2be,'timeofday', 'Dimensions',{'time',length(timeofday)})

%%% write variables to file
ncwrite(filename2be, 'cwcs2', cwocs)
ncwriteatt(filename2be,'cwcs2','unit','nmol L-1');
ncwrite(filename2be, 'cwday', cwday)
ncwriteatt(filename2be,'cwday','unit','nmol L-1');


ncwrite(filename2be, 'EX', EXtotmonth)
ncwriteatt(filename2be,'EX','unit','nmol s-1 m-2');
ncwrite(filename2be, 'exday', exday)
ncwriteatt(filename2be,'exday','unit','nmol s-1 m-2');

ncwrite(filename2be, 'CS', HYtotmonth)
ncwriteatt(filename2be,'CS','unit','nmol s-1 L-1');
ncwrite(filename2be, 'csday', hyday)
ncwriteatt(filename2be,'csday','unit','nmol s-1 L-1');

ncwrite(filename2be, 'PP', PPtotmonth)
ncwriteatt(filename2be,'PP','unit','nmol s-1 L-1');
ncwrite(filename2be, 'ppday', ppday)
ncwriteatt(filename2be,'ppday','unit','nmol s-1 L-1');


ncwrite(filename2be, 'lat', squeeze(LAT(:,:,1)))

ncwrite(filename2be, 'lon', squeeze(LON(:,:,1)))

ncwrite(filename2be, 'timeofday', timeofday)
ncwriteatt(filename2be,'timeofday','unit','hour of day');

ncwrite(filename2be, 'month', months)
ncwriteatt(filename2be,'month','unit','month of year');

ncwriteatt(filename2be,'/','time created',datestr(now));
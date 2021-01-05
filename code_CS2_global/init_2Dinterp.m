% Initializes for 2D run (ocean surface, T42 grid 64x128)
sizeextinput=size(sstT42);
nlat=sizeextinput(1);
nlon=sizeextinput(2);

%%%% 1. repeat matrices to tgridlength for those variables that are constant
cair=repmat(cairT42, [1 1 len]);
clear cairT42

%%%% 2. interpolate on a monthly basis for those variables that have monthly forcing
tgridforcing=[year,1,1,0,0,0;year,2,15,0,0,0;year,3,15,0,0,0;year, 4, 15, 0,0,0; year, 5, 15, 0,0,0;...
    year,6,15,0,0,0;year,7,15,0,0,0;year,8,15,0,0,0;year,9,15,0,0,0;year,10,15,0,0,0;year,11,15,0,0,0;year,12,31,23,59,59];
tgridforcing=datenum(tgridforcing);

% CDOM
ACDOM350=zeros(nlat,nlon,length(tgrid));
for i=1:64
    for k=1:128
    dats=squeeze(ACDOM350T42(i,k,:));
    Vq=interp1(tgridforcing, dats, tgrid');
    ACDOM350(i,k,:)=Vq;
    end
end
clear acdom350T42

% pH
pH=zeros(nlat,nlon,length(tgrid));
for i=1:64
    for k=1:128
    dats=squeeze(pHT42(i,k,:));
    Vq=interp1(tgridforcing, dats, tgrid');
    pH(i,k,:)=Vq;
    end
end
clear pHT42

% MLD
Dmix=zeros(nlat,nlon,length(tgrid));
for i=1:64
    for k=1:128
    dats=squeeze(mldT42(i,k,:));
    Vq=interp1(tgridforcing, dats, tgrid');
    Dmix(i,k,:)=Vq;
    end
end
Dmix(isnan(Dmix))=10;
clear mldT42


% salinity
S=zeros(nlat,nlon,length(tgrid));
for i=1:64
    for k=1:128
    dats=squeeze(salT42(i,k,:));
    Vq=interp1(tgridforcing, dats, tgrid');
    S(i,k,:)=Vq;
    end
end
clear salT42

%%%%%%%% 3. interpolate seperately for each time of the day
tgriddays=tstart:1:tend; % to interpolate each timeofday seperately and then concatenae to one dimension

% SST
T1=zeros(64,128,12,length(tgriddays));
tic
for i=1:64
    for k=1:128
        for t=1:12
            dats=squeeze(sstT42(i,k,t,:));
            Vq=interp1(tgridforcing, dats, tgriddays');
            T1(i,k,t,:)=Vq;
        end
    end
end
T=zeros(64,128,length(tgrid));
for i=1:12
    T(:,:,i:12:end)=squeeze(T1(:,:,i,:));
end
clear T1 sstT42


% wind
wind1=zeros(64,128,12,length(tgriddays));
tic
for i=1:64
    for k=1:128
        for t=1:12
            dats=squeeze(windT42(i,k,t,:));
            Vq=interp1(tgridforcing, dats, tgriddays');
            wind1(i,k,t,:)=Vq;
        end
    end
end
wind10=zeros(64,128,length(tgrid));
for i=1:12
    wind10(:,:,i:12:end)=squeeze(wind1(:,:,i,:));
end
clear wind1 windT42

% pressure
press1=zeros(64,128,12,length(tgriddays));
tic
for i=1:64
    for k=1:128
        for t=1:12
            dats=squeeze(pressT42(i,k,t,:));
            Vq=interp1(tgridforcing, dats, tgriddays');
            press1(i,k,t,:)=Vq;
        end
    end
end
PRESS=zeros(64,128,length(tgrid));
for i=1:12
    PRESS(:,:,i:12:end)=squeeze(press1(:,:,i,:));
end
clear press1 pressT42

% ssrd
ssrd1=zeros(64,128,12,length(tgriddays));
tic
for i=1:64
    for k=1:128
        for t=1:12
            dats=squeeze(ssrdT42(i,k,t,:));
            Vq=interp1(tgridforcing, dats, tgriddays');
            ssrd1(i,k,t,:)=Vq;
        end
    end
end
I0=zeros(64,128,length(tgrid));
for i=1:12
    I0(:,:,i:12:end)=squeeze(ssrd1(:,:,i,:));
end
clear ssrd1 ssrdT42


%%%%%% 4. calculate julian day (day of year) and zenith
LAT=repmat(latT42, [1 1 len]);

LON=repmat(lonT42, [1 1 len]);

JU=datetodoy(tgrid);
JU=repmat(JU, [1 64 128]);
JU=permute(JU, [2 3 1]);

zenith=zencalc(LAT, LON, JU);

clear latT42 lonT42


%%%%%%% Initial conditions
if month==initmonth && year==inityear
    cw=zeros(64,128,len);
    cw(:,:,1)=0.008;
    disp(['Initial condition ' sprintf('%2.1f',cw(1,1,1)*1000) 'pmol L-1'])
else 
    cw(:,:,1)=cw(:,:,end);
end


%%%%%%% storing vectors
PPtot=zeros(64,128,len);
DPtot=zeros(64,128,len);
HYtot=zeros(64,128,len);
EXtot=zeros(64,128,len);
%UVinttot=zeros(64,128,len);



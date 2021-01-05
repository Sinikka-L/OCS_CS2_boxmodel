% MAIN PROGRAMM CS2 BOX MODEL
clear all
clc
close all

% 0. Extracting parameters
r=0.1; % scaling factor for photochemical production rate

% initializing data
inityear=1999;
initmonth=1;

for year=1999:2019

disp(year)
for month=1:12

% 1. Preparation
% 1.1. Preparation of temporal grid
dt=120;                   % time step in minutes
tstart=datenum([year, month, 1, 0, 0, 0]);    %  
tend=datenum([year, month, 28, 23, 59, 59]);  %
tgrid=tstart:dt*1/(24*60):tend;                % 

len=length(tgrid);                          % length, number of time steps
% 1.2. Preparation of constants and forcings
loadin_2D                  % loads in constants and forcings
init_2Dinterp

% initializes to model grid
% 1.3. Choose kw parameterisation
parameterkw=2;
% 1.4. Define compound characteristics: Henry, Henry temperature dependance
H0=7.6*10^-2;
tempdep=1200;

% 2. MAIN LOOP
for tstep=2:len
    % 2.1. single processes
    calcphotoproduction     % calculates photoproduction PP in nmol/L/s
    calcchemsink          % calulates chemical sink HY nmol/L/s
    calcairseaexchange       % calculates air sea exchange EX in nmol/m2/s
    % 2.2. combining to new concentration in recent timestep 
    EXtstep=EX.*60*dt./Dmix(:,:,tstep)./1000; % in nmol/L/dt
    dcwdt=(PP*r-HY).*60*dt-EXtstep;   % delta new production/consumption
    cwnew=cw(:,:,tstep-1)+dcwdt;                % add delta to last timestep concentration=new concentration
    cwnew(cwnew<0)=0;
	% MIXING MOMENTAN RAUS
    % 2.3. save output parameters for timestep
    BMsave               % saving of output parameters 
end

end

SaveMonths
end

disp('Integration complete')

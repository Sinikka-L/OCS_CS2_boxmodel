% MAIN PROGRAMM COS BOX MODEL
clear all
clc
close all

% define photomethod:
photomethod=6; % 6 is the only one recommended so far
% define hydrolysis method
hydrolysemethod=1; % method of hydrolysis calc: 1=elliott 1989, 2=radford-knoery 1994
% Choose kw parameterisation
parameterkw=2; % 1-Wanninkhof 1992, 2-Nightingale 2000, 3-Ho, 2006
% Define compound characteristics: Henry constant, Henry temperature dependance
H0=2.2*10^-2;
tempdep=2100;

% initializing data
inityear=1999;
endyear=2019;
initmonth=1;

for year=inityear:1:endyear

disp(year)

for month=1:12

% 1. Preparation
% 1.1. Preparation of temporal grid
dt=120;                   % time step in minutes
tstart=datenum([year, month, 1, 0, 0, 0]);    %tstart=datenum([2014, 7, 1, 0, 0, 0]); [2014, 7, 28, 3, 50, 0]  
tend=datenum([year, month, 28, 23, 59, 59]);       % tend=datenum([2014, 7, 1, 23, 59, 0]); [2014, 8, 4, 4, 30, 0]
tgrid=tstart:dt*1/(24*60):tend;                % temporal grid, in dt (Minutes), 1 minute=0.0007 in matlabtime

len=length(tgrid); 
                         % length, number of time steps
% Load & initialisation: preparation of constants and forcings
loadin_2D                  % loads in constants and forcings
init_2Dinterp              % initializes to temporal grid


% 2. MAIN LOOP
for tstep=2:len
    % 2.1. single processes
    calcphotoproduction     % calculates photoproduction PP in nmol/L/s
    calcdarkproduction      % calculates dark production DP in nmol/L/s
    calchydrolysis          % calulates hydrolysis in HY nmol/L/s
    calcairseaexchange       % calculates air sea exchange EX in nmol/m�/s
    % 2.2. combining to new concentration in recent timestep 
    EXtstep=EX.*60*dt./Dmix(:,:,tstep)./1000; % in nmol/L/dt
    dcwdt=(PP+DP-HY).*60*dt-EXtstep;   % delta new production/consumption
    cwnew=cw(:,:,tstep-1)+dcwdt;                % add delta to last timestep concentration=new concentration
    cwnew(cwnew<0)=0;
	% MIXING MOMENTAN RAUS
    % 2.3. save output parameters for timestep
    BMsave               % saving of output parameters 

end

end

SaveMonths
end


endrun={'Integration complete'};
disp(endrun)

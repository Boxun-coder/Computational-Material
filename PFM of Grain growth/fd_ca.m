%% Time Configure
time0 = clock();
out2 = fopen('area_frac.out','w');
format long;
%% Parameters
Nx = 64;
Ny = 64;
NxNy = Nx*Ny;
dx = 0.5;
dy = 0.5;
%% Simu config
nstep = 5000;
nprint = 1000;
dt = 0.005;
ttime = 0;
%% Material Parameters
mobil = 5.0;
grcoef = 0.1;
%% Generate init grain
iflag = 2;
islove = 2;
[etas,ngrain,glist] = init_grain_micro(Nx,Ny,dx,dy,iflag,isolve);
%% Evolve
eta = zeros(NxNy,1);
for istep = 1:nstep
    ttime = ttime + dt;
    for igrain = 1: ngrain
        if(glist(igrain)==1)
            eta=etas(:,igrain);
            dfdeta = free_energ_fd_ca(Nx,Ny,ngrain,etas,eta,igrain);
            eta = eta - dt*mobil*(dfdeta-grcoef*grad*eta);
            inrange=(eta>=0.9999); 
            eta(inrange)=0.9999;
            inrange=(eta<=0.0001); 
            eta(inrange)=0.0001;
            etas(:,igrain) = eta;
            grain_sum = sum(eta)/NxNy;
            if(grain_sum<0.001) 
                glist(igrain)=0;
                fprintf('grain:%5d is eliminated\n',igrain);
            end
        end
    end
    
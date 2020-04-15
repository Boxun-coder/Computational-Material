%% Parameters
dt = 0.005;
nstep = 10000;
Nx = 60;
Ny = 60;
L = 0.5;
A = 0.0001;
B = 0.005;
k = 2;
%% Configuration
D = rand(Nx,Ny);
Record = cell(nstep/10000);
free_energy = zeros(nstep,1);
%% Iteration
for istep = 1 : nstep
    free_energy(istep) = free_energ(D,A,B);
    D = deta_dt(D,dt,A,B,L,k);
    if(mod(istep,10000)==0)
        Record{istep/10000} = D;
    end
end
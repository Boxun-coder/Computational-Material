function [etas,ngrain,glist] = init_grain_micro(Nx,Ny,dx,dy,iflag,isolve)
%INIT_GRAIN_MICRO Summary of this function goes here
%   Detailed explanation goes here
if (iflag==2)
    in = fopen('grain_25.inp','r');
end
if (iflag==1)
    ngrain = 2;
    x0 = Nx/2;
    y0 = Ny/2;
    radius = 14;
    for i = 1:Nx
        for j = 1:Ny
            ii = (i-1)*Nx + j;
            
end
end

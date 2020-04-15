dx = 1;
dy = 1;
nstep = 600;
dt = 0.2;
nprint = 200;
Nx = 128;
Ny = 128;
ncount = 0;
%-- Init Grid
u0 = zeros(Nx,Ny);
u0(60:68,60:68) = 10;

%-- Begin
time0 = clock();
for istep = 1:nstep
    for i = 2:Nx-1
        for j = 2:Ny-1
        u0(i,j) = u0(i,j) + dt*((u0(i+1,j)+u0(i-1,j)-2*u0(i,j))/dx^2 ...
            + (u0(i,j+1)+u0(i,j-1)-2*u0(i,j))/dy^2 ...
            );
        end
    end
    if((mod(istep,nprint)==0) ||(istep==1))
       ncount = ncount + 1 ;
       subplot(2,2,ncount);
       imagesc(u0);
       time=sprintf('%d',istep);
       title(['time=' time]);
       xlabel('x');
       ylabel('y');
    end
end
compute_time = (etime(clock(),time0));

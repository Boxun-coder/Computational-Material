%% Get Initial Wall Time
time0 = clock();
format long;
out2 = fopen('time_energ.out','w');
%% Parameters
Nx = 64;
Ny = 64;
NxNy = Nx*Ny;
dx = 1;
dy = 1;
%% Time intergration Parameter
nstep = 10000;
nprint = 50;
dt = 1e-2;
ttime = 0;
%% Material Configuation
c0 = 0.4;
mobility = 1;
grad_coef = 0.5;
%% Prepare Microstructure
iflag = 1;%Set iflag = 1 for un-optimized mode,
          %iflag = 2 for optimized mode.
[con] = micro_ch_pre(Nx,Ny,c0,iflag);
energ = zeros(nstep,1);
%% Evolve
for istep = 1:nstep
    ttime = ttime + dt;
    for i = 1:Nx
        for j = 1:Ny
            jp = j+1; jm = j-1;
            ip = i+1; im = i-1;
            if(im==0) im=Nx; end
            if(ip==(Nx+1)) ip=1; end
            if(jm==0) jm=Ny;end
            if(jp==(Ny+1)) jp=1; end
            %Set Periodic B.C.
            hne = con(ip,j);
            hnw = con(im,j);
            hnn = con(i,jp);
            hnc = con(i,j);
            hns = con(i,jm);
            lap_con(i,j) = (hnw+hns+hnn+hne-4*hnc)/dx/dy;
            % Derivative of Free energy
            [dfdcon] = free_energ_ch_v1(i,j,con);
            dummy(i,j)=dfdcon - grad_coef*(lap_con(i,j));
            end %end j
        end %end i
        
        for i = 1:Nx
        for j = 1:Ny
            jp = j+1; jm = j-1;
            ip = i+1; im = i-1;
            if(im==0) im=Nx; end
            if(ip==(Nx+1)) ip=1; end
            if(jm==0) jm=Ny;end
            if(jp==(Ny+1)) jp=1;end
            %Set Periodic B.C.
            hne = dummy(ip,j);
            hnw = dummy(im,j);
            hnn = dummy(i,jm);
            hnc = dummy(i,j);
            hns = dummy(i,jp);
            lap_dummy(i,j) = (hnw+hns+hnn+hne-4*hnc)/dx/dy;
            % Derivative of Free energy
            [dfdcon] = free_energ_ch_v1(i,j,con);
            dummy(i,j)=dfdcon - grad_coef*(lap_con(i,j));
            
            %   Time intergration
            con(i,j) = con(i,j) +dt*mobility*...
                lap_dummy(i,j);
            %   For small derivatives
            if(con(i,j)>0.9999) con(i,j)=0.9999; end
            if(con(i,j)<0.00001) con(i,j)=0.00001; end
            end
        end
    %Print Result
    if((mod(istep,nprint)==0)||(istep==1))
        fprintf('done step:%5d\n',istep);
    %Calculate total energy
    energ(istep) = calculate_energ(Nx,Ny,con,grad_coef);
    fprintf(out2,'%14.6e %14.6e\n',ttime,energ(istep));
    write_vtk_grid_values(Nx,Ny,dx,dy,istep,con);    
    end
end
compute_time = etime(clock(),time0);
fprintf('Compute Time: %10d\n',compute_time);

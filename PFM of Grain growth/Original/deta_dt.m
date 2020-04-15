function [D_tmp] = deta_dt(D,dt,A,B,L,k)
%DETA_DT Calculates the partial deriative
    Nx = size(D,1);
    Ny = size(D,2);
    D_tmp = D;
    for i = 1 : Nx
        for j = 1:Ny
            ip = i+1; im = i-1;
            jp = j+1; jm = j-1;
            if(ip==Nx+1) ip=1; end 
            if(im==0) im=Nx; end
            if(jp==Ny+1) jp=1; end 
            if(jm==0) jm=Ny; end
            dvgc = D(ip,j)+D(im,j)+D(i,jm)+D(i,jp) - 4*D(i,j);
            D_tmp(i,j) = -dt*L*(-A*D(i,j)+B*D(i,j)^3+2*D(i,j)*(sum(sum(D.^2))-D(i,j)^2)-k*dvgc);
        end
    end
end


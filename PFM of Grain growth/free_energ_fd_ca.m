function [dfdeta] = free_energ_fd_ca(Nx,Ny,ngrain,etas,eta,igrain)
%FREE_ENERG_FD_CA Summary of this function goes here
%   Detailed explanation goes here
A = 1;
B = 1;
NxNy = Nx*Ny;
sum = zeros(NxNy,1);
for jgrain = 1:ngrain
    if(jgrain~=igrain)
        sum = sum + etas(:,jgrain).^2;
    end
end
    dfdeta = A*(2*B*eta.*sum+eta.^3-eta);
end


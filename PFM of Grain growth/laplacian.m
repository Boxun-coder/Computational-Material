function [grad] = laplacian(nx,ny,dx,dy)
%LAPLACIAN Summary of this function goes here
%   Detailed explanation goes here
    nxny = nx*ny;
    r = zeros(1,nx);
    r(1:2) = [2,-1];
    T = toeplitz(r);
    E = speye(nx);
    grad=-(kron(T,E)+kron(E,T));
    for i=1:nx
        ii = (i-1)*nx+1;
        jj = ii+nx-1;
        grad(ii,jj)=1;
        grad(jj,ii)=1;

        kk=nxny-nx+i;
        grad(i,kk)=1;
        grad(kk,i)=1;
    end
    grad = grad/(dx*dy);
end


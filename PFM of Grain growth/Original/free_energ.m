function [energ]=free_energ(D,A,B,k)
%%Takes domain as input
    energ = 0;
    Nx = size(D,1);
    Ny = size(D,2);
    for i = 1:Nx
        for j = 1:Ny
            energ = energ - A/2 * D(i,j)^2 ...
            + B/4 * D(i,j)^4;
        end
    end
end
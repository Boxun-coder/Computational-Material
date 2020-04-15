function [] = write_vtk_grid_values(Nx,Ny,dx,dy,istep,data1)
fname=sprintf('time_%d.vtk',istep);
out = fopen(fname,'w');
Nz = 1;
npoin = Nx*Ny*Nz;
fprintf(out,'# vtk DataFile Version 2.0\n');
fprintf(out,'time_10.vtk\n');
fprintf(out,'ASCII\n');
fprintf(out,'DATASET STRUCTURED_GRID\n');
fprintf(out,'DIMENSIONS %5d %5d %5d\n',Nx,Ny,Nz);
fprintf(out,'POINTS %7d float\n',npoin);
for i=1:Nx
    for j=1:Ny
        x = (i-1)*dx;
        y = (j-1)*dy;
        z = 0;
        fprintf(out,'%14.6e %14.6e %14.6e',x,y,z);
    end
end
% Write Grid values
fprintf(out,'POINT_DATA %5d\n',npoin);
fprintf(out,'SCALARS CON float 1\n');
fprintf(out,'LOOKUP_TABLE default\n');
for i=1:Nx
    for j=1:Ny
        ii=(i-1)*Nx+j;
        fprintf(out,'%14.6e\n',data1(i,j));
    end
end
fclose(out);
end


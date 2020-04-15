function [dfdcon] = free_energ_ch_v1(i,j,con)
%FREE_ENERG_CH_V1 Summary of this function goes here
%   Detailed explanation goes here
A =1;
dfdcon = A*(2*con(i,j)*(1-con(i,j))^2-2*con(i,j)^2*(1-con(i,j)));
end


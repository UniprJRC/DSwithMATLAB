% meshgrid(1:3) 
% 
% [x,y]=meshgrid(1:3)
% 
% x =
% 
%           1.00          2.00          3.00
%           1.00          2.00          3.00
%           1.00          2.00          3.00
% 
% 
% y =
% 
%           1.00          1.00          1.00
%           2.00          2.00          2.00
%           3.00          3.00          3.00


% meshgrid builds the grid of points
[x,y] = meshgrid(-2:0.1:2);
% Compute z on the grid
z = exp(-x.^2 - y.^2);
% Plot the surface
mesh(z)

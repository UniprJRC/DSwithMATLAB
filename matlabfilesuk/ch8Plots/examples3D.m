
% Mesh 
mesh(peaks)

%% Mesh with contours
meshc(peaks)

%% Contours
contour(peaks)

%% Shaded 3D surface
surf(peaks)

%% 
[x,y]=meshgrid(-4:0.1:4)
z=x.^2-y.^2;
mesh(x,y,z)

%% Mesh with contours
meshc(x,y,z)

%% Contours
contour(x,y,z)

%% Shaded 3D surface
surf(x,y,z)

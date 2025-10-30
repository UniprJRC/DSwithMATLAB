
%% Mesh 
mesh(peaks)

%% Shaded 3D surface
surf(peaks)

%% Contours
contour(peaks)

%% Mesh with contours
meshc(peaks)


%% 
[x,y]=meshgrid(-4:0.1:4)
z=x.^2-y.^2;
mesh(x,y,z)

%% Mesh with contours
meshc(x,y,z)

%% Contours
contour(x,y,z)

%% Shaded 3D surface with contours
surfc(x,y,z)

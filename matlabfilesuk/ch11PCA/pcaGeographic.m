%% Ex with lat e long
load citiesItaly2024.mat
% Retrieve Latitude and Longitude of each province
LatLong=citiesItaly2024.Properties.UserData{2};
% Call to pcaFS with options 'Latitude' and 'Longitude'
out=pcaFS(citiesItaly2024,'Latitude',LatLong(:,1),'Longitude',LatLong(:,2));

%% Ex with shape
load citiesItaly2024.mat
% Retrieve Shape file
ShapeFile=citiesItaly2024.Properties.UserData{1};
% Call to pcaFS with option 'ShapeFile' 
out=pcaFS(citiesItaly2024,'ShapeFile',ShapeFile);



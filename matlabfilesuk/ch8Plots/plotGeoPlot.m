load citiesItaly2024.mat
X=citiesItaly2024;
disp(X.Properties.UserData)

% Extract the geospatial data from the loaded table
GT = X.Properties.UserData{1};
% GT is geotable 
% isgeotable(GT) produce true

% mapping toolbox must be installed
geoplot(GT,'ColorVariable','COD_REG')
geobasemap('darkwater')

%% geoplot with  Name,Value 'ColorVariable'
GT1=[GT citiesItaly2024];
% tiledlayout(1,4); in the book
tiledlayout('flow')
sel=["Bankrup"    "UrbanFra" "SalaryA"  "SpendingA"];
maptype={'colorterrain' 'bluegreen' 'landcover' 'none'};
for j=1:length(sel)
    nexttile
    geoplot(GT1,'ColorVariable',sel(j))
    title(sel(j))
    colorbar
    geobasemap(maptype{j})
end

%% geoplotFS
geoplotFS(citiesItaly2024,2,GT)

%% Alternative way of calling  geoplotFS
geoplotFS(citiesItaly2024, "ElecPar", GT);
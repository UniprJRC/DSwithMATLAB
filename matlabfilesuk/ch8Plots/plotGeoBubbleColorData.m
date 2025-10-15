% Load flyer distribution data
leaflets=readtable("leaflets.csv");
% Convert building type to categorical for 'ColorData'
leaflets.building=categorical(leaflets.building);
summary(leaflets)
totflyer = sum(leaflets.nleaflets);
geobubble(leaflets.Y, leaflets.X, leaflets.nleaflets,'Basemap','streets','ColorData',leaflets.building)
title('Flyer Distribution Map');
set(gca,'FontSize',15)


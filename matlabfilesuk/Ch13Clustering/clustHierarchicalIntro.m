%% Input preparation
% Vector containing the elements above the main diagonal of the
% distance matrix (see slides)
distanze=[13.123 2.506 17.060 15.628 4.391 19.542];
labels={'1:A', '2:B', '3:C', '4:D'};

%% Clustering with the single linkage method and dendrogram
out=linkage(distanze,'single');
% dendrogram(out);

dendrogram(out,'Labels',labels)
title('Dendrogram based on the single linkage method')
ylabel('Distance levels at which aggregation occurs')

%% Clustering with the complete linkage method and dendrogram
out=linkage(distanze,'complete');
% dendrogram(out);
dendrogram(out,'labels',labels);
title('Dendrogram based on the complete linkage method')
ylabel('Distance levels at which aggregation occurs')

%% Clustering with the average linkage method and dendrogram
out=linkage(distanze,'average');
dendrogram(out);
title('Dendrogram based on the average linkage method')
ylabel('Distance levels at which aggregation occurs')

%% Example: 5 car models
% Vector containing the elements above the main diagonal of the
% distance matrix (see slides)
distanze=[10.842 3.384 2.888 9.146 13.777 12.646 6.356 2.137 12.081 10.950];
labels={'1:PUNTO', '2:BRAVO', '3:FIESTA', '4:CORSA', '5:GOLF'};

%% Clustering with the single linkage method and dendrogram
out=linkage(distanze,'single');
dendrogram(out,'labels',labels);
title('Dendrogram based on the single linkage method')

%% Clustering with the complete linkage method and dendrogram
out=linkage(distanze,'complete');
dendrogram(out,'labels',labels);
title('Dendrogram based on the complete linkage method')

%% Cutting the dendrogram
cutoff=8;
% To build a customized dendrogram with different colors depending
% on the threshold
dendrogram(out,'ColorThreshold',cutoff,'Orientation','left');
ylabel('Dendrogram cut at distance threshold 8')

% Cutting the dendrogram and allocating units to different groups
idx=cluster(out,'cutoff',cutoff,'Criterion','distance');

disp(idx)
% Comment: units 1, 3, and 4 (Punto, Fiesta, and Corsa) form one group.
% The other two units, 2 and 5 (Bravo and Golf), form another group.

% Display unit labels and group membership
disp(strcat(num2str(idx),'--',labels'))

%% New MATLAB 2024b option
% ShowCut (true/false)
cutoff=4;
dendrogram(out,'labels',labels,'ColorThreshold',cutoff, ...
    'ShowCut',true);

%% New MATLAB 2024b options
% 'ShowMarkers', true, 'ClusterIndices', idx
% Units appear with a different symbol and color depending on the group
% they belong to
idx=cluster(out,'cutoff',cutoff,'Criterion','distance');
dendrogram(out,'labels',labels,'ColorThreshold',cutoff, ...
    'ShowCut',true,'ShowMarkers',true,'ClusterIndices',idx);

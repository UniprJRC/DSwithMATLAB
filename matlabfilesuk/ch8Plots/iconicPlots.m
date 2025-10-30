% stars
load citiesItaly.mat
X=citiesItaly{:,:};
sel=[1:3 5];
X(:,sel)=-X(:,sel); % change sign addedval, deposit, pension, export
glyphplot(X,'obslabels',citiesItaly.Properties.RowNames)

%% faces
load citiesItaly.mat
X=citiesItaly{:,:};
sel=[4 6 7];
X(:,sel)=-X(:,sel); % change sign unemploy, bankrup, billsoverd
glyphplot(X,'obslabels',citiesItaly.Properties.RowNames,'glyph','face')


%% Load the fisheriris dataset
load fisheriris

% The matrix meas contains measurements for 150 iris flowers
% Create a glyph plot using the iris measurements
glyphplot(meas,'glyph','face')

% Add a title to the plot
title("Glyph Plots for Iris Data")


% Create a customized face plot
glyphplot(meas, 'Glyph', 'face', 'Features', 1:4)

% Add a title to the plot
title("Customized Chernoff Face Plot for Iris Data")
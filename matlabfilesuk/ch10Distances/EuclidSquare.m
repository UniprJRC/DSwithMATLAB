% Data input
X=[3 20;10 42;8 30; 2 12];

% Calculation of the matrix of squared
% Euclidean distances.
D=squareform(pdist(X,'squaredeuclidean'));
disp(D)


%% Weighted metric space
% Data input
X=[3 20;10 42;8 30; 2 12];
% Calculation of the Euclidean distance matrix on
% standardized deviations
% Using the 'seuclidean' option
dist=pdist(X,'seuclidean');
% Preliminary standardization of the variables
distchk=pdist(zscore(X));
assert(max(abs(dist-distchk))<1e-12,"Programming error")
D=squareform(dist);
disp(D)

%% Euclidean distance on robustly standardized data
% Robust MAD estimates of sigma
% norminv(0.75) is the exact value for the correction factor 1.4826
MADs=mad(X,1)/norminv(0.75);
% If the second input argument is 'seuclidean', it is possible to specify
% how the variables should be standardized
dist=pdist(X,'seuclidean',MADs);
% In the following instruction, work directly on robustly
% standardized deviations
distchk=pdist(zscoreFS(X));
assert(max(abs(dist-distchk))<1e-12,"Programming error in " + ...
    "calculation of Euclidean distances on the matrix of " + ...
    "robustly standardized deviations")


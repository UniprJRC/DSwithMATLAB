
% opzione TreatAsMissing di readtable
X=readtable('messyFS.csv','TreatAsMissing',{'NA', 'NaN'})
% funzione standardizeMissing
X1=standardizeMissing(X,-99)

% https://it.mathworks.com/help/matlab/preprocessing-data.html
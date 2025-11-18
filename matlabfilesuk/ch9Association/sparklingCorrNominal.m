%% Data loading
X = readtable('sparklingWine.xlsx', 'Sheet','data','range','A1:R107','ReadRowNames',true);

% Original contingency table
Ntable=pivot(X,"Rows","Taste","Columns","FoodPairing","RowLabelPlacement","rownames");
disp(Ntable)

%% Compute all indices and their confidence intervals
out=corrNominal(Ntable);

%% corrNominal with  'name',value ,'datamatrix',true
 out=corrNominal([X.Taste X.FoodPairing],'datamatrix',true);

%% corrNominal with  'name',value ,'datamatrix',true and plots 1
outCHK=corrNominal(X(:,["Taste" "FoodPairing"]),'datamatrix',true,'plots',1);

%% Option plots
 out=corrNominal([X.Taste X.FoodPairing],'datamatrix',true,'plots',true);


yX=readtable("exampleC.xlsx",ReadRowNames=true);
vNames=yX.Properties.VariableNames;    
XX=yX{:,:};

R=corr(XX);

% Rtable= Correlation matrix in table format
Rtable = array2table(R, 'VariableNames', vNames, 'RowNames', vNames);
disp('Correlation matrix in table format')
disp(Rtable)


% Rptable= Partial correlation matrix in table format
Rp=partialcorr(XX);
% Rp in table format
RpTable = array2table(Rp, 'VariableNames', vNames, 'RowNames', vNames);
disp('Partial correlation matrix in table format')
disp(RpTable)

out=fitlm(XX(:,2:3),XX(:,1),"linear","VarNames",vNames([2:3 1]));
% Display the results of the linear model
% Display the summary of the linear model
disp(out);



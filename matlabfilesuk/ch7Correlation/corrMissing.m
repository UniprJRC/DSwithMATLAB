Xtable = readtable('tagliatelle.xlsx','Sheet','Data','Range','A1:C41');
X = Xtable{:,:};
% Listwise deletion
[~, pvalRhoList] = corr(X,'type','Spearman','rows','complete');
% Pairwise deletion
[~, pvalRhoPair] = corr(X,'type','Spearman','rows','pairwise');
names = Xtable.Properties.VariableNames;
pvalListT = array2table(pvalRhoList,'RowNames',names,'VariableNames',names);
pvalPairT= array2table(pvalRhoPair,'RowNames',names,'VariableNames',names);

disp('Spearman p-values (listwise deletion)')
disp(pvalListT)
disp('Spearman p-values (pairwise deletion)')
disp(pvalPairT)
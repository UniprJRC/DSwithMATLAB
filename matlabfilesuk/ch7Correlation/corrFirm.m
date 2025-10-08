Xtable = readtable("Firm.xlsx", "ReadRowNames", true);
vars   = ["Wage" "CommutingTime" "SmartWorkHours" "Seniority"];
X      = Xtable{:, vars};
[n,p]  = size(X);

% Compute correlation matrix and p-values via built-in
[R, Pval] = corr(X);

% Manual computation of test statistics
Tstat = (R ./ sqrt(1 - R.^2)) * sqrt(n-2);

% Manual two-sided p-values
Pval_manual = tcdf(abs(Tstat), n-2, 'upper') * 2;
% Set diagonal to 1
Pval_manual = Pval_manual + eye(p);

Pval_table = array2table(Pval, "RowNames", vars, "VariableNames", vars);
disp("Table of p-values:")
disp(Pval_table)

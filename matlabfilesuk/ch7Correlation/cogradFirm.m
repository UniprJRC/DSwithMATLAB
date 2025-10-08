% Load data
Xtable = readtable("Firm.xlsx","ReadRowNames",true);
nomiq   = ["Wage" "CommutingTime" "SmartWorkHours" "Seniority"];
X       = Xtable{:,nomiq};

% Spearman correlation and p-values
[Rho, Pvalrho] = corr(X,'Type','Spearman');
Rhot          = array2table(Rho,     "RowNames",nomiq,"VariableNames",nomiq);
Pvalrhot      = array2table(Pvalrho,"RowNames",nomiq,"VariableNames",nomiq);

disp('Spearman rank-correlation matrix:')
disp(Rhot)
disp('Spearman p-value matrix:')
disp(Pvalrhot)
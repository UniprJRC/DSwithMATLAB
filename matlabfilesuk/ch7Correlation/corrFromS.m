%% Load data
Xtable = readtable("Firm.xlsx", "ReadRowNames", true);
nomiq   = ["Wage" "CommutingTime" "SmartWorkHours" "Seniority"];
X       = Xtable{:, nomiq};
% Deviations from the mean
Xtilde  = X - mean(X);
% Standardized deviations
Z       = Xtilde ./ std(X);

n = size(X,1);
%% Covariance matrix S
S      = cov(X);
Schk   = (Xtilde' * Xtilde) / (n-1);
Stable = array2table(S, "RowNames", nomiq, "VariableNames", nomiq);
disp('Covariance matrix as table')
disp(Stable)

%% Correlation matrix R
R      = corr(X);
Rchk   = (Z' * Z) / (n-1);
Rtable = array2table(R, "RowNames", nomiq, "VariableNames", nomiq);
disp('Correlation matrix as table')
disp(Rtable)

%% Compute correlation matrix from S

% Method 1: double loop
p = size(X,2);
Rchk1 = zeros(p,p);
for i = 1:p
    for j = 1:p
        Rchk1(i,j) = S(i,j) / sqrt(S(i,i)*S(j,j));
    end
end

% Method 2: matrix formula
sigmas = sqrt(diag(S));
D      = diag(sigmas);
invD   = D^-1;
Rchk2  = invD * S * invD;
%% Data loading
X = readtable("toothpaste.xlsx","Range","A1:B1577","Sheet","data");

% Crosstab call
[N, chi2, pval, labels] = crosstab(X{:,1},X{:,2});
disp(['Chi2 from crosstab: ' num2str(chi2)])
disp(['p-value from crosstab: ' num2str(pval)])

% Dimensions and total
[I,J] = size(N);
n     = sum(N,"all");

% Contingency table in table format
Ntable = array2table(N,  "RowNames",      labels(1:I,1),  "VariableNames", labels(1:J,2));
disp(Ntable)

% Manual Chi2
Ntheo  = sum(N,2)*sum(N,1)/n;
chi2chk= sum(((N-Ntheo).^2)./Ntheo,'all');

% Manual p-value
pvalchk = chi2cdf(chi2chk,(I-1)*(J-1),'upper');

% Phi and Cramer V
Phi = sqrt(chi2/n);
V   = Phi/sqrt(min([I-1,J-1]));
disp(['Cramer''s V: ' num2str(V)])

%% Part not in the book
% Ntable based on pivot function
NtableCHK=pivot(X,"Rows","Toothpaste","Columns","Region",'RowLabelPlacement','rownames');

NtableCHKwithTOT=pivot(X,"Rows","Toothpaste","Columns","Region",'RowLabelPlacement','rownames','IncludeTotals',true);

%% Back in the book
Ntheo=sum(N,2)*sum(N,1)/n;
chi2chk=sum(((N-Ntheo).^2)./Ntheo,'all');

% Manual computation
pvalchk=chi2cdf(chi2chk,(I-1)*(J-1),'upper');

assert(isequal(chi2,chi2chk),"L'implementazione di chi2 è diversa")
assert(isequal(pval,pvalchk),"L'implementazione del pvalue di chi2 è diversa")

% Index  Phi
Phi=sqrt(chi2/n);

%  Cramer V
V=Phi/sqrt(min([I-1 J-1]));
disp(['Cramer index: ' num2str(V)])

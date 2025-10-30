rng(10)
n=100;
p=9;
X=zeros(n,p);
X(:,1)=randn(n,1);
sigma=0.2;

for j=2:5
    X(:,j)=2+5*X(:,1)+sigma*randn(n,1);
end

for j=6:9
    X(:,j)=2-5*X(:,1)+sigma*randn(n,1);
end

%% Plot
parallelplot(X)

%% If input is a table
parallelplot(array2table(X))


% print -depsc coordinatepar.eps;
% parallelcoords(zscore(X))
%%  Dataset Firm.xlsx 
Xt=readtable("Firm.xlsx","ReadRowNames",true);
parallelplot(Xt,'CoordinateVariables',["Education" "Wage" ...
    "Seniority" "CommutingTime" "SmartWorkHours"], ...
    "GroupVariable","Education")

% print -depsc coordinateparFirm.eps;

%% Dataset fisheriris 
load fisheriris.mat
nr=2; nc=1;
subplot(nr,nc,1)
labels = {'Sepal Length','Sepal Width','Petal Length','Petal Width'};
parallelcoords(meas,'Group',species,'Labels',labels)

subplot(nr,nc,2)
parallelcoords(meas,'Group',species,'Labels',labels, ...
    'quantile',.05,'LineWidth',2)

% print -depsc coordinateparIris.eps;
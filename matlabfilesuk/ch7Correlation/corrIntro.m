%% Example 0
% X1 =number of employees
% X2= sales (in millions)
X=[10 1.9
18 3.1
20 3.2
8 1.5
30 6.2
12 2.8
14 2.3];

scatter(X(:,1),X(:,2),'filled')
mea=mean(X);
xline(mea(1))
yline(mea(2))

%% GUI for covariance 
GUIcov(X(:,1),X(:,2))

%% GUI for correlation
GUIcorr(X(:,1),X(:,2))

%% Data loading
X=readtable("Firm.xlsx","ReadRowNames",true);


%% Scatter with first argument a table
scatter(X,"Seniority","Wage")
% print -depsc figs\scatterSenWag.eps;

%% Scatter with doubles
scatter(X.Seniority,X.Wage)
xlabel("Seniority")
ylabel("Wage")


%% Scatter with doubles
scatter(X{:,"Seniority"},X{:,"Wage"})
xlabel("Seniority")
ylabel("Wage")

%% Scatter with doubles and column numbers
scatter(X{:,9},X{:,6})
xlabel("Seniority")
ylabel("Wage")


%% Scatter with axes through the means

scatter(X{:,9},X{:,6})
medie=mean(X{:,[9 6]});
xline(medie(1))
yline(medie(2))

xlabel("Seniority")
ylabel("Wage")

%% Correlation
rxy=corr(X.Seniority,X.Wage);
disp(rxy)

covMatrix=cov(X.Seniority,X.Wage);
rxychk=covMatrix(1,2)/sqrt(var(X.Seniority)*var(X.Wage));








%% Data loading
myfile = "Firm.xlsx";
X = readtable(myfile, "ReadRowNames", true);

%% Plot 99% confidence intervals by education level
conflevc = 0.01; % complement of the confidence level
[means, stderr, nobs, grpNames] = grpstats(X.Wage, X.Education, conflevc);

%% Statistics for the overall sample
% Define statistics of interest
statNames = ["mean" "std" "meanci"];
% Variables of interest
vars = ["Wage" "Seniority"];

XtabOverall = grpstats(X, [], statNames, ...
    "DataVars", vars, 'Alpha', conflevc);
disp(XtabOverall(:,1:7))


%% Statistics for subgroups
groupingVARS = {'Gender', 'Education'};

Xtab = grpstats(X, groupingVARS, statNames, ...
    "DataVars", vars, 'Alpha', conflevc);
disp(Xtab(:,1:6))

%% bar plot
bar(Xtab.Properties.RowNames,Xtab.mean_Wage)

%% From Xtab the pivot table

pivot(Xtab,Rows="Gender",Columns="Education",DataVariable="mean_Wage", ...
    Method="none",RowLabelPlacement="rownames")


%% Boxplot for Gender and Education (call to boxplot)
figure
GenEdu=string(X.Gender)+string(X.Education);
% The following instruction is used to set the x-axis order of the
% levels determined by unique(GenEdu), i.e., levels in alphabetical order
GenEduc=categorical(GenEdu,unique(GenEdu));
boxplot(X.Wage,GenEduc);
ylabel('Wage')
% print -depsc boxplotFMABC.eps;

%% Boxplot for Gender and Education (call to boxchart)
figure
boxchart(categorical(X.Gender),X.Wage,'GroupByColor',X.Education);
ylabel('Wage')
legend
% print -depsc boxchartFMABC.eps;


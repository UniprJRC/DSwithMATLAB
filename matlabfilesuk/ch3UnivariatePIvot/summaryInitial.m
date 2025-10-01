%% Data loading
myfile = "Firm.xlsx";
Xt = readtable(myfile, "ReadRowNames", true);

% Display the first 5 records of the table
head(Xt, 5);

summary(Xt)

%% Setting variable types

% Define the variable Gender as qualitative nominal 
% (categorical without order among the categories)
Xt.Gender = categorical(Xt.Gender);

% Define the variable Education as qualitative ordinal 
% (categorical with order among the categories)
Xt.Education = categorical(Xt.Education, 'Ordinal', true);
summary(Xt(:,1:6))

%% Frequency distributions (categorical variables)
disp('Frequency distribution of variable Education')
tabulate(Xt.Education)

disp('Frequency distribution of variable Gender')
tabulate(Xt.Gender)

%% Mode for qualitative nominal variables
disp('Mode value of the variable Gender')
mode(Xt.Gender)

%% Median for qualitative ordinal variables
disp('Median value of the variable Education')
median(Xt.Education)

%% GUI that shows the calculation of the 0.7 quantile in an ordinal variable
GUIquantile(Xt.Education, 0.7)
% print -depsc GUIquantile.eps;


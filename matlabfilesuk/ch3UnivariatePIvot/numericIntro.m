%% Data loading
miofile="Firm.xlsx";
Xt=readtable(miofile,"ReadRowNames",true);
Xt.Gender = categorical(Xt.Gender);
Xt.Education=categorical(Xt.Education,{'A','B','C'},'Ordinal',true');

% Extract quantitative variables into the array Xdq and the table Xtq
% Note: Xdq is a 107x4 numeric matrix
%       Xtq is a 107x4 table of only the quantitative variables
nomiq = ["Wage" "CommutingTime" "SmartWorkHours" "Seniority"];
Xdq   = Xt{:, nomiq};
Xtq   = Xt(:, nomiq);

% Format numeric display with two decimal places
format bank

%% Compute sample means (applying mean directly to the table)
means = mean(Xtq);
disp('Sample means (mean applied directly to the table)')
disp(means)

%% Compute sample medians
disp('Sample medians')
medians = median(Xtq);
disp(medians)

%% Compute sample standard deviations and coefficients of variation
scorr = std(Xtq);
disp('Coefficients of variation (CV)')
cvt   = scorr ./ abs(means);
disp(cvt)

%% Compute skewness indices
disp('Skewness indices (calculated via skewness)')
% The second argument 0 requests the unbiased version
sk = skewness(Xdq, 0);
skT = array2table(sk, "VariableNames", nomiq);
disp(skT)

%% Compute kurtosis indices
disp('Kurtosis indices (calculated via kurtosis)')
% The second argument 0 requests the unbiased version
kur = kurtosis(Xdq, 0);
kurT = array2table(kur, "VariableNames", nomiq);
disp(kurT)

%% Histogram plot of a quantitative variable
% Below are listed several ways in which the histogram function 
% can be called when dealing with a quantitative variable
close all
histogram(Xt.Wage)

histogram(Xt.Wage,10)

histogram(Xt.Wage,2000:500:4500)

histogram('BinEdges',2000:500:3500,'BinCounts',[20 10 12])

%% Histogram plot of a categorical variable
% Below are listed several ways in which the histogram function 
% can be called when dealing with a categorical variable

histogram(Xt.Education)

histogram(Xt.Education,'Categories',{'B','C'})

histogram('Categories',{'Si','No','Forse'},'BinCounts',[22 18 3])

% histogram with 'Name',Value
histogram(Xt.Education,'BarWidth',0.99)

% histogram with syntax Name=Value
histogram(Xt.Education,BarWidth=0.99)

% With output 
NoName=histogram(Xt.Education,'BarWidth',0.5);

% Change color
NoName.FaceColor='r';

% Change orientation
NoName.Orientation="horizontal";